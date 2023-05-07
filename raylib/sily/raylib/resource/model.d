module sily.raylib.resource.model;

import sily.raylib.resource.manager;
import sily.raylib.raytype;
import sily.raylib.log;

import rl = raylib;

alias rModel = rl.Model;
alias rMesh = rl.Mesh;
alias rMaterial = rl.Material;
alias rModelAnimation = rl.ModelAnimation;

// load!rModel(path) is implemented in resource manager
// unload!rModel(path) is implemented in resource manager

/// Loads model from mesh or from cache if exists
rModel loadModelMesh(string name, rMesh mesh) {
    bool c = cached!rModel(name);
    if (!c) {
        rl.Model m = rl.LoadModelFromMesh(mesh);
        cache!rModel(name, m);
        return m;
    } else {
        return load!rModel(name);
    }
}

/// Checks if Model is successfully loaded
bool isModelReady(rModel m) {
    return rl.IsModelReady(m);
}

/// Returns model AABB
AABB getAABB(rModel m) {
    return rl.GetModelBoundingBox(m).rayType;
}

/// Sets material ID for mesh in model
void setModelMeshMaterial(ref rModel model, int meshId, int materialId) {
    rl.SetModelMeshMaterial(&model, meshId, materialId);
}

import std.file: isDir, exists;
import std.path: isValidPath, buildNormalizedPath, dirSeparator;
import std.string: toStringz;
import std.conv: to;

private string makePath(string path) {
    return resourcePath ~ dirSeparator ~ path;
}

/// Loads model animations from file. Resources cached at "path:idx", i.e "res/anim/anims:2"
rModelAnimation[] loadAnimations(string path, uint count) {
    string fp = path.makePath;
    if (!fp.exists) {nopath!rModelAnimation(fp); return [];}
    rModelAnimation[] res = (rl.LoadModelAnimations(fp.toStringz, &count))[0..count];
    foreach (i; 0..count) {
        cache!rModelAnimation(path ~ ":" ~ i.to!string, res[i]);
    }
    return res;
}

/// Update model animation pose
void updateAnimation(rModel model, rModelAnimation anim, int frame) {
    rl.UpdateModelAnimation(model, anim, frame);
}

/// Check model animation skeleton match
bool isAnimationValid(rModel model, rModelAnimation anim) {
    return rl.IsModelAnimationValid(model, anim);
}


