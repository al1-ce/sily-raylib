module sily.raylib.resource.material;

import sily.raylib.resource.manager;
import sily.raylib.raytype;
import sily.raylib.log;

import rl = raylib;

public import raylib: Material;

alias rModel = rl.Model;
alias rMesh = rl.Mesh;
alias rMaterial = rl.Material;
alias rTexture = rl.Texture;

// load!rMaterial(path) is implemented in resource manager
// unload!rMaterial(path) is implemented in resource manager

import std.file: isDir, exists;
import std.path: isValidPath, buildNormalizedPath, dirSeparator;
import std.string: toStringz;
import std.conv: to;

private string makePath(string path) {
    return resourcePath ~ dirSeparator ~ path;
}

/// Loads materials from file. Resources cached at "path:idx", i.e "res/mat/mat.mtl:2"
rMaterial[] loadMaterials(string path, int count) {
    string fp = path.makePath;
    if (!fp.exists) {nopath!rMaterial(fp); return [];}
    rMaterial[] res = (rl.LoadMaterials(fp.toStringz, &count))[0..count];
    foreach (i; 0..count) {
        cache!rMaterial(path ~ ":" ~ i.to!string, res[i]);
    }
    return res;
}

/// Returns default material
rMaterial defaultMaterial() {
    return rl.LoadMaterialDefault();
}

/// Checks if Material is successfully loaded
bool isMaterialReady(rMaterial material) {
    return rl.IsMaterialReady(material);
}

/// Sets texture for material
void setMaterialTexture(ref rMaterial material, int mapType, rTexture tex) {
    rl.SetMaterialTexture(&material, mapType, tex);
}

