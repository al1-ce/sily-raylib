module sily.raylib.resource.mesh;

import sily.raylib.resource.manager;
import sily.raylib.raytype;

import sily.vector;

import rl = raylib;

public import raylib: Mesh;

alias rModel = rl.Model;
alias rMesh = rl.Mesh;
alias rMaterial = rl.Material;
alias rImage = rl.Image;

// load!rMesh(path) is implemented in resource manager
// unload!rMesh(path) is implemented in resource manager

/// Upload mesh vertex data in GPU and provide VAO/VBO ids
void uploadMesh(rMesh* mesh, bool dynamic) {
    rl.UploadMesh(mesh, dynamic);
}

/// Update mesh vertex data in GPU for a specific buffer index
void updateMeshBuffer(rMesh mesh, int idx, const(void)* data, int dataSize, int offset) {
    rl.UpdateMeshBuffer(mesh, idx, data, dataSize, offset);
}

/// Returns mesh AABB
AABB getAABB(rMesh mesh) {
    return rl.GetMeshBoundingBox(mesh).rayType;
}

/// Computes mesh tangents
void genMeshTangents(ref rMesh mesh) {
    rl.GenMeshTangents(&mesh);
}

// Mesh GenMeshPoly(int sides, float radius);                                            // Generate polygonal mesh
/// Generate polygonal mesh
rMesh genMeshPoly(string name, int sides, float radius) {
    if (cached!rMesh(name)) return load!rMesh(name);
    rMesh m = rl.GenMeshPoly(sides, radius);
    cache!rMesh(name, m);
    return m;
}

// Mesh GenMeshPlane(float width, float length, int resX, int resZ);                     // Generate plane mesh (with subdivisions)
/// Generate plane mesh
rMesh genMeshPlane(string name, float sx, float sz, int divX = 1, int divZ = 1) {
    if (cached!rMesh(name)) return load!rMesh(name);
    rMesh m = rl.GenMeshPlane(sx, sz, divX, divZ);
    cache!rMesh(name, m);
    return m;
}

// Mesh GenMeshCube(float width, float height, float length);                            // Generate cuboid mesh
/// Generate cube mesh
rMesh genMeshCube(string name, float sx, float sy, float sz) {
    if (cached!rMesh(name)) return load!rMesh(name);
    rMesh m = rl.GenMeshCube(sx, sy, sz);
    cache!rMesh(name, m);
    return m;
}

// Mesh GenMeshSphere(float radius, int rings, int slices);                              // Generate sphere mesh (standard sphere)
/// Generate sphere mesh
rMesh genMeshSphere(string name, float r, int rings, int slices) {
    if (cached!rMesh(name)) return load!rMesh(name);
    rMesh m = rl.GenMeshSphere(r, rings, slices);
    cache!rMesh(name, m);
    return m;
}

// Mesh GenMeshHemiSphere(float radius, int rings, int slices);                          // Generate half-sphere mesh (no bottom cap)
/// Generate hemisphere mesh
rMesh genMeshHemiSphere(string name, float r, int rings, int slices) {
    if (cached!rMesh(name)) return load!rMesh(name);
    rMesh m = rl.GenMeshHemiSphere(r, rings, slices);
    cache!rMesh(name, m);
    return m;
}
/// Ditto
alias genMeshDome = genMeshHemiSphere;

// Mesh GenMeshCylinder(float radius, float height, int slices);                         // Generate cylinder mesh
/// Generate cylinder mesh
rMesh genMeshCylinder(string name, float r, float h, int slices) {
    if (cached!rMesh(name)) return load!rMesh(name);
    rMesh m = rl.GenMeshCylinder(r, h, slices);
    cache!rMesh(name, m);
    return m;
}

// Mesh GenMeshCone(float radius, float height, int slices);                             // Generate cone/pyramid mesh
/// Generate cone mesh
rMesh genMeshCone(string name, float r, float h, int slices) {
    if (cached!rMesh(name)) return load!rMesh(name);
    rMesh m = rl.GenMeshCone(r, h, slices);
    cache!rMesh(name, m);
    return m;
}

// Mesh GenMeshTorus(float radius, float size, int radSeg, int sides);                   // Generate torus mesh
/// Generate torus mesh
rMesh genMeshTorus(string name, float r, float size, int radSeg, int sides) {
    if (cached!rMesh(name)) return load!rMesh(name);
    rMesh m = rl.GenMeshTorus(r, size, radSeg, sides);
    cache!rMesh(name, m);
    return m;
}

// Mesh GenMeshKnot(float radius, float size, int radSeg, int sides);                    // Generate trefoil knot mesh
/// Generate knot mesh
rMesh genMeshKnot(string name, float r, float size, int radSeg, int sides) {
    if (cached!rMesh(name)) return load!rMesh(name);
    rMesh m = rl.GenMeshKnot(r, size, radSeg, sides);
    cache!rMesh(name, m);
    return m;
}

// Mesh GenMeshHeightmap(Image heightmap, Vector3 size);                                 // Generate heightmap mesh from image data
/// Generate heightmap mesh
rMesh genMeshHeightmap(string name, rImage heightMap, vec3 size) {
    if (cached!rMesh(name)) return load!rMesh(name);
    rMesh m = rl.GenMeshHeightmap(heightMap, size.rayType);
    cache!rMesh(name, m);
    return m;
}

// Mesh GenMeshCubicmap(Image cubicmap, Vector3 cubeSize);                               // Generate cubes-based map mesh from image data
/// Generate cubicmap mesh
rMesh genMeshCubemap(string name, rImage cubeMap, vec3 cubeSize) {
    if (cached!rMesh(name)) return load!rMesh(name);
    rMesh m = rl.GenMeshCubicmap(cubeMap, cubeSize.rayType);
    cache!rMesh(name, m);
    return m;
}


