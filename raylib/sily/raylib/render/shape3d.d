/// 3D Shape render
module sily.raylib.render.shape3d;

import std.string: toStringz;

import rl = raylib;

import sily.color: col;
import sily.vector: vec2, vec3, vec4;

import sily.raylib.raytype;

// ================= 3D =====================

/// Draws 3D line
void drawLine3D(vec3 p1, vec3 p2, col p_color) {
    rl.DrawLine3D(p1.rayType, p2.rayType, p_color.rayType);
}

/// Draws 3D point
void drawPoint3D(vec3 pos, col p_color) {
    rl.DrawPoint3D(pos.rayType, p_color.rayType);
}

/// Draws 3D circle (non-billboard)
void drawCircle3D(vec3 pos, float radius, vec3 axis, float angle, col p_color) {
    rl.DrawCircle3D(pos.rayType, radius, axis.rayType, angle, p_color.rayType);
}

/// Draws 3D triangle
void drawTriangle3D(vec3 v1, vec3 v2, vec3 v3, col p_color) {
    rl.DrawTriangle3D(v1.rayType, v2.rayType, v3.rayType, p_color.rayType);
}

/// Draws 3D Triangle Strip ([1, 2, 3, 4, 5, 6] -> 1,2,3 - tri, 2,3,4 - tri, 3,4...)
void drawTriangleStrip3D(vec3[] points, col p_color) {
    rl.Vector3[] vecs = [];
    foreach (point; points) {
        vecs ~= point.rayType;
    }
    rl.DrawTriangleStrip3D(vecs.ptr, cast(int) vecs.length, p_color.rayType);
}

/// Draws 3D cube
void drawCube(vec3 pos, vec3 size, col p_color) {
    rl.DrawCubeV(pos.rayType, size.rayType, p_color.rayType);
}

/// Draws wireframe 3D cube
void drawCubeWire(vec3 pos, vec3 size, col p_color) {
    rl.DrawCubeWiresV(pos.rayType, size.rayType, p_color.rayType);
}

/// Draws 3D sphere
void drawSphere(vec3 pos, float radius, col p_color) {
    rl.DrawSphere(pos.rayType, radius, p_color.rayType);
}

/// Ditto
void drawSphere(vec3 pos, float radius, int rings, int slices, col p_color) {
    rl.DrawSphereEx(pos.rayType, radius, rings, slices, p_color.rayType);
}

/// Draws wireframe 3D sphere
void drawSphereWire(vec3 pos, float radius, int rings, int slices, col p_color) {
    rl.DrawSphereWires(pos.rayType, radius, rings, slices, p_color.rayType);
}

/// Draws wireframe 3D cylinder
void drawCylinder(vec3 pos, float radiusTop, float radiusBottom, float height, int slices, col p_color) {
    rl.DrawCylinder(pos.rayType, radiusTop, radiusBottom, height, slices, p_color.rayType);
}
/// Ditto
void drawCylinder(vec3 p1, vec3 p2, float r1, float r2, int sides, col p_color) {
    rl.DrawCylinderEx(p1.rayType, p2.rayType, r1, r2, sides, p_color.rayType);
}

/// Draws wireframe 3D cylinder
void drawCylinderWire(vec3 pos, float radiusTop, float radiusBottom, float height, int slices, col p_color) {
    rl.DrawCylinderWires(pos.rayType, radiusTop, radiusBottom, height, slices, p_color.rayType);
}
/// Ditto
void drawCylinderWire(vec3 p1, vec3 p2, float r1, float r2, int sides, col p_color) {
    rl.DrawCylinderWiresEx(p1.rayType, p2.rayType, r1, r2, sides, p_color.rayType);
}

/// Draws capsule
void drawCapsule(vec3 p1, vec3 p2, float r, int slices, int rings, col p_color) {
    rl.DrawCapsule(p1.rayType, p2.rayType, r, slices, rings, p_color.rayType);
}

/// Draws wireframe capsule
void drawCapsuleWire(vec3 p1, vec3 p2, float r, int slices, int rings, col p_color) {
    rl.DrawCapsuleWires(p1.rayType, p2.rayType, r, slices, rings, p_color.rayType);
}

/// Draws XZ plane
void drawPlane(vec3 pos, vec2 size, col p_color) {
   rl.DrawPlane(pos.rayType, size.rayType, p_color.rayType); 
}

/// Draws ray line
void drawRay(Ray ray, col p_color) {
    rl.DrawRay(ray.rayType, p_color.rayType);
}

/++
Draws grid centered at [0, 0, 0]
Params:
    slices = Amount of grid cells to draw
    spacing = Size of grid cell
+/
void drawGrid(int slices, float spacing) {
    rl.DrawGrid(slices, spacing);
}



