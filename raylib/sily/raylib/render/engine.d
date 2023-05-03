module sily.raylib.render.engine;

import sily.vector;
import sc = sily.color;

import raylib;

private int _targetFPS = 60;

void clearBackground(sc.Color col) {
    ClearBackground(Color(col.r8, col.g8, col.b8, col.a8));
}

void startRender() {
    BeginDrawing();
}

alias start = startRender;

void finishRender() {
    EndDrawing();
}

alias finish = finishRender;

void setCamera2D(Camera2D camera) {
    BeginMode2D(camera);
}

void resetCamera2D() {
    EndMode2D();
}

void setCamera3D(Camera3D camera) {
    BeginMode3D(camera);
}

alias setCamera = setCamera3D;

void resetCamera3D() {
    EndMode3D();
}

alias resetCamera = resetCamera3D;

void setTextureTarget(RenderTexture2D target) {
    BeginTextureMode(target);
}

void resetTextureTarget() {
    EndTextureMode();
}

void setShader(Shader shader) {
    BeginShaderMode(shader);
}

void resetShader() {
    EndShaderMode();
}

void setBlendMode(int mode) {
    BeginBlendMode(mode);
}

void resetBlendMode() {
    EndBlendMode();
}

void setTextureRect(int x, int y, int width, int height) {
    BeginScissorMode(x, y, width, height);
}

void setTextureRect(ivec2 pos, ivec2 size) {
    setTextureRect(pos.x, pos.y, size.x, size.y);
}

void setTextureRect(ivec4 rect) {
    setTextureRect(rect.x, rect.y, rect.z, rect.w);
}

void resetTextureRect() {
    EndScissorMode();
}

void setVRMode(VrStereoConfig config) {
    BeginVrStereoMode(config);
}

void resetVRMode() {
    EndVrStereoMode();
}

void swapScreenBuffer() {
    SwapScreenBuffer();
}

/// Sets maximum (target) fps. Not recommended, use WindowConfig.vsync(true);
void targetFPS(int _fps) {
    SetTargetFPS(_fps);
    _targetFPS = _fps;
}

int targetFPS() {
    return _targetFPS;
}

int fps() {
    return GetFPS();
}

float deltaTime() {
    return GetFrameTime();
}

double elapsedTime() {
    return GetTime();
}
