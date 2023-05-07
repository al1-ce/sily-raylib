module sily.raylib.render.camera;

import sily.vector;
import sily.matrix;

import sily.raylib.raytype;

import rl = raylib;

alias rCamera = rl.Camera;
alias rCameraMode = rl.CameraMode;

/// Updates camera for selected mode (not required for custom logic)
void updateCamera(ref rCamera cam, int mode) {
    rl.UpdateCamera(&cam, mode);
}
/// Ditto
void updateCamera(ref rCamera cam, vec3 mov, vec3 rot, float zoom) {
    rl.UpdateCameraPro(&cam, mov.rayType, rot.rayType, zoom);
}

/// Get camera forward vector
vec3 getForward(ref rCamera cam) {
    return rl.GetCameraForward(&cam).rayType;
}

/// Get camera up vector
vec3 getUp(ref rCamera cam) {
    return rl.GetCameraUp(&cam).rayType;
}

/// Get camera right vector
vec3 getRight(ref rCamera cam) {
    return rl.GetCameraRight(&cam).rayType;
}

/++
Moves camera forward
Params:
    cam = Camera
    dist = Distance to move
    inWorld = If false then moves like a freecam
+/
void moveForward(ref rCamera cam, float dist, bool inWorld) {
    rl.CameraMoveForward(&cam, dist, inWorld);
}

/++
Moves camera up relative to Camera.up vector
Params:
    cam = Camera
    dist = Distance to move
+/
void moveUp(ref rCamera cam, float dist) {
    rl.CameraMoveUp(&cam, dist);
}

/++
Moves camera right
Params:
    cam = Camera
    dist = Distance to move
    inWorld = If false then moves like a freecam
+/
void moveRight(ref rCamera cam, float dist, bool inWorld) {
    rl.CameraMoveRight(&cam, dist, inWorld);
}

/++
Rotates camera Yaw (left-right)
Params:
    cam = Camera
    angle = Angle to rotate
    aroundTarget = Rotate around target (like 3rd person)
+/
void rotateYaw(ref rCamera cam, float angle, bool aroundTarget) {
    rl.CameraYaw(&cam, angle, aroundTarget);
}

/++
Rotates camera Pitch (up-down)
Params:
    cam = Camera
    angle = Angle to rotate
    lockView = Limit pitch to -90..90
    aroundTarget = Rotate around target (like 3rd person)
    rotateUp = Rotate Up vector with Pitch
+/
void rotateYaw(ref rCamera cam, float angle, bool lockView, bool aroundTarget, bool rotateUp) {
    rl.CameraPitch(&cam, angle, lockView, aroundTarget, rotateUp);
}

/++
Rotates camera Roll (around forward vector)
Params:
    cam = Camera
    angle = Angle to rotate
+/
void rotateRoll(ref rCamera cam, float angle) {
    rl.CameraRoll(&cam, angle);
}

/// Returns camera view (lookAt) matrix
mat4 viewMatrix(rCamera cam) {
    return mat4.lookAt(cam.position.rayType, cam.target.rayType, cam.up.rayType);
}

/++ 
Returns camera projection (perspective/ortho) matrix
Params:
    cam = Camera
    aspect = screen.width / screen.height
+/
mat4 projectionMatrix(rCamera cam, float aspect) {
    if (cam.projection == rl.CameraProjection.CAMERA_PERSPECTIVE) {
        return mat4.perspective(cam.fovy, aspect, rl.CAMERA_CULL_DISTANCE_NEAR, rl.CAMERA_CULL_DISTANCE_FAR); 
    } else 
    if (cam.projection == rl.CameraProjection.CAMERA_ORTHOGRAPHIC){
        double top = cam.fovy / 2.0;
        double right = top * aspect;
        return mat4.ortho(-right, right, -top, top, rl.CAMERA_CULL_DISTANCE_NEAR, rl.CAMERA_CULL_DISTANCE_FAR);
    }
    return mat4.identity;
}

