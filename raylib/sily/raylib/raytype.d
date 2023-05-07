/// Sily to raylib / Raylib to sily covnersion
module sily.raylib.raytype;

import sily.vector: vec2, vec3, vec4, vec, ivec2, ivec3, ivec4;
import sily.matrix: mat4;
import sily.quat: quat;
import sily.color: col, Color8;

import rl = raylib;

/// Converts sily type to raylib type and vice versa
rl.Vector2 rayType(ivec2 v) {
    return rl.Vector2(cast(float) v.x, cast(float) v.y);
}
/// Ditto
rl.Vector2 rayType(vec2 v) {
    return rl.Vector2(v.x, v.y);
}
/// Ditto
vec2 rayType(rl.Vector2 v) {
    return vec2(v.x, v.y);
}
/// Ditto
rl.Vector3 rayType(ivec3 v) {
    return rl.Vector3(cast(float) v.x, cast(float) v.y, cast(float) v.z);
}
/// Ditto
rl.Vector3 rayType(vec3 v) {
    return rl.Vector3(v.x, v.y, v.z);
}
/// Ditto
vec3 rayType(rl.Vector3 v) {
    return vec3(v.x, v.y, v.z);
}
/// Ditto
rl.Vector4 rayType(ivec4 v) {
    return rl.Vector4(cast(float) v.x, cast(float) v.y, cast(float) v.z, cast(float) v.w);
}
/// Ditto
rl.Vector4 rayType(vec4 v) {
    return rl.Vector4(v.x, v.y, v.z, v.w);
}
/// Ditto
vec4 rayType(rl.Vector4 v) {
    return vec4(v.x, v.y, v.z, v.w);
}
/// Ditto
rl.Quaternion rayType(quat v) {
    return rl.Quaternion(v.x, v.y, v.z, v.w);
}
/// Ditto
quat rayType(T)(rl.Quaternion v) if (is(T == rl.Quaternion)) {
    return quat(v.x, v.y, v.z, v.w);
}
/// Ditto
rl.Matrix rayType(mat4 m) {
    return rl.Matrix(
        m[0][0], m[0][1], m[0][2], m[0][3],
        m[1][0], m[1][1], m[1][2], m[1][3],
        m[2][0], m[2][1], m[2][2], m[2][3],
        m[3][0], m[3][1], m[3][2], m[3][3]
        );
}
/// Ditto
mat4 rayType(rl.Matrix m) {
    return mat4(
        m.m0, m.m4, m.m8,  m.m12,
        m.m1, m.m5, m.m9,  m.m13,
        m.m2, m.m6, m.m10, m.m14,
        m.m3, m.m7, m.m11, m.m15
        );
}
/// Ditto
rl.Rectangle rayType(T)(vec4 v) if (is(T == rl.Rectangle)) {
    return rl.Rectangle(v.x, v.y, v.z, v.w);
}
/// Ditto
vec4 rayType(rl.Rectangle r) {
    return vec4(r.x, r.y, r.w, r.h);
}
/// Ditto
rl.Color rayType(col c) {
    return rl.Color(c.r8, c.g8, c.b8, c.a8);
}
/// Ditto
col rayType(rl.Color c) {
    return Color8(c.r, c.g, c.b, c.a);
}

struct Camera3D {
    vec3 position;
    vec3 target;
    vec3 up;
    float fovy;
    int projection;

    // TODO: viewMatrix()
    // TODO: projMatrix()
}
alias Camera = Camera3D;

struct Camera2D {
    vec2 offset;
    vec2 target;
    float rotation;
    float zoom;
}

struct Transform {
    vec3 origin;
    quat rotation;
    vec3 scale;
}

struct Ray {
    vec3 origin;
    vec3 normal;
}
/// Converts sily type to raylib type and vice versa
rl.Ray rayType(Ray r) {
    return rl.Ray(r.origin.rayType, r.normal.rayType);
}
/// Ditto
Ray rayType(rl.Ray r) {
    return Ray(r.position.rayType, r.direction.rayType);
}

struct RayCollision {
    bool hit;
    float distance;
    vec3 point;
    vec3 normal;
}

// Axis aligned bounding box
struct AABB {
    vec3 min;
    vec3 max;
}

/// Converts sily type to raylib type and vice versa
rl.BoundingBox rayType(AABB aabb) {
    return rl.BoundingBox(aabb.min.rayType, aabb.max.rayType);
}
/// Ditto
AABB rayType(rl.BoundingBox aabb) {
    return AABB(aabb.min.rayType, aabb.max.rayType);
}

// // File path list
// struct FilePathList
// {
//     uint capacity; // Filepaths max entries
//     uint count; // Filepaths entries count
//     char** paths; // Filepaths entries
// }

