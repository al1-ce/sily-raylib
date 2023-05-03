/++
Window creation and manipulation utils
+/
module sily.raylib.window;

import std.string : toStringz;
import std.conv : to;

import sily.vector;

import raylib;

import cfg = sily.raylib.config;

private bool _isInit = false;
bool isInitialised() {
    return _isInit;
}

alias isInitialized = isInitialised;

private bool _cursorLocked = false;

void create(int width, int height, string title) {
    if (cfg.configFlags != 0) {
        SetConfigFlags(cfg.configFlags);
    }
    InitWindow(width, height, title.toStringz);
    _isInit = true;
}

void create(ivec2 size, string title) {
    create(size.x, size.y, title);
}

bool shouldClose() {
    return WindowShouldClose();
}

alias closeRequested = shouldClose;

void close() {
    CloseWindow();
    _isInit = false;
    cfg.stateReset();
}

bool ready() {
    return IsWindowReady();
}

bool fullscreen() {
    return IsWindowFullscreen();
}

void fullscreen(bool state) {
    if (fullscreen != state) {
        ToggleFullscreen();
    }
}

void fullscreenToggle() {
    ToggleFullscreen();
}

bool hidden() {
    return IsWindowHidden();
}

void restore() {
    RestoreWindow();
}

bool minimised() {
    return IsWindowMinimized();
}
/// Ditto
alias minimized = minimised;

void minimise() {
    MinimizeWindow();
}
/// Ditto
alias minimize = minimise;

bool maximised() {
    return IsWindowMaximized();
}
/// Ditto
alias maximized = maximised;

void maximise() {
    MaximizeWindow();
}
/// Ditto
alias maximize = maximise;

bool focused() {
    return IsWindowFocused();
}

bool resized() {
    return IsWindowResized();
}

void setIcon(Image image) {
    SetWindowIcon(image);
}

void setIcons(Image[] images) {
    SetWindowIcons(images.ptr, cast(int) images.length);
}

void setTitle(string title) {
    SetWindowTitle(title.toStringz);
}

void position(int x, int y) {
    SetWindowPosition(x, y);
}

void position(ivec2 pos) {
    position(pos.x, pos.y);
}

ivec2 position() {
    raylib.Vector2 v = GetWindowPosition();
    return ivec2(cast(int) v.x, cast(int) v.y);
}

void sizeMin(int w, int h) {
    SetWindowMinSize(w, h);
}

void sizeMin(ivec2 _size) {
    sizeMin(_size.x, _size.y);
}

void size(int w, int h) {
    SetWindowSize(w, h);
}

void size(ivec2 _size) {
    size(_size.x, _size.y);
}

ivec2 size() {
    return ivec2(width(), height());
}

void width(int w) {
    size(w, height());
}

int width() {
    return GetScreenWidth();
}

void height(int h) {
    size(width(), h);
}

int height() {
    return GetScreenHeight();
}

int renderWidth() {
    return GetRenderWidth();
}

int renderHeight() {
    return GetRenderHeight();
}

ivec2 renderSize() {
    return ivec2(renderWidth(), renderHeight());
}

ivec2 scaleDPI() {
    raylib.Vector2 v = GetWindowScaleDPI();
    return ivec2(cast(int) v.x, cast(int) v.y);
}

void moveToMonitor(int monitor) {
    SetWindowMonitor(monitor);
}

void opacity(float _opacity) {
    SetWindowOpacity(_opacity);
}

void* handle() {
    return GetWindowHandle();
}

void clipboard(string text) {
    SetClipboardText(text.toStringz);
}

string clipboard() {
    return GetClipboardText().to!string;
}

void eventWaiting(bool enabled) {
    if (enabled) {
        EnableEventWaiting();
    } else {
        DisableEventWaiting();
    }
}

// TODO: move it?
void pollInputEvents() {
    PollInputEvents();
}

void wait(double sec) {
    WaitTime(sec);
}

void showCursor() {
    ShowCursor();
}

void hideCursor() {
    HideCursor();
}

bool cursorHidden() {
    return IsCursorHidden();
}

void unlockCursor() {
    EnableCursor();
    _cursorLocked = false;
}

void lockCursor() {
    DisableCursor();
    _cursorLocked = true;
}

bool cursorLocked() {
    return _cursorLocked;
}

bool cursorOnWindow() {
    return IsCursorOnScreen();
}

