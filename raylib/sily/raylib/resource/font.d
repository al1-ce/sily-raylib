module sily.raylib.resource.font;

// // Font loading/unloading functions
// Font GetFontDefault(void);                                                            // Get the default Font
// Font LoadFont(const char *fileName);                                                  // Load font from file into GPU memory (VRAM)
// Font LoadFontEx(const char *fileName, int fontSize, int *fontChars, int glyphCount);  // Load font from file with extended parameters, use NULL for fontChars and 0 for glyphCount to load the default character set
// Font LoadFontFromImage(Image image, Color key, int firstChar);                        // Load font from Image (XNA style)
// Font LoadFontFromMemory(const char *fileType, const unsigned char *fileData, int dataSize, int fontSize, int *fontChars, int glyphCount); // Load font from memory buffer, fileType refers to extension: i.e. '.ttf'
// bool IsFontReady(Font font);                                                          // Check if a font is ready
// GlyphInfo *LoadFontData(const unsigned char *fileData, int dataSize, int fontSize, int *fontChars, int glyphCount, int type); // Load font data for further use
// Image GenImageFontAtlas(const GlyphInfo *chars, Rectangle **recs, int glyphCount, int fontSize, int padding, int packMethod); // Generate image font atlas using chars info
// void UnloadFontData(GlyphInfo *chars, int glyphCount);                                // Unload font chars info data (RAM)
// void UnloadFont(Font font);                                                           // Unload font from GPU memory (VRAM)
// bool ExportFontAsCode(Font font, const char *fileName);                               // Export font as code file, returns true on success
