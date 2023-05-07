module sily.raylib.render.model;

import sily.raylib.raytype;
import sily.vector;
import sily.color;
import sily.matrix;

import rl = raylib;

alias rModel = rl.Model;
alias rMesh = rl.Mesh;
alias rMaterial = rl.Material;
alias rTexture = rl.Texture;
alias rCamera = rl.Camera;

/// Renders 3D model
void drawModel(rModel m, vec3 pos, float scale, col tint = Colors.white) {
    rl.DrawModel(m, pos.rayType, scale, tint.rayType);
}
/// Ditto
void drawModel(rModel m, vec3 pos, vec3 rotAxis, float rot, vec3 scale, col tint = Colors.white) {
    rl.DrawModelEx(m, pos.rayType, rotAxis.rayType, rot, scale.rayType, tint.rayType);
}

/// Renders 3D model wireframe
void drawModelWire(rModel m, vec3 pos, float scale, col tint = Colors.white) {
    rl.DrawModelWires(m, pos.rayType, scale, tint.rayType);
}
/// Ditto
void drawModelWire(rModel m, vec3 pos, vec3 rotAxis, float rot, vec3 scale, col tint = Colors.white) {
    rl.DrawModelWiresEx(m, pos.rayType, rotAxis.rayType, rot, scale.rayType, tint.rayType);
}

/// Draws AABB
void drawAABB(AABB aabb, col p_color) {
    rl.DrawBoundingBox(aabb.rayType, p_color.rayType);
}

/// Draws billboarded texture
void drawBillboard(rCamera cam, rTexture tex, vec3 pos, float size, col tint = Colors.white) {
    rl.DrawBillboard(cam, tex, pos.rayType, size, tint.rayType);
}
/// Ditto
void drawBillboard(rCamera cam, rTexture tex, vec4 rect, vec3 pos, vec2 size, col tint = Colors.white) {
    rl.DrawBillboardRec(cam, tex, rayType!(rl.Rectangle)(rect), pos.rayType, size.rayType, tint.rayType);
}
/// Ditto
void drawBillboard(rCamera cam, rTexture tex, vec4 rect, vec3 pos, vec2 size, 
        vec2 origin, float rot, vec3 up = vec3.up, col tint = Colors.white) {
    rl.DrawBillboardPro(cam, tex, rayType!(rl.Rectangle)(rect), pos.rayType, up.rayType, size.rayType,
            origin.rayType, rot, tint.rayType);
}

/// Draws a single mesh
void drawMesh(rMesh mesh, rMaterial p_mat, mat4 transform) {
    rl.DrawMesh(mesh, p_mat, transform.rayType);
}

/// Draws multi-instance of mesh
void drawMeshInstanced(rMesh mesh, rMaterial p_mat, mat4[] transform) {
    rl.Matrix[] rm;
    foreach (i; 0..transform.length) {
        rm ~= transform[i].rayType;
    }
    rl.DrawMeshInstanced(mesh, p_mat, rm.ptr, cast(int) rm.length);
}


