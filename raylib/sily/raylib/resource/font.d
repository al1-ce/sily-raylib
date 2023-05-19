module sily.raylib.resource.font;

import sily.raylib.resource.manager;
import sily.raylib.raytype;
import sily.raylib.log;

import sily.color;

import rl = raylib;

public import raylib: Font;

alias rFont = rl.Font;

// load!rFont(path) is implemented in resource manager
// unload!rFont(path) is implemented in resource manager

import std.file: isDir, exists;
import std.path: isValidPath, buildNormalizedPath, dirSeparator;
import std.string: toStringz;
import std.conv: to;

private string makePath(string path) {
    return resourcePath ~ dirSeparator ~ path;
}

/// Loads font from file or cache
rFont loadFont(string path, int fontSize, char[] fontChars) {
    if (cached!rFont(path)) {
        string fp = path.makePath;
        if (!fp.exists) return nopath!rFont(fp);
        rFont res = rl.LoadFontEx(fp.toStringz, fontSize, cast(int*) fontChars.ptr, cast(int) fontChars.length);
        cache!rFont(path, res);
        return res;
    } else {
        return load!rFont(path);
    }
}

/// Loads font from file or cache
rFont loadFont(string p_name, rl.Image img, col key, char firstChar) {
    if (cached!rFont(p_name)) {
        rFont res = rl.LoadFontFromImage(img, key.rayType, cast(int) firstChar);
        cache!rFont(p_name, res);
        return res;
    } else {
        return load!rFont(p_name);
    }
}

/// Loads font from file or cache
rFont loadFont(string name, string ftype, string data, int fontSize, char[] fontChars) {
    if (cached!rFont(name)) {
        rFont res = rl.LoadFontFromMemory(
                ftype.toStringz, cast(const(ubyte)*) data.toStringz, cast(int) data.length, 
                fontSize, cast(int*) fontChars.ptr, cast(int) fontChars.length
                );
        cache!rFont(name, res);
        return res;
    } else {
        return load!rFont(name);
    }
}

/// Returns default material
rFont defaultFont() {
    return rl.GetFontDefault();
}

/// Checks if font is successfully loaded
bool isFontReady(rFont font) {
    return rl.IsFontReady(font);
}

// TODO: glyphs

