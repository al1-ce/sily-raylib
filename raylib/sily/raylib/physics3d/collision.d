module sily.raylib.physics3d.collision;

import sily.vector;
import sily.matrix;

import sily.raylib.raytype;

import rl = raylib;

alias rRayCollision = rl.RayCollision;

/// Check if spheres are colliding
bool isColliding(vec3 p1, float r1, vec3 p2, float r2) {
    return rl.CheckCollisionSpheres(p1.rayType, r1, p2.rayType, r2);
}

/// Check if AABB are colliding
bool isColliding(AABB b1, AABB b2) {
    return rl.CheckCollisionBoxes(b1.rayType, b2.rayType);
}

/// Check if AABB and sphere are colliding
bool isColliding(AABB aabb, vec3 p, float r) {
    return rl.CheckCollisionBoxSphere(aabb.rayType, p.rayType, r);
}

/// Get collision info between ray and circle
rRayCollision collisionInfo(Ray r, vec3 p, float radius) {
    return rl.GetRayCollisionSphere(r.rayType, p.rayType, radius);
}

/// Get collision info between ray and AABB
rRayCollision collisionInfo(Ray r, AABB aabb) {
    return rl.GetRayCollisionBox(r.rayType, aabb.rayType);
}

/// Get collision info between ray and mesh
rRayCollision collisionInfo(Ray r, rl.Mesh m, mat4 tr) {
    return rl.GetRayCollisionMesh(r.rayType, m, tr.rayType);
}

/// Get collision info between ray and triangle
rRayCollision collisionInfo(Ray r, vec3 p1, vec3 p2, vec3 p3) {
    return rl.GetRayCollisionTriangle(r.rayType, p1.rayType, p2.rayType, p3.rayType);
}

/// Get collision info between ray and quad
rRayCollision collisionInfo(Ray r, vec3 p1, vec3 p2, vec3 p3, vec3 p4) {
    return rl.GetRayCollisionQuad(r.rayType, p1.rayType, p2.rayType, p3.rayType, p4.rayType);
}


