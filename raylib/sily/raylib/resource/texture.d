module sily.raylib.resource.texture;

import std.string: toStringz;

import sily.raylib.raytype;
import sily.vector;
import sily.color;

import rl = raylib;

alias rImage = rl.Image;
alias rRect = rl.Rectangle;
alias rFont = rl.Font;

/+
T *t -> ref T t
ImageFormat(Image *image) -> ImageFormat(ref rImage image)

ImageAction -> action
ImageFormat -> format(ref rImage image, int newFormat)

Color -> col
Rectangle -> vec4
Vector2 -> vec2
Vector3 -> vec3
Vector4 -> vec4

R action(args) {
    rl.OgFunc(args);
}

+/

void format(ref rImage img, int newFormat) {
    rl.ImageFormat(&img, newFormat);
}

void imageToPOT(ref rImage img, col fill) {
    rl.ImageToPOT(&img, fill.rayType);
}

void cropRegion(ref rImage img, vec4 _crop) {
    rl.ImageCrop(&img, rayType!rRect(_crop));
}

void cropAlpha(ref rImage img, float threshold) {
    rl.ImageAlphaCrop(&img, threshold);
}

void clearAlpha(ref rImage img, col color, float threshold) {
    rl.ImageAlphaClear(&img, color.rayType, threshold);
}

void alphaMask(ref rImage img, rImage _alphaMask) {
    rl.ImageAlphaMask(&img, _alphaMask);
}

void alphaPremultiply(ref rImage img) {
    rl.ImageAlphaPremultiply(&img);
}

void blurGaussian(ref rImage img, int blurSize) {
    rl.ImageBlurGaussian(&img, blurSize);
}

void resize(ref rImage img, int newWidth, int newHeight, bool nearest = false) {
    if (nearest) {
        rl.ImageResizeNN(&img, newWidth, newHeight);
    } else {
        rl.ImageResize(&img, newWidth, newHeight);
    }
}

void resize(ref rImage img, int newWidth, int newHeight, int offsetX, int offsetY, col fill) {
    rl.ImageResizeCanvas(&img, newWidth, newHeight, offsetX, offsetY, fill.rayType);
}

void generateMipmaps(ref rImage img) {
    rl.ImageMipmaps(&img);
}

void dither(ref rImage img, int rBpp, int gBpp, int bBpp, int aBpp) {
    rl.ImageDither(&img, rBpp, gBpp, bBpp, aBpp);
}

void flipVertical(ref rImage img) {
    rl.ImageFlipVertical(&img);
}

void flipHorizontal(ref rImage img) {
    rl.ImageFlipHorizontal(&img);
}

void rotateCW(ref rImage img) {
    rl.ImageRotateCW(&img);
}

void rotateCWW(ref rImage img) {
    rl.ImageRotateCCW(&img);
}

void tintImage(ref rImage img, col color) {
    rl.ImageColorTint(&img, color.rayType);
}

void invertColor(ref rImage img) {
    rl.ImageColorInvert(&img);
}

void makeGrayscale(ref rImage img) {
    rl.ImageColorGrayscale(&img);
}

void imageContrast(ref rImage img, float contrast) {
    rl.ImageColorContrast(&img, contrast);
}

void imageBrightness(ref rImage img, int brightness) {
    rl.ImageColorBrightness(&img, brightness);
}

void colorReplace(ref rImage img, col color, col replace) {
    rl.ImageColorReplace(&img, color.rayType, replace.rayType);
}

vec4 alphaBorder(rImage img, float threshold) {
    return rl.GetImageAlphaBorder(img, threshold).rayType;
}

col imageColor(rImage img, int x, int y) {
    return rl.GetImageColor(img, x, y).rayType;
}

void clearBackground(ref rImage dst, col color) {
    rl.ImageClearBackground(&dst, color.rayType);
}

void drawPixel(ref rImage dst, int posX, int posY, col color) {
    rl.ImageDrawPixel(&dst, posX, posY, color.rayType);
}

void drawPixel(ref rImage dst, vec2 position, col color) {
    rl.ImageDrawPixelV(&dst, position.rayType, color.rayType);
}

void drawLine(ref rImage dst, int startPosX, int startPosY, int endPosX, int endPosY, col color) {
    rl.ImageDrawLine(&dst, startPosX, startPosY, endPosX, endPosY, color.rayType);
}

void drawLine(ref rImage dst, vec2 start, vec2 end, col color) {
    rl.ImageDrawLineV(&dst, start.rayType, end.rayType, color.rayType);
}

void drawCircle(ref rImage dst, int centerX, int centerY, int radius, col color) {
    rl.ImageDrawCircle(&dst, centerX, centerY, radius, color.rayType);
}

void drawCircle(ref rImage dst, vec2 center, int radius, col color) {
    rl.ImageDrawCircleV(&dst, center.rayType, radius, color.rayType);
}

void drawCircleLines(ref rImage dst, int centerX, int centerY, int radius, col color) {
    rl.ImageDrawCircleLines(&dst, centerX, centerY, radius, color.rayType);
}

void drawCircleLines(ref rImage dst, vec2 center, int radius, col color) {
    rl.ImageDrawCircleLinesV(&dst, center.rayType, radius, color.rayType);
}

void drawRectangle(ref rImage dst, int posX, int posY, int width, int height, col color) {
    rl.ImageDrawRectangle(&dst, posX, posY, width, height, color.rayType);
}

void drawRectangle(ref rImage dst, vec2 position, vec2 size, col color) {
    rl.ImageDrawRectangleV(&dst, position.rayType, size.rayType, color.rayType);
}

void drawRectangleRec(ref rImage dst, vec4 rec, col color) {
    rl.ImageDrawRectangleRec(&dst, rayType!rRect(rec), color.rayType);
}

void drawRectangleLines(ref rImage dst, vec4 rec, int thick, col color) {
    rl.ImageDrawRectangleLines(&dst, rayType!rRect(rec), thick, color.rayType);
}

void drawImage(ref rImage dst, rImage src, vec4 srcRec, vec4 dstRec, col tint) {
    rl.ImageDraw(&dst, src, rayType!rRect(srcRec), rayType!rRect(dstRec), tint.rayType);
}

void drawText(ref rImage dst, string text, int posX, int posY, int fontSize, col color) {
    rl.ImageDrawText(&dst, text.toStringz, posX, posY, fontSize, color.rayType);
}

void drawText(ref rImage dst, rFont font, string text, vec2 position, float fontSize, float spacing, col tint) {
    rl.ImageDrawTextEx(&dst, font, text.toStringz, position.rayType, fontSize, spacing, tint.rayType);
}

import std.file: isDir, exists;
import std.path: isValidPath, buildNormalizedPath, dirSeparator;
import std.string: toStringz;
import std.conv: to;

import sily.raylib.resource.manager;

// loadImage and loadTexture + unload are defined in manager

private string makePath(string path) {
    return resourcePath ~ dirSeparator ~ path;
}

rImage loadImageRaw(string filepath, int w, int h, int _format, int headerSize) {
    if (cached!rImage(filepath)) {
        return getCache!rImage(filepath);
    } else {
        string fp = filepath.makePath;
        if (!fp.exists) return nopath!rImage(fp);
        rImage res = rl.LoadImageRaw(fp.toStringz, w, h, _format, headerSize);
        cache!rImage(filepath, res);
        return res;
    }
}

// Image LoadImageRaw(const char *fileName, int width, int height, int format, int headerSize);       // Load image from RAW file data
// Image LoadImageAnim(const char *fileName, int *frames);                                            // Load image sequence from file (frames appended to image.data)
// Image LoadImageFromMemory(const char *fileType, const unsigned char *fileData, int dataSize);      // Load image from memory buffer, fileType refers to extension: i.e. '.png'
// Image LoadImageFromTexture(Texture2D texture);                                                     // Load image from GPU texture data
// Image LoadImageFromScreen(void);                                                                   // Load image from screen buffer and (screenshot)
// bool IsImageReady(Image image);                                                                    // Check if an image is ready
// void UnloadImage(Image image);                                                                     // Unload image from CPU memory (RAM)
// bool ExportImage(Image image, const char *fileName);                                               // Export image data to file, returns true on success
// bool ExportImageAsCode(Image image, const char *fileName);                                         // Export image as code file defining an array of bytes, returns true on success

// // Image manipulation functions
// Image ImageCopy(Image image);                                                                      // Create an image duplicate (useful for transformations)
// Image ImageFromImage(Image image, Rectangle rec);                                                  // Create an image from another image piece
// Image ImageText(const char *text, int fontSize, Color color);                                      // Create an image from text (default font)
// Image ImageTextEx(Font font, const char *text, float fontSize, float spacing, Color tint);         // Create an image from text (custom sprite font)

// // Image generation functions
// Image GenImageColor(int width, int height, Color color);                                           // Generate image: plain color
// Image GenImageGradientV(int width, int height, Color top, Color bottom);                           // Generate image: vertical gradient
// Image GenImageGradientH(int width, int height, Color left, Color right);                           // Generate image: horizontal gradient
// Image GenImageGradientRadial(int width, int height, float density, Color inner, Color outer);      // Generate image: radial gradient
// Image GenImageChecked(int width, int height, int checksX, int checksY, Color col1, Color col2);    // Generate image: checked
// Image GenImageWhiteNoise(int width, int height, float factor);                                     // Generate image: white noise
// Image GenImagePerlinNoise(int width, int height, int offsetX, int offsetY, float scale);           // Generate image: perlin noise
// Image GenImageCellular(int width, int height, int tileSize);                                       // Generate image: cellular algorithm, bigger tileSize means bigger cells
// Image GenImageText(int width, int height, const char *text);                                       // Generate image: grayscale image from text data

// Texture2D LoadTextureFromImage(Image image);                                                       // Load texture from image data\

// TextureCubemap LoadTextureCubemap(Image image, int layout);                                        // Load cubemap from image, multiple image cubemap layouts supported
// RenderTexture2D LoadRenderTexture(int width, int height);                                          // Load texture for rendering (framebuffer)
//
// // Texture loading functions
// // NOTE: These functions require GPU access
// bool IsTextureReady(Texture2D texture);                                                            // Check if a texture is ready
// bool IsRenderTextureReady(RenderTexture2D target);                                                       // Check if a render texture is ready
// void UpdateTexture(Texture2D texture, const void *pixels);                                         // Update GPU texture with new data
// void UpdateTextureRec(Texture2D texture, Rectangle rec, const void *pixels);                       // Update GPU texture rectangle with new data
//
// // Texture configuration functions
// void GenTextureMipmaps(Texture2D *texture);                                                        // Generate GPU mipmaps for a texture
// void SetTextureFilter(Texture2D texture, int filter);                                              // Set texture scaling filter mode
// void SetTextureWrap(Texture2D texture, int wrap);                                                  // Set texture wrapping mode
//

// DO NOT TOUCH END

