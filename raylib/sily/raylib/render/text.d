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

// TODO: func

// // Text font info functions
// int MeasureText(const char *text, int fontSize);                                      // Measure string width for default font
// Vector2 MeasureTextEx(Font font, const char *text, float fontSize, float spacing);    // Measure string size for Font
// int GetGlyphIndex(Font font, int codepoint);                                          // Get glyph index position in font for a codepoint (unicode character), fallback to '?' if not found
// GlyphInfo GetGlyphInfo(Font font, int codepoint);                                     // Get glyph font info data for a codepoint (unicode character), fallback to '?' if not found
// Rectangle GetGlyphAtlasRec(Font font, int codepoint);                                 // Get glyph rectangle in font atlas for a codepoint (unicode character), fallback to '?' if not found

