/++
Window creation and manipulation utils
+/
module sily.raylib.window;

import std.string : toStringz;
import std.conv : to;

import sily.vector;

import raylib;

import cfg = sily.raylib.config;
import sily.raylib.input.keyboard: Key;

/// Sets exit key (ESC by default) 
void setExitKey(int key) {
    SetExitKey(key);
}

/// Ditto
void setExitKey(Key key) {
    setExitKey(cast(int) key);
}

/// Private init tracking
private bool _isInit = false;
/// Is window been initialised (opened)
bool isInitialised() {
    return _isInit;
}
/// Ditto
alias isInitialized = isInitialised;

/// Private cursor lock tracking
private bool _cursorLocked = false;

/// Opens new window
void create(int width, int height, string title) {
    if (cfg.configFlags != 0) {
        SetConfigFlags(cfg.configFlags);
    }
    InitWindow(width, height, title.toStringz);
    _isInit = true;
}
/// Ditto
void create(ivec2 size, string title) {
    create(size.x, size.y, title);
}

/// Should window close (window close button been pressed)
bool shouldClose() {
    return WindowShouldClose();
}
/// Ditto
alias closeRequested = shouldClose;

/// Closes window and resets config flags
void close() {
    CloseWindow();
    _isInit = false;
    cfg.stateReset();
}

/// Has window initialised successfully
bool ready() {
    return IsWindowReady();
}
/// Checks if window is fullscreen
bool fullscreen() {
    return IsWindowFullscreen();
}

/// Set fullscreen mode
void fullscreen(bool state) {
    if (fullscreen != state) {
        ToggleFullscreen();
    }
}

/// Toggle fullscreen mode
void fullscreenToggle() {
    ToggleFullscreen();
}

/// Is window hidden
bool hidden() {
    return IsWindowHidden();
}

/// Restores window (sets not minimised nor maximised)
void restore() {
    RestoreWindow();
}

/// Is window minimised
bool minimised() {
    return IsWindowMinimized();
}
/// Ditto
alias minimized = minimised;

/// Minimises window
void minimise() {
    MinimizeWindow();
}
/// Ditto
alias minimize = minimise;

/// Is window maximised
bool maximised() {
    return IsWindowMaximized();
}
/// Ditto
alias maximized = maximised;

/// Maximises window
void maximise() {
    MaximizeWindow();
}
/// Ditto
alias maximize = maximise;

/// Is window focused
bool focused() {
    return IsWindowFocused();
}

/// Has window been resized
bool resized() {
    return IsWindowResized();
}

/// Set window icon(s)
void setIcon(Image image) {
    SetWindowIcon(image);
}
/// Ditto
void setIcons(Image[] images) {
    SetWindowIcons(images.ptr, cast(int) images.length);
}

/// Set window title
void setTitle(string title) {
    SetWindowTitle(title.toStringz);
}

/// Move window to position
void position(int[2] pos...) {
    SetWindowPosition(pos[0], pos[1]);
}

/// Return current window position
ivec2 position() {
    raylib.Vector2 v = GetWindowPosition();
    return ivec2(cast(int) v.x, cast(int) v.y);
}

/// Sets minimum window size
void sizeMin(int[2] _size...) {
    SetWindowMinSize(_size[0], _size[1]);
}

/// Sets window size
void size(int[2] _size...) {
    SetWindowSize(_size[0], _size[1]);
}

/// Returns current window size
ivec2 size() {
    return ivec2(width(), height());
}

/// Sets window width
void width(int w) {
    size(w, height());
}

/// Returns window width
int width() {
    return GetScreenWidth();
}

/// Sets window height
void height(int h) {
    size(width(), h);
}

/// Returns window height
int height() {
    return GetScreenHeight();
}

/// Get render surface width
int renderWidth() {
    return GetRenderWidth();
}

/// Get render surface height
int renderHeight() {
    return GetRenderHeight();
}

/// Get render surface size
ivec2 renderSize() {
    return ivec2(renderWidth(), renderHeight());
}

/// Returns DPI scale
ivec2 scaleDPI() {
    raylib.Vector2 v = GetWindowScaleDPI();
    return ivec2(cast(int) v.x, cast(int) v.y);
}

/// Move window to monitor
void moveToMonitor(int monitor) {
    SetWindowMonitor(monitor);
}

/// Sets window opacity (opacity flag required)
void opacity(float _opacity) {
    SetWindowOpacity(_opacity);
}

/// Returns GLFW window handle
void* handle() {
    return GetWindowHandle();
}

/// Sets clipboard text
void clipboard(string text) {
    SetClipboardText(text.toStringz);
}

/// Returns contents of clipboard
string clipboard() {
    return GetClipboardText().to!string;
}

/++
Enables / diables event waiting on render.finish / render.finishRender.
Params:
    enabled = true - wait for events, no polling, false - no wait, auto polling
+/
void eventWaiting(bool enabled) {
    if (enabled) {
        EnableEventWaiting();
    } else {
        DisableEventWaiting();
    }
}

// Polls window events (use if eventWaiting(false))
void pollInputEvents() {
    PollInputEvents();
}

/// Waits for `sec` seconds
void wait(double sec) {
    WaitTime(sec);
}

/// Shows cursor
void showCursor() {
    ShowCursor();
}

/// Hides cursor
void hideCursor() {
    HideCursor();
}

/// Returns is cursor hidden
bool cursorHidden() {
    return IsCursorHidden();
}

/// Unlocks cursor from center of screen
void unlockCursor() {
    EnableCursor();
    _cursorLocked = false;
}

/// Lock cursor at center of screen
void lockCursor() {
    DisableCursor();
    _cursorLocked = true;
}

/// Returns is cursor locked at center of screen
bool cursorLocked() {
    return _cursorLocked;
}

/// Is cursor hovering over window (not same as focused)
bool cursorOnWindow() {
    return IsCursorOnScreen();
}

/// Takes screenshot (filename extension defines format)
void takeScreenshot(string filename) {
    TakeScreenshot(filename.toStringz);
}

/// Opens URL with default browser
void openURL(string url) {
    OpenURL(url.toStringz);
}


