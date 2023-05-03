/++
Monitor related utils
+/
module sily.raylib.monitor;

import std.string: toStringz;
import std.conv: to;

import sily.vector;

import raylib;

int monitorCount() {
    return GetMonitorCount();
}

int monitorCurrent() {
    return GetCurrentMonitor();
}

ivec2 monitorPosition(int m) {
    raylib.Vector2 v = GetMonitorPosition(m);
    return ivec2(cast(int) v.x, cast(int) v.y);
}

int monitorWidth(int m) {
    return GetMonitorWidth(m);
}

int monitorHeight(int m) {
    return GetMonitorHeight(m);
}

ivec2 monitorSize(int m) {
    return ivec2(monitorWidth(m), monitorHeight(m));
}

int monitorPhysicalWidth(int m) {
    return GetMonitorPhysicalWidth(m);
}

int monitorPhysicalHeight(int m) {
    return GetMonitorPhysicalHeight(m);
}

ivec2 monitorPhysicalSize(int m) {
    return ivec2(monitorPhysicalWidth(m), monitorPhysicalHeight(m));
}

int monitorRefreshRate(int m) {
    return GetMonitorRefreshRate(m);
}

string monitorName(int m) {
    return GetMonitorName(m).to!string;
}
