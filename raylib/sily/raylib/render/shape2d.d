/// 2D Shape render
module sily.raylib.render.shape2d;

import std.string: toStringz;

import rl = raylib;

import sily.color: col;
import sily.vector: ivec2, ivec3, ivec4, vec2, vec3, vec4;

import sily.raylib.raytype;

/// Set texutre for shape rendering
void setShapesTexture(rl.Texture tex, vec4 rectangle) {
    rl.SetShapesTexture(tex, rayType!(rl.Rectangle)(rectangle));
}

/// Draws a single pixel
void drawPixel(ivec2 pos, col p_color) {
    rl.DrawPixel(pos.x, pos.y, p_color.rayType);
}

/// Draws line
void drawLine(ivec2 pos1, ivec2 pos2, col p_color) {
    rl.DrawLine(pos1.x, pos1.y, pos2.x, pos2.y, p_color.rayType);
}
/// Ditto
void drawLine(ivec2 pos1, ivec2 pos2, float thick, col p_color) {
    rl.DrawLineEx(pos1.rayType, pos2.rayType, thick, p_color.rayType);
}

/// Draw bezier curve 
void drawLineBezier(ivec2 pos1, ivec2 pos2, float thick, col p_color) {
    rl.DrawLineBezier(pos1.rayType, pos2.rayType, thick, p_color.rayType);
}
/// Ditto
void drawLineBezier(ivec2 pos1, ivec2 pos2, ivec2 ctrl, float thick, col p_color) {
    rl.DrawLineBezierQuad(pos1.rayType, pos2.rayType, ctrl.rayType, thick, p_color.rayType);
}
/// Ditto
void drawLineBezier(ivec2 pos1, ivec2 pos2, ivec2 ctrl1, ivec2 ctrl2, float thick, col p_color) {
    rl.DrawLineBezierCubic(pos1.rayType, pos2.rayType, ctrl1.rayType, ctrl2.rayType, thick, p_color.rayType);
}

/// Draws line sequence
void drawLineStrip(ivec2[] points, col p_color) {
    rl.Vector2[] vecs = [];
    foreach (point; points) {
        vecs ~= point.rayType;
    }
    rl.DrawLineStrip(vecs.ptr, cast(int) vecs.length, p_color.rayType);
}

/// Draws filled circle
void drawCircle(ivec2 pos, float r, col p_color) {
    rl.DrawCircle(pos.x, pos.y, r, p_color.rayType);
}
/// Draws filled circle
void drawCircle(ivec2 pos, float r, col p_color1, col p_color2) {
    rl.DrawCircleGradient(pos.x, pos.y, r, p_color1.rayType, p_color2.rayType);
}

/// Draws circle outline
void drawCircleLine(ivec2 pos, float r, col p_color) {
    rl.DrawCircleLines(pos.x, pos.y, r, p_color.rayType);
}

/// Draws filled slice of circle
void drawCircleSector(ivec2 pos, float r, float angle1, float angle2, int segments, col p_color) {
    rl.DrawCircleSector(pos.rayType, r, angle1, angle2, segments, p_color.rayType);
}

/// Draws slice of circle outline
void drawCircleSectorLine(ivec2 pos, float r, float angle1, float angle2, int segments, col p_color) {
    rl.DrawCircleSectorLines(pos.rayType, r, angle1, angle2, segments, p_color.rayType);
}

/// Draws ellipse
void drawEllipse(ivec2 pos, float rH, float rV, col p_color) {
    rl.DrawEllipse(pos.x, pos.y, rH, rV, p_color.rayType);
}

/// Draws ellipse outline
void drawEllipseLine(ivec2 pos, float rH, float rV, col p_color) {
    rl.DrawEllipseLines(pos.x, pos.y, rH, rV, p_color.rayType);
}

// void DrawRing(Vector2 center, float innerRadius, float outerRadius, float startAngle, float endAngle, int segments, Color color); // Draw ring
// void DrawRingLines(Vector2 center, float innerRadius, float outerRadius, float startAngle, float endAngle, int segments, Color color);    // Draw ring outline
// void DrawRectangle(int posX, int posY, int width, int height, Color color);                        // Draw a color-filled rectangle
// void DrawRectangleV(Vector2 position, Vector2 size, Color color);                                  // Draw a color-filled rectangle (Vector version)
// void DrawRectangleRec(Rectangle rec, Color color);                                                 // Draw a color-filled rectangle
// void DrawRectanglePro(Rectangle rec, Vector2 origin, float rotation, Color color);                 // Draw a color-filled rectangle with pro parameters
// void DrawRectangleGradientV(int posX, int posY, int width, int height, Color color1, Color color2);// Draw a vertical-gradient-filled rectangle
// void DrawRectangleGradientH(int posX, int posY, int width, int height, Color color1, Color color2);// Draw a horizontal-gradient-filled rectangle
// void DrawRectangleGradientEx(Rectangle rec, Color col1, Color col2, Color col3, Color col4);       // Draw a gradient-filled rectangle with custom vertex colors
// void DrawRectangleLines(int posX, int posY, int width, int height, Color color);                   // Draw rectangle outline
// void DrawRectangleLinesEx(Rectangle rec, float lineThick, Color color);                            // Draw rectangle outline with extended parameters
// void DrawRectangleRounded(Rectangle rec, float roundness, int segments, Color color);              // Draw rectangle with rounded edges
// void DrawRectangleRoundedLines(Rectangle rec, float roundness, int segments, float lineThick, Color color); // Draw rectangle with rounded edges outline
// void DrawTriangle(Vector2 v1, Vector2 v2, Vector2 v3, Color color);                                // Draw a color-filled triangle (vertex in counter-clockwise order!)
// void DrawTriangleLines(Vector2 v1, Vector2 v2, Vector2 v3, Color color);                           // Draw triangle outline (vertex in counter-clockwise order!)
// void DrawTriangleFan(Vector2 *points, int pointCount, Color color);                                // Draw a triangle fan defined by points (first vertex is the center)
// void DrawTriangleStrip(Vector2 *points, int pointCount, Color color);                              // Draw a triangle strip defined by points
// void DrawPoly(Vector2 center, int sides, float radius, float rotation, Color color);               // Draw a regular polygon (Vector version)
// void DrawPolyLines(Vector2 center, int sides, float radius, float rotation, Color color);          // Draw a polygon outline of n sides
// void DrawPolyLinesEx(Vector2 center, int sides, float radius, float rotation, float lineThick, Color color); // Draw a polygon outline of n sides with extended parameters






