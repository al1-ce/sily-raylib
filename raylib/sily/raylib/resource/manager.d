module sily.raylib.resource.manager;

import std.file: isDir, exists;
import std.path: isValidPath, buildNormalizedPath, dirSeparator;
import std.string: toStringz;

import sily.path: fixPath;

import sily.raylib.log;

import raylib;

private string _pathBase = ".";
private string makePath(string path) {
    return _pathBase ~ dirSeparator ~ path;
}

/++
Sets base path for all resources (like res:// in godot).

Must be relative path (to executable) and without directory
separator (`/` for unix and `\` for windows)
+/
void setResourcePath(string path) {
    if (path.isValidPath && path.isDir && path.exists) {
        path = path.buildNormalizedPath;
        _pathBase = path;
    } else {
        log!WARNING("Path \"" ~ path ~ "\" is incorrect path for resource path base.");
    }
}

private T nopath(T)(string path) {
    log!WARNING("Resource at path \"" ~ path ~ "\" does not exist.");
    return T.init;
}

private struct ResourceType(RS) {
    extern(C) RS function(const(char)*) @nogc nothrow _loadFunc;
    extern(C) void function(RS) @nogc nothrow _unloadFunc;
    RS[string] _cache;
}

private auto _modelResource     = ResourceType!Model(&LoadModel, &UnloadModel);
private auto _textureResource   = ResourceType!Texture(&LoadTexture, &UnloadTexture);
private auto _imageResource     = ResourceType!Image(&LoadImage, &UnloadImage);
private auto _fontResource      = ResourceType!Font(&LoadFont, &UnloadFont);
private auto _waveResource      = ResourceType!Wave(&LoadWave, &UnloadWave);
private auto _soundResource     = ResourceType!Sound(&LoadSound, &UnloadSound);
private auto _musicResource     = ResourceType!Music(&LoadMusicStream, &UnloadMusicStream);

/// Load resource from path or from cache if available
T load(T)(string path) if (!isSpecial!T) {
    string fp = path.makePath;
    if (!fp.exists) return nopath!T(fp);
    ResourceType!T* ptr = getResourcePtr!T;
    if ((path in (*ptr)._cache) is null) {
        T res = (*ptr)._loadFunc(fp.toStringz); 
        cache!T(path, res);
        return res;
    } else {
        return (*ptr)._cache[path];
    }
}

/// Caches resource in memory. To remove use uncache
void cache(T)(string path, T res) if (!isSpecial!T) {
    ResourceType!T* ptr = getResourcePtr!T();
    if ((path in (*ptr)._cache) !is null) unload!T(path);
    (*ptr)._cache[path] = res;
}

/// Removes cached resource and unloads it
void unload(T)(string path) if (!isSpecial!T) {
    ResourceType!T* ptr = getResourcePtr!T();
    if ((path in (*ptr)._cache) !is null) {
        (*ptr)._unloadFunc((*ptr)._cache[path]); 
        (*ptr)._cache.remove(path);
    }
}
/// Ditto
alias uncache = unload;

/// Returns amount of cached resources of type T
size_t cacheSize(T)() if (!isSpecial!T) {
    ResourceType!T* ptr = getResourcePtr!T();
    return (*ptr)._cache.length;
}

/// Rehashes cache so it's faster to look up
void rehashCache(T)() if (!isSpecial!T) {
    ResourceType!T* ptr = getResourcePtr!T;
    (*ptr)._cache = (*ptr)._cache.rehash;
}

/// Unloads and clears cache for given resource
void clearCache(T)() if (!isSpecial!T) {
    ResourceType!T* ptr = getResourcePtr!T;
    foreach (key; (*ptr)._cache.keys) {
        (*ptr)._unloadFunc((*ptr)._cache[key]); 
    }
    (*ptr)._cache = null;
}


private ResourceType!T* getResourcePtr(T)() if (!isSpecial!T) {
    static if (is(T == Image)) {
        return &_imageResource;
    } else {
        log!FATAL("Unknown resource type \"" ~ T.stringof ~ "\".");
        assert(0);
    }
} 

// TODO: clearCacheAll

private bool isSpecial(T)() {
    static if (is(T == AudioStream)) return true; else
    static if (is(T == Material)) return true; else
    static if (is(T == ModelAnimation)) return true; else
    static if (is(T == RenderTexture)) return true; else
    static if (is(T == Shader)) return true; else
    return false;
}

import std.uni: toLower;
import std.format: format;

mixin(resourceMixin!("AudioStream", true, ["sampleRate", "sampleSize", "channels"], ["uint", "uint", "uint"]));
mixin(resourceMixin!("Shader", true, ["vsFileName", "fsFileName"], ["string", "string"]));
mixin(resourceMixin!("RenderTexture", true, ["p_width", "p_height"], ["int", "int"]));
// pragma(msg, resourceMixin!("AudioStream", true, ["sampleRate", "sampleSize", "channels"], ["uint", "uint", "uint"]));
// pragma(msg, resourceMixin!("Shader", true, ["vsFileName", "fsFileName"], ["string", "string"]));
// pragma(msg, resourceMixin!("RenderTexture", true, ["p_width", "p_height"], ["int", "int"]));
// mixin(resourceMixin!("ModelAnimation", false, ["path", "animCount"], ["string", "uint*"]));
// pragma(msg, resourceMixin!("AudioStream", true, ["sampleRate", "sampleSize", "channels"], ["uint", "uint", "uint"]));
// TODO: special for materials (ret T*)
// TODO: special for model animations (ret T*)

string resourceMixin(string typename, bool customIdentifier, string[] args, string[] argtypes)() 
    if (args.length == argtypes.length) {

    string cachename = "_" ~ typename.toLower ~ "Cache";
    string loadname = "Load" ~ typename;
    string unloadname = "Unload" ~ typename;
    string funcargs = "";
    string loadargs = "";
    string idenname = "";
    string[] pathargs;
    foreach (i; 0..args.length) {
        string argtype = argtypes[i];
        string arg = args[i];
        if (i != 0) { 
            funcargs ~= ", ";
            loadargs ~= ", ";
        }
        funcargs ~= "%s %s".format(argtype, arg);

        if (argtype != "string") {
            loadargs ~= "%s".format(arg);
        } else {
            loadargs ~= "fp%s.toStringz".format(arg);
            pathargs ~= arg;
        }

    }

    if (customIdentifier || pathargs.length == 0) {
        funcargs = "string p_name" ~ (funcargs.length > 0 ? ", " : "") ~ funcargs; 
        idenname = "p_name";
    } else 
    if (pathargs.length != 0) {
        idenname = pathargs[0];
    } else {
        assert(0, "Missing resource identifier for " ~ typename ~ ".");
    }

    string _out = "";
    
    _out ~= "private %s[string] %s;\n".format(typename, cachename);
    _out ~= "/// Load resource from path or from cache if available\n";
    _out ~= "T load(T)(%s) if (is(T == %s)) {\n".format(funcargs, typename);
    foreach (pa; pathargs) {
        _out ~= "    string fp%s = %s.makepath;\n".format(pa, pa);
        _out ~= "    if (!fp%s.exists) return nopath!T(fp%s);\n".format(pa, pa);
    }
    _out ~= "    if ((%s in %s) is null) {\n".format(idenname, cachename);
    _out ~= "        T res = %s(%s);\n".format(loadname, loadargs);
    _out ~= "        cache!T(%s, res);\n".format(idenname);
    _out ~= "        return res;\n";
    _out ~= "    } else {\n";
    _out ~= "        return %s[%s];\n".format(cachename, idenname);
    _out ~= "    }\n";
    _out ~= "}\n\n";

    _out ~= "/// Caches resource in memory. To remove use uncache\n";
    _out ~= "void cache(T)(string p_name, T res) if (is(T == %s)) {\n".format(typename);
    _out ~= "    if ((p_name in %s) !is null) unload!T(p_name);\n".format(cachename);
    _out ~= "    %s[p_name] = res;\n".format(cachename);
    _out ~= "}\n\n";

    _out ~= "/// Removes cached resource and unloads it\n";
    _out ~= "void unload(T)(string p_name) if (is(T == %s)) {\n".format(typename);
    _out ~= "    if ((p_name in %s) !is null) {\n".format(cachename);
    _out ~= "        %s(%s[p_name]);\n".format(unloadname, cachename);
    _out ~= "        %s.remove(p_name);\n".format(cachename);
    _out ~= "    }\n";
    _out ~= "}\n\n";

    _out ~= "/// Returns amount of cached resources of type T\n";
    _out ~= "size_t cacheSize(T)() if (is(T == %s)) {\n".format(typename);
    _out ~= "    return %s.length;\n".format(cachename);
    _out ~= "}\n\n";

    _out ~= "/// Rehashes cache so it's faster to look up\n";
    _out ~= "void rehashCache(T)() if (is(T == %s)) {\n".format(typename);
    _out ~= "    %s = %s.rehash;\n".format(cachename, cachename);
    _out ~= "}\n\n";

    _out ~= "/// Unloads and clears cache for given resource\n";
    _out ~= "void clearCache(T)() if (is(T == %s)) {\n".format(typename);
    _out ~= "    foreach (key; %s.keys) {\n".format(cachename);
    _out ~= "        %s(%s[key]);\n".format(unloadname, cachename);
    _out ~= "    }\n";
    _out ~= "    %s = null;\n".format(cachename);
    _out ~= "}\n";
    
    return _out;
}

