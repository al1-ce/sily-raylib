/++
Window/System configuration. Primarily window flags (aka raylib's FLAG_...)
+/
module sily.raylib.config;

import std.string : toStringz;
import std.conv : to;

import sily.vector;

import raylib;

import win = sily.raylib.window;

private uint _configFlags = 0;
uint configFlags() {
    return _configFlags;
}

private uint _configAll = 0xFFFFFFFF;

void stateReset() {
    _configFlags = 0;
    if (win.isInitialised)
        stateDisable(_configAll);
}
// config stuff
// flag add = A | B
// flag rem = A & ~B

/// Set to try enabling V-Sync
void vsync(bool enabled) {
    stateSet(Config.FLAG_VSYNC_HINT, enabled);
}
/// Ditto
bool vsync() {
    return stateEnabled(Config.FLAG_VSYNC_HINT);
}

/// Set to run/start in fullscreen 
void fullscreenMode(bool enabled) {
    stateSet(Config.FLAG_FULLSCREEN_MODE, enabled);
}
/// Ditto
bool fullscreenMode() {
    return stateEnabled(Config.FLAG_FULLSCREEN_MODE);
}

/// Set to allow resizing window
void resizable(bool enabled) {
    stateSet(Config.FLAG_WINDOW_RESIZABLE, enabled);
}
/// Ditto
bool resizable() {
    return stateEnabled(Config.FLAG_WINDOW_RESIZABLE);
}

/// Set to remove window decorations
void undecorated(bool enabled) {
    stateSet(Config.FLAG_WINDOW_UNDECORATED, enabled);
}
/// Ditto
bool undecorated() {
    return stateEnabled(Config.FLAG_WINDOW_UNDECORATED);
}

/// Set to hide window
void hiddenMode(bool enabled) {
    stateSet(Config.FLAG_WINDOW_HIDDEN, enabled);
}
/// Ditto
bool hiddenMode() {
    return stateEnabled(Config.FLAG_WINDOW_HIDDEN);
}

/// Set to maximize window
void maximisedMode(bool enabled) {
    stateSet(Config.FLAG_WINDOW_MAXIMIZED, enabled);
}
/// Ditto
bool maximisedMode() {
    return stateEnabled(Config.FLAG_WINDOW_MAXIMIZED);
}
/// Ditto
alias maximizedMode = maximisedMode;

/// Set to minimize window
void minimisedMode(bool enabled) {
    stateSet(Config.FLAG_WINDOW_MINIMIZED, enabled);
}
/// Ditto
bool minimisedMode() {
    return stateEnabled(Config.FLAG_WINDOW_MINIMIZED);
}
/// Ditto
alias minimizedMode = minimisedMode;

/// Set to make window non focused
void unfocused(bool enabled) {
    stateSet(Config.FLAG_WINDOW_UNFOCUSED, enabled);
}
/// Ditto
bool unfocused() {
    return stateEnabled(Config.FLAG_WINDOW_UNFOCUSED);
}

/// Set to make windows always on top
void topmost(bool enabled) {
    stateSet(Config.FLAG_WINDOW_TOPMOST, enabled);
}
/// Ditto
bool topmost() {
    return stateEnabled(Config.FLAG_WINDOW_TOPMOST);
}

/// Set to allow window run in background
void alwaysRun(bool enabled) {
    stateSet(Config.FLAG_WINDOW_ALWAYS_RUN, enabled);
}
/// Ditto
bool alwaysRun() {
    return stateEnabled(Config.FLAG_WINDOW_ALWAYS_RUN);
}

/// Set to allow transparent framebuffer
void transparent(bool enabled) {
    stateSet(Config.FLAG_WINDOW_TRANSPARENT, enabled);
}
/// Ditto
bool transparent() {
    return stateEnabled(Config.FLAG_WINDOW_TRANSPARENT);
}

/// Set to support HDPI
void highDPI(bool enabled) {
    stateSet(Config.FLAG_WINDOW_HIGHDPI, enabled);
}
/// Ditto
bool highDPI() {
    return stateEnabled(Config.FLAG_WINDOW_HIGHDPI);
}

/// Set to support mouse passthrough, "undecorated" must be enabled 
void mousePassthrough(bool enabled) {
    stateSet(Config.FLAG_WINDOW_MOUSE_PASSTHROUGH, enabled);
}
/// Ditto
bool mousePassthrough() {
    return stateEnabled(Config.FLAG_WINDOW_MOUSE_PASSTHROUGH);
}

/// Set to try enabling msaa4x
void msaa4x(bool enabled) {
    stateSet(Config.FLAG_MSAA_4X_HINT, enabled);
}
/// Ditto
bool msaa4x() {
    return stateEnabled(Config.FLAG_MSAA_4X_HINT);
}

/// Set to try enabling interlaced video format
void interlaced(bool enabled) {
    stateSet(Config.FLAG_INTERLACED_HINT, enabled);
}
/// Ditto
bool interlaced() {
    return stateEnabled(Config.FLAG_INTERLACED_HINT);
}

/// Wrapper around stateEnable and stateDisable
private void stateSet(uint flag, bool state) {
    if (state == stateEnabled(flag))
        return;
    if (state == true) {
        stateEnable(flag);
    } else {
        stateDisable(flag);
    }
}

/// Checks if window state flag is set
bool stateEnabled(uint flag) {
    if (win.isInitialised) {
        return raylib.IsWindowState(flag);
    } else {
        return (_configFlags & flag) != 0;
    }
}

/**
    Sets/unsets window/system config, advanced usage, please prefer function variants.
    Example:
    ---
    Window.setState(Window.Config.FLAG_FULLSCREEN_MODE | Window.Config.FLAG_VSYNC_HINT)
    ---
    */
void stateEnable(uint conf) {
    // if (_isInit) throw new Error("Window flags must be set before creating window.");
    if (win.isInitialised) {
        SetWindowState(conf);
    } else {
        SetConfigFlags(conf);
    }
    _configFlags = _configFlags | conf;
}

/// Ditto
void stateDisable(uint conf) {
    if (win.isInitialised) {
        ClearWindowState(conf);
        _configFlags = _configFlags & ~conf;
    } else {
        traceLog!(LogLevel.LOG_WARNING)("Cannot unset state when window is not initialized.");
    }
}

/// Alias for raylib.ConfigFlags
alias Config = ConfigFlags;

/// Sets raylib log level to l
void setLogLevel(int l) {
    SetTraceLogLevel(l);
}

/// Alias for raylib.TraceLogLevel
alias LogLevel = TraceLogLevel;

/// Print debug message, default log level is LOG_INFO
void traceLog(int l = LogLevel.LOG_INFO)(string message) {
    TraceLog(l, message.toStringz);
}

void setTraceLogCallback(TraceLogCallback callback) {
    SetTraceLogCallback(callback);
}

