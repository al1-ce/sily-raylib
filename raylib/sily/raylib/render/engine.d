/// Render modes and render settings
module sily.raylib.render.engine;

import sily.vector;
import sily.color: col, Colors;

import raylib;

import sily.raylib.raytype: rayType;

private int _targetFPS = 60;

/// Clears background, default white
void clearBackground(col p_color = Colors.white) {
    ClearBackground(p_color.rayType);
}

/// Starts render mode
void startRender() {
    BeginDrawing();
}
/// Ditto
alias start = startRender;

/// Ends render mode
void finishRender() {
    EndDrawing();
}
/// Ditto
alias finish = finishRender;

/// Sets Camera2D for rendering (uses camera's perspective)
void setCamera2D(Camera2D camera) {
    BeginMode2D(camera);
}

/// Resets Camera2D rendering (stops using camera's perspective)
void resetCamera2D() {
    EndMode2D();
}

/// Sets Camera3D for rendering (uses camera's perspective)
void setCamera3D(Camera3D camera) {
    BeginMode3D(camera);
}
/// Ditto
alias setCamera = setCamera3D;

/// Resets Camera3D rendering (stops using camera's perspective)
void resetCamera3D() {
    EndMode3D();
}
/// Ditto
alias resetCamera = resetCamera3D;

/// Sets RenderTexture as target for render
void setTextureTarget(RenderTexture target) {
    BeginTextureMode(target);
}

/// End rendering into RenderTexture
void resetTextureTarget() {
    EndTextureMode();
}

/// Sets shader for processing render
void setShader(Shader shader) {
    BeginShaderMode(shader);
}

/// End using shader for processing
void resetShader() {
    EndShaderMode();
}

/// Set render blend mode (when render overlaps)
void setBlendMode(int mode) {
    BeginBlendMode(mode);
}

/// Sets blend mode to normal (when render overlaps)
void resetBlendMode() {
    EndBlendMode();
}

/// Forces content to be rendered into rect [x, y, w, h] 
void setTextureRect(int[4] rect...) {
    BeginScissorMode(rect[0], rect[1], rect[2], rect[3]);
}
/// Ditto
void setTextureRect(ivec2 pos, ivec2 size) {
    setTextureRect(pos.x, pos.y, size.x, size.y);
}

/// Finishes rendering into rect
void resetTextureRect() {
    EndScissorMode();
}

/// Use VR config for rendering
void setVRMode(VrStereoConfig config) {
    BeginVrStereoMode(config);
}

/// Stops using VR for rendering
void resetVRMode() {
    EndVrStereoMode();
}

/// Swaps screen buffer (renders buffer onto screen, use only with custom rendering)
void swapScreenBuffer() {
    SwapScreenBuffer();
}

/// Sets maximum (target) fps. Not recommended, use vsync(true);
void targetFPS(int _fps) {
    SetTargetFPS(_fps);
    _targetFPS = _fps;
}

/// Returns maximum (target) fps
int targetFPS() {
    return _targetFPS;
}

/// Returns current fps
int fps() {
    return GetFPS();
}

/// Returns delta time (time between frames)
float deltaTime() {
    return GetFrameTime();
}

/// Returns time elapsed from creating window
double elapsedTime() {
    return GetTime();
}
