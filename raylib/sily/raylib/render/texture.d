module sily.raylib.render.texture;

import sily.vector;
import sily.color;

import sily.raylib.raytype;

import rl = raylib;

alias rTexture = rl.Texture;
alias rRect = rl.Rectangle;

/// Draw texture
void drawTexture(rTexture tex, int posx, int posy, col tint = Colors.white) {
    rl.DrawTexture(tex, posx, posy, tint.rayType);
}
/// Ditto
void drawTexture(rTexture tex, vec2 pos, col tint = Colors.white) {
    rl.DrawTextureV(tex, pos.rayType, tint.rayType);
}
/// Ditto
void drawTexture(rTexture tex, vec2 pos, float rot, float scale, col tint = Colors.white) {
    rl.DrawTextureEx(tex, pos.rayType, rot, scale, tint.rayType);
}
/// Ditto
void drawTexture(rTexture tex, vec4 srcRect, vec2 pos, col tint = Colors.white) {
    rl.DrawTextureRec(tex, rayType!rRect(srcRect), pos.rayType, tint.rayType);
}
/// Ditto
void drawTexture(rTexture tex, vec4 srcRect, vec4 dstRect, vec2 origin, float rot, col tint = Colors.white) {
    rl.DrawTexturePro(tex, rayType!rRect(srcRect), rayType!rRect(dstRect), origin.rayType, rot, tint.rayType);
}
/// Ditto
void drawTexture(rTexture tex, rl.NPatchInfo pi, vec4 dstRect, vec2 origin, float rot, col tint = Colors.white) {
    rl.DrawTextureNPatch(tex, pi, rayType!rRect(dstRect), origin.rayType, rot, tint.rayType);
}


