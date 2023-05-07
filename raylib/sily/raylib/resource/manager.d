/// Resource loading and caching utils
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

/// Returns base path
string resourcePath() {
    return _pathBase;
}

private bool _abortOnMissing = true;

/++
Sets if program should exit if resource is missing
Params:
    abort = default true
+/
void setAbortOnMissing(bool abort) {
    _abortOnMissing = abort;
}

T nopath(T)(string path) {
    if (_abortOnMissing) {
        log!FATAL("Resource at path \"" ~ path ~ "\" does not exist.");
        assert(0);
    } else {
        log!WARNING("Resource at path \"" ~ path ~ "\" does not exist.");
    }
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
private auto _vrconfigResource  = ResourceType!VrStereoConfig(null, &UnloadVrStereoConfig);
private auto _shaderResource    = ResourceType!Shader(null, &UnloadShader);
private auto _renderTexResource = ResourceType!RenderTexture(null, &UnloadRenderTexture);
private auto _materialResource  = ResourceType!Material(null, &UnloadMaterial);
private auto _animationResource = ResourceType!ModelAnimation(null, &UnloadModelAnimation);
private auto _audioResource     = ResourceType!AudioStream(null, &UnloadAudioStream);
private auto _meshResource      = ResourceType!Mesh(null, &UnloadMesh);
// TODO: dropped files

// TODO: resource UID
// TODO: threaded load

private bool cached(T)(string p_name, ResourceType!T* ptr) {
    return (p_name in (*ptr)._cache) !is null;
}

/++
Load resource from path or from cache if available
Params:
    path = Path to file or cached resource name
Example:
---
// Load model from file
load!Model("res/model/house.obj"); 
// This is going to load cached model
load!Model("res/model/house.obj"); 
// Creates model from mesh
loadModelMesh("newHouse", houseMesh);
// Returns newly cached version
load!Model("newHouse");
---
+/
T load(T)(string path) if (!isSpecial!T) {
    ResourceType!T* ptr = getResourcePtr!T;
    if (path.cached(ptr)) {
        return (*ptr)._cache[path];
    } else {
        if ((*ptr)._loadFunc is null) {
            fatal("Missing load function for type \"" ~ T.stringof ~ "\".");
            assert(0);
        }
        string fp = path.makePath;
        if (!fp.exists) return nopath!T(fp);
        T res = (*ptr)._loadFunc(fp.toStringz); 
        cache!T(path, res);
        return res;
    }
}
// Only loading cache for resources that require 2 and more args in load
/// Ditto
T load(T)(string p_name) if (isSpecialMulti!T) {
    ResourceType!T* ptr = getResourcePtr!T;
    if (p_name.cached(ptr)) {
        return (*ptr)._cache[p_name];
    } else {
        warning("Resource \"" ~ p_name ~ "\" is not cached. Returning \"" ~ T.stringof ~ ".init\".");
        return T.init;
    }
}
/// Ditto
T load(T)(string p_name, VrDeviceInfo dev) if (is(T == VrStereoConfig)) {
    ResourceType!T* ptr = getResourcePtr!T;
    if (p_name.cached(ptr)) {
        return (*ptr)._cache[path];
    } else {
        T res = LoadVrStereoConfig(dev); 
        cache!T(path, res);
        return res;
    }
}
/// Ditto
T load(T)(string p_name, string vertPath, string fragPath) if (is(T == Shader)) {
    ResourceType!T* ptr = getResourcePtr!T;
    if (p_name.cached(ptr)) {
        return (*ptr)._cache[path];
    } else {
        string fp1 = vertPath.makePath;
        string fp2 = fragPath.makePath;
        if (!fp1.exists) return nopath!T(fp1);
        if (!fp2.exists) return nopath!T(fp2);
        T res = LoadShader(fp1.toStringz, fp2.toStringz); 
        cache!T(path, res);
        return res;
    }
}
/// Ditto
T load(T)(string p_name, int[2] size...) if (is(T == RenderTexture)) {
    ResourceType!T* ptr = getResourcePtr!T;
    if (p_name.cached(ptr)) {
        return (*ptr)._cache[path];
    } else {
        T res = LoadRenderTexture(size[0], size[1]); 
        cache!T(path, res);
        return res;
    }
}
/// Ditto
T load(T)(string path) if (is(T == Material)) {
    ResourceType!T* ptr = getResourcePtr!T;
    if (path.cached(ptr)) {
        return (*ptr)._cache[path];
    } else {
        string fp = path.makePath;
        if (!fp.exists) return nopath!T(fp);
        T res = (*(LoadMaterials(fp.toStringz, &1)))[0]; 
        cache!T(path, res);
        return res;
    }
}
/// Ditto
T load(T)(string path) if (is(T == ModelAnimation)) {
    ResourceType!T* ptr = getResourcePtr!T;
    if (path.cached(ptr)) {
        return (*ptr)._cache[path];
    } else {
        string fp = path.makePath;
        if (!fp.exists) return nopath!T(fp);
        T res = (*(LoadModelAnimations(fp.toStringz, &1)))[0]; 
        cache!T(path, res);
        return res;
    }
}
/// Ditto
T load(T)(string p_name, uint sampleRate, uint sampleSize, uint channels) if (is(T == AudioStream)) {
    ResourceType!T* ptr = getResourcePtr!T;
    if (p_name.cached(ptr)) {
        return (*ptr)._cache[path];
    } else {
        T res = LoadAudioStream(sampleRate, sampleSize, channels); 
        cache!T(path, res);
        return res;
    }
}
/// Load resource from raw data or from cache if available
T loadRaw(T)(string p_name, string vert, string frag) if (is(T == Shader)) {
    ResourceType!T* ptr = getResourcePtr!T;
    if (p_name.cached(ptr)) {
        return (*ptr)._cache[path];
    } else {
        T res = LoadShaderFromMemory(vert.toStringz, frag.toStringz); 
        cache!T(path, res);
        return res;
    }
}

/// Caches resource in memory. To remove use uncache
void cache(T)(string path, T res) {
    ResourceType!T* ptr = getResourcePtr!T();
    if (path.cached(ptr)) unload!T(path);
    (*ptr)._cache[path] = res;
}

/// Checks if resource is cached
bool cached(T)(string p_name) {
    ResourceType!T* ptr = getResourcePtr!T;
    return p_name.cached(ptr);
}

/// Removes cached resource and unloads it
void unload(T)(string path) {
    ResourceType!T* ptr = getResourcePtr!T();
    if (path.cached(ptr)) {
        (*ptr)._unloadFunc((*ptr)._cache[path]); 
        (*ptr)._cache.remove(path);
    }
}
/// Ditto
alias uncache = unload;

/// Explicitly pulls resource from cache, returns T.init if not cached  
T getCache(T)(string path) {
    ResourceType!T* ptr = getResourcePtr!T();
    if (path.cached(ptr)) return (*ptr)._cache[path];
    return T.init;
}


/// Returns amount of cached resources of type T
size_t cacheSize(T)() {
    ResourceType!T* ptr = getResourcePtr!T();
    return (*ptr)._cache.length;
}

/// Rehashes cache so it's faster to look up
void rehashCache(T)() {
    ResourceType!T* ptr = getResourcePtr!T;
    (*ptr)._cache = (*ptr)._cache.rehash;
}

/// Unloads and clears cache for given resource
void clearCache(T)() {
    ResourceType!T* ptr = getResourcePtr!T;
    foreach (key; (*ptr)._cache.keys) {
        (*ptr)._unloadFunc((*ptr)._cache[key]); 
    }
    (*ptr)._cache = null;
}

void clearCacheAll() {
    clearCache!Model;
    clearCache!Image;
    clearCache!Font;
    clearCache!Wave;
    clearCache!Sound;
    clearCache!Music;
    clearCache!VrStereoConfig;
    clearCache!Shader;
    clearCache!RenderTexture;
    clearCache!Material;
    clearCache!ModelAnimation;
    clearCache!AudioStream;
    clearCache!Mesh;
}

private ResourceType!T* getResourcePtr(T)() {
    static if (is(T == Model)) {
        return &_modelResource;
    } else
    static if (is(T == Texture)) {
        return &_textureResource;
    } else
    static if (is(T == Image)) {
        return &_imageResource;
    } else
    static if (is(T == Font)) {
        return &_fontResource;
    } else
    static if (is(T == Wave)) {
        return &_waveResource;
    } else
    static if (is(T == Sound)) {
        return &_soundResource;
    } else
    static if (is(T == Music)) {
        return &_musicResource;
    } else
    static if (is(T == VrStereoConfig)) {
        return &_vrconfigResource;
    } else
    static if (is(T == Shader)) {
        return &_shaderResource;
    } else
    static if (is(T == RenderTexture)) {
        return &_renderTexResource;
    } else
    static if (is(T == Material)) {
        return &_materialResource;
    } else
    static if (is(T == ModelAnimation)) {
        return &_animationResource;
    } else
    static if (is(T == AudioStream)) {
        return &_audioResource;
    } else
    static if (is(T == Mesh)) {
        return &_meshResource;
    } else {
        fatal("Unknown resource type \"" ~ T.stringof ~ "\".");
        assert(0);
    }
} 

private bool isSpecial(T)() {
    static if (is(T == AudioStream)) return true; else
    static if (is(T == Material)) return true; else
    static if (is(T == ModelAnimation)) return true; else
    static if (is(T == RenderTexture)) return true; else
    static if (is(T == Shader)) return true; else
    static if (is(T == VrStereoConfig)) return true; else
    static if (is(T == Mesh)) return true; else
    return false;
}

private bool isSpecialMulti(T)() {
    static if (is(T == AudioStream)) return true; else
    static if (is(T == RenderTexture)) return true; else
    static if (is(T == Shader)) return true; else
    static if (is(T == VrStereoConfig)) return true; else
    static if (is(T == Mesh)) return true; else // mesh doesn't have load function
    return false;
}


// Load font raw
// /++
// Loads font from memory
// Params:
//     p_name = Name of resource
//     filetype = 
// +/
// T load(T)(string p_name, string filetype, ubyte[] data, int fontSize, int* fontChars, int glyphCount) 
//     if (is(T == Font)) {
//     ResourceType!T* ptr = getResourcePtr!T;
//     if (p_name.cached(ptr)) {
//         T res = LoadShaderFromMemory(vert.toStringz, frag.toStringz); 
//         cache!T(path, res);
//         return res;
//     } else {
//         return (*ptr)._cache[path];
//     }
// }



