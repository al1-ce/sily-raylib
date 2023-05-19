/// Text render
module sily.raylib.render.text;

import std.string: toStringz;

import raylib;

import sily.color: col;
import sily.vector: vec2, ivec2;

import sily.raylib.raytype;

/// Draws current fps at pos
void drawFPS(int[2] pos...) {
    DrawFPS(pos[0], pos[1]);
}

// Draw text
void drawText(string text, int x, int y, int fontSize, col p_color) {
    DrawText(text.toStringz, x, y, fontSize, p_color.rayType);
}
/// Ditto
void drawText(string text, ivec2 pos, int fontSize, col p_color) {
    drawText(text, pos.x, pos.y, fontSize, p_color);
}
/// Ditto
void drawText(string text, ivec2 pos, Font font, int fontSize, float spacing, col p_color) {
    DrawTextEx(font, text.toStringz, pos.rayType, fontSize, spacing, p_color.rayType);
}
/// Ditto
void drawText(string text, ivec2 pos, ivec2 origin, float rotation, 
        Font font, int fontSize, float spacing, col p_color) {
    DrawTextPro(font, text.toStringz, pos.rayType, origin.rayType, rotation,
            fontSize, spacing, p_color.rayType);
}

/// Returns text width with current font
int textWidth(string text, int fontSize) {
    return MeasureText(text.toStringz, fontSize);
}

/// Returns text size with selected font and settings
vec2 textSize(Font font, string text, float fontSize, float spacing) {
    return MeasureTextEx(font, text.toStringz, fontSize, spacing).rayType;
}

