module sily.raylib.physics2d.collision;

import sily.vector;

import sily.raylib.raytype;

import rl = raylib;

alias rRect = rl.Rectangle;

/// Check if rectangles are colliding
bool isColliding(vec4 rect1, vec4 rect2) {
    return rl.CheckCollisionRecs(rayType!rRect(rect1), rayType!rRect(rect2));
}

/// Check if circles are colliding
bool isColliding(vec2 p1, float r, vec2 p2, float r2) {
    return rl.CheckCollisionCircles(p1.rayType, r, p2.rayType, r2);
}

/// Check if circle colliding with rect
bool isColliding(vec2 p1, float r, vec4 rect) {
    return rl.CheckCollisionCircleRec(p1.rayType, r, rayType!rRect(rect));
}

/// Check if point in rect
bool isColliding(vec2 point, vec4 rect) {
    return rl.CheckCollisionPointRec(point.rayType, rayType!rRect(rect));
}

/// Check if point in circle
bool isColliding(vec2 point, vec2 pos, float radius) {
    return rl.CheckCollisionPointCircle(point.rayType, pos.rayType, radius);
}

/// Check if point in triangle
bool isColliding(vec2 point, vec2 p1, vec2 p2, vec2 p3) {
    return rl.CheckCollisionPointTriangle(point.rayType, p1.rayType, p2.rayType, p3.rayType);
}

/// Check if point in polygon
bool isColliding(vec2 point, vec2[] arr) {
    rl.Vector2[] va;
    foreach (a; arr) {
        va ~= a.rayType;
    }
    return rl.CheckCollisionPointPoly(point.rayType, va.ptr, cast(int) va.length);
}

/// Check if lines are colliding
bool isColliding(vec2 s1, vec2 e1, vec2 s2, vec2 e2, out vec2 p) {
    rl.Vector2 _p;
    bool c = rl.CheckCollisionLines(s1.rayType, e1.rayType, s2.rayType, e2.rayType, &_p);
    p = _p.rayType;
    return c;
}

/// Check if point on line (threshold in pixels)
bool isColliding(vec2 p, vec2 p1, vec2 p2, int threshold) {
    return rl.CheckCollisionPointLine(p.rayType, p1.rayType, p2.rayType, threshold);
}

/// Returns collision rectangle between rect1 and rect2
vec4 getCollisionRect(vec4 rect1, vec4 rect2) {
    return rl.GetCollisionRec(rayType!rRect(rect1), rayType!rRect(rect2)).rayType;
}

