module sily.raylib.sdlwindow;

import std.string: toStringz;
import std.conv: to;
import std.file: getcwd;

import raylib;

import sily.vector;
import sily.logger;

import sily.bindbc;
import sily.bindbc.bindbc;
import sily.sdl;
import sily.sdl.sdl;

Log _log;

Log logger() { return _log; }

void setLogPath(string path) {
    import std.file;
    if (path.exists && !path.isFile) {
        _log.error("Unable to set log file. \"" ~ path ~ "\" is a directory");
        return;
    } 
    if (path.exists) {
        copy(path, path ~ ".old");
    }
    _log.logFile = path;
}

void setAlwaysLog() {
    _log.alwaysFlush = true;
}

void loadLibraries(int L = __LINE__, string F = __FILE__)(string path = "") {

    if (path.length) setBindbcLibPath(path);
    
    // loadBindbcLib!(bindbc.sdl, SDLSupport, loadSDL, sdlSupport, "SDL2")(_log);
    loadLibrarySDL!(L, F)(_log);
    // loadBindbcLib!(bindbc.sdl, SDLImageSupport, loadSDLImage, sdlImageSupport, "SDL2 Image");

    if (path.length) resetBindbcLibPath();

    SDL_Init(SDL_INIT_EVERYTHING);
    // IMG_Init(IMG_INIT_PNG);
}

private SDL_Window* _window;
private SDL_GLContext _context;

/// Creates window with SDL backend
void createSDL(int width, int height, string title = "RaylibD Application") {
    _log.info("Initializing raylib " ~ raylib_version.to!string);

    _log.info("Supported raylib modules:");
    _log.info("    > rcore:..... loaded (mandatory)");
    _log.info("    > rlgl:...... loaded (mandatory)");
    _log.info("    > rshapes:... loaded (optional)");
    _log.info("    > rtextures:. loaded (optional)");
    _log.info("    > rtext:..... loaded (optional)");
    _log.info("    > rmodels:... loaded (optional)");
    _log.info("    > raudio:.... loaded (optional)");
    
    SDL_GL_SetAttribute(SDL_GL_CONTEXT_MAJOR_VERSION, 3);
    SDL_GL_SetAttribute(SDL_GL_CONTEXT_MINOR_VERSION, 3);

    SDL_GL_SetAttribute(SDL_GL_MULTISAMPLEBUFFERS, 1);
    SDL_GL_SetAttribute(SDL_GL_MULTISAMPLESAMPLES, 4);

    _window = SDL_CreateWindow(
        title.toStringz,
        SDL_WINDOWPOS_CENTERED,
        SDL_WINDOWPOS_CENTERED,
        width,
        height,
        SDL_WINDOW_SHOWN | SDL_WINDOW_OPENGL
    );

    if (_window == null) {
        _log.error("Could not create window: %s\n", SDL_GetError());
        return;
    } else {
        _log.info("SDL window created");
    }

    _context = SDL_GL_CreateContext(_window);

    // Initialize global input state
    // memset(&CORE.Input, 0, sizeof(CORE.Input));
    // CORE.Input.Keyboard.exitKey = KEY_ESCAPE;
    // CORE.Input.Mouse.scale = (Vector2){ 1.0f, 1.0f };
    // CORE.Input.Mouse.cursor = MOUSE_CURSOR_ARROW;
    // CORE.Input.Gamepad.lastButtonPressed = 0;       // GAMEPAD_BUTTON_UNKNOWN
    // #if defined(SUPPORT_EVENTS_WAITING)
    //     CORE.Window.eventWaiting = true;
    // #endif

    // #if defined(PLATFORM_DESKTOP) || defined(PLATFORM_WEB) || defined(PLATFORM_RPI) || defined(PLATFORM_DRM)
    //     // Initialize graphics device (display device and OpenGL context)
    //     // NOTE: returns true if window and graphic device has been initialized successfully
    //     CORE.Window.ready = InitGraphicsDevice(width, height);

    //     // If graphic device is no properly initialized, we end program
    //     if (!CORE.Window.ready)
    //     {
    //         TRACELOG(LOG_FATAL, "Failed to initialize Graphic Device");
    //         return;
    //     }
    //     else SetWindowPosition(GetMonitorWidth(GetCurrentMonitor())/2 - CORE.Window.screen.width/2, GetMonitorHeight(GetCurrentMonitor())/2 - CORE.Window.screen.height/2);

    // Initialize hi-res timer
    // FIXME: should init timer
    // InitTimer();

    // Initialize random seed
    {
        import core.stdc.stdlib: srand;
        import core.stdc.time: time;
        srand(cast(uint) time(null));
    }
    // Initialize base path for storage
    ChangeDirectory(getcwd().toStringz);
    // CORE.Storage.basePath = GetWorkingDirectory();

    // #if defined(SUPPORT_MODULE_RTEXT) && defined(SUPPORT_DEFAULT_FONT)
    // Load default font
    // WARNING: External function: Module required: rtext
    // FIXME: should load default font
    // LoadFontDefault();
    
    // Rectangle rec = GetFontDefault().recs[95];
    // // NOTE: We set up a 1px padding on char rectangle to avoid pixel bleeding on MSAA filtering
    // SetShapesTexture(GetFontDefault().texture, Rectangle(rec.x + 1, rec.y + 1, rec.width - 2, rec.height - 2)); // WARNING: Module required: rshapes

    // // Set default texture and rectangle to be used for shapes drawing
    // // NOTE: rlgl default texture is a 1x1 pixel UNCOMPRESSED_R8G8B8A8
    // Texture2D texture = Texture2D(rlGetTextureIdDefault(), 1, 1, 1, PixelFormat.PIXELFORMAT_UNCOMPRESSED_R8G8B8A8);
    // SetShapesTexture(texture, Rectangle(0.0f, 0.0f, 1.0f, 1.0f));    // WARNING: Module required: rshapes

    // rlTextureParameters(GetFontDefault().texture.id, RL_TEXTURE_MIN_FILTER, RL_TEXTURE_FILTER_LINEAR);
    // rlTextureParameters(GetFontDefault().texture.id, RL_TEXTURE_MAG_FILTER, RL_TEXTURE_FILTER_LINEAR);

}
/// Ditto
void createSDL(ivec2 size, string title) {
    createSDL(size.x, size.y, title);
}

/// Should window close (window close button been pressed)
bool shouldCloseSDL() {
    return true;
}
/// Ditto
alias closeRequestedSDL = shouldCloseSDL;

/// Closes window and resets config flags
void closeSDL() {
    _log.info("Deleting SDL GL context");
    SDL_GL_DeleteContext(_context);
    _log.info("Closing SDL window");
    SDL_DestroyWindow(_window);
    // info("Closing SDL Image");
    // IMG_Quit();
    _log.info("Closing SDL");
    SDL_Quit();
}

// Swap back buffer with front buffer (screen drawing)
void SwapScreenBuffer() { // @suppress(dscanner.style.phobos_naming_convention)
// #if defined(PLATFORM_DESKTOP) || defined(PLATFORM_WEB)
//     glfwSwapBuffers(CORE.Window.handle);
// #endif

// #if defined(PLATFORM_ANDROID) || defined(PLATFORM_RPI) || defined(PLATFORM_DRM)
//     eglSwapBuffers(CORE.Window.device, CORE.Window.surface);

// #if defined(PLATFORM_DRM)

//     if (!CORE.Window.gbmSurface || (-1 == CORE.Window.fd) || !CORE.Window.connector || !CORE.Window.crtc) TRACELOG(LOG_ERROR, "DISPLAY: DRM initialization failed to swap");

//     struct gbm_bo *bo = gbm_surface_lock_front_buffer(CORE.Window.gbmSurface);
//     if (!bo) TRACELOG(LOG_ERROR, "DISPLAY: Failed GBM to lock front buffer");

//     uint32_t fb = 0;
//     int result = drmModeAddFB(CORE.Window.fd, CORE.Window.connector->modes[CORE.Window.modeIndex].hdisplay, CORE.Window.connector->modes[CORE.Window.modeIndex].vdisplay, 24, 32, gbm_bo_get_stride(bo), gbm_bo_get_handle(bo).u32, &fb);
//     if (result != 0) TRACELOG(LOG_ERROR, "DISPLAY: drmModeAddFB() failed with result: %d", result);

//     result = drmModeSetCrtc(CORE.Window.fd, CORE.Window.crtc->crtc_id, fb, 0, 0, &CORE.Window.connector->connector_id, 1, &CORE.Window.connector->modes[CORE.Window.modeIndex]);
//     if (result != 0) TRACELOG(LOG_ERROR, "DISPLAY: drmModeSetCrtc() failed with result: %d", result);

//     if (CORE.Window.prevFB)
//     {
//         result = drmModeRmFB(CORE.Window.fd, CORE.Window.prevFB);
//         if (result != 0) TRACELOG(LOG_ERROR, "DISPLAY: drmModeRmFB() failed with result: %d", result);
//     }

//     CORE.Window.prevFB = fb;

//     if (CORE.Window.prevBO) gbm_surface_release_buffer(CORE.Window.gbmSurface, CORE.Window.prevBO);

//     CORE.Window.prevBO = bo;

// #endif  // PLATFORM_DRM
// #endif  // PLATFORM_ANDROID || PLATFORM_RPI || PLATFORM_DRM
}

// Register all input events
void PollInputEvents() { // @suppress(dscanner.style.phobos_naming_convention)
// #if defined(SUPPORT_GESTURES_SYSTEM)
//     // NOTE: Gestures update must be called every frame to reset gestures correctly
//     // because ProcessGestureEvent() is just called on an event, not every frame
//     UpdateGestures();
// #endif

//     // Reset keys/chars pressed registered
//     CORE.Input.Keyboard.keyPressedQueueCount = 0;
//     CORE.Input.Keyboard.charPressedQueueCount = 0;

// #if !(defined(PLATFORM_RPI) || defined(PLATFORM_DRM))
//     // Reset last gamepad button/axis registered state
//     CORE.Input.Gamepad.lastButtonPressed = 0;       // GAMEPAD_BUTTON_UNKNOWN
//     CORE.Input.Gamepad.axisCount = 0;
// #endif

// #if defined(PLATFORM_RPI) || defined(PLATFORM_DRM)
//     // Register previous keys states
//     for (int i = 0; i < MAX_KEYBOARD_KEYS; i++) CORE.Input.Keyboard.previousKeyState[i] = CORE.Input.Keyboard.currentKeyState[i];

//     PollKeyboardEvents();

//     // Register previous mouse states
//     CORE.Input.Mouse.previousWheelMove = CORE.Input.Mouse.currentWheelMove;
//     CORE.Input.Mouse.currentWheelMove = (Vector2){ 0.0f, 0.0f };
//     for (int i = 0; i < MAX_MOUSE_BUTTONS; i++)
//     {
//         CORE.Input.Mouse.previousButtonState[i] = CORE.Input.Mouse.currentButtonState[i];
//         CORE.Input.Mouse.currentButtonState[i] = CORE.Input.Mouse.currentButtonStateEvdev[i];
//     }

//     // Register gamepads buttons events
//     for (int i = 0; i < MAX_GAMEPADS; i++)
//     {
//         if (CORE.Input.Gamepad.ready[i])
//         {
//             // Register previous gamepad states
//             for (int k = 0; k < MAX_GAMEPAD_BUTTONS; k++) CORE.Input.Gamepad.previousButtonState[i][k] = CORE.Input.Gamepad.currentButtonState[i][k];
//         }
//     }
// #endif

// #if defined(PLATFORM_DESKTOP) || defined(PLATFORM_WEB)
//     // Keyboard/Mouse input polling (automatically managed by GLFW3 through callback)

//     // Register previous keys states
//     for (int i = 0; i < MAX_KEYBOARD_KEYS; i++) CORE.Input.Keyboard.previousKeyState[i] = CORE.Input.Keyboard.currentKeyState[i];

//     // Register previous mouse states
//     for (int i = 0; i < MAX_MOUSE_BUTTONS; i++) CORE.Input.Mouse.previousButtonState[i] = CORE.Input.Mouse.currentButtonState[i];

//     // Register previous mouse wheel state
//     CORE.Input.Mouse.previousWheelMove = CORE.Input.Mouse.currentWheelMove;
//     CORE.Input.Mouse.currentWheelMove = (Vector2){ 0.0f, 0.0f };

//     // Register previous mouse position
//     CORE.Input.Mouse.previousPosition = CORE.Input.Mouse.currentPosition;
// #endif

//     // Register previous touch states
//     for (int i = 0; i < MAX_TOUCH_POINTS; i++) CORE.Input.Touch.previousTouchState[i] = CORE.Input.Touch.currentTouchState[i];

//     // Reset touch positions
//     // TODO: It resets on PLATFORM_WEB the mouse position and not filled again until a move-event,
//     // so, if mouse is not moved it returns a (0, 0) position... this behaviour should be reviewed!
//     //for (int i = 0; i < MAX_TOUCH_POINTS; i++) CORE.Input.Touch.position[i] = (Vector2){ 0, 0 };

// #if defined(PLATFORM_DESKTOP)
//     // Check if gamepads are ready
//     // NOTE: We do it here in case of disconnection
//     for (int i = 0; i < MAX_GAMEPADS; i++)
//     {
//         if (glfwJoystickPresent(i)) CORE.Input.Gamepad.ready[i] = true;
//         else CORE.Input.Gamepad.ready[i] = false;
//     }

//     // Register gamepads buttons events
//     for (int i = 0; i < MAX_GAMEPADS; i++)
//     {
//         if (CORE.Input.Gamepad.ready[i])     // Check if gamepad is available
//         {
//             // Register previous gamepad states
//             for (int k = 0; k < MAX_GAMEPAD_BUTTONS; k++) CORE.Input.Gamepad.previousButtonState[i][k] = CORE.Input.Gamepad.currentButtonState[i][k];

//             // Get current gamepad state
//             // NOTE: There is no callback available, so we get it manually
//             // Get remapped buttons
//             GLFWgamepadstate state = { 0 };
//             glfwGetGamepadState(i, &state); // This remapps all gamepads so they have their buttons mapped like an xbox controller

//             const unsigned char *buttons = state.buttons;

//             for (int k = 0; (buttons != NULL) && (k < GLFW_GAMEPAD_BUTTON_DPAD_LEFT + 1) && (k < MAX_GAMEPAD_BUTTONS); k++)
//             {
//                 GamepadButton button = -1;

//                 switch (k)
//                 {
//                     case GLFW_GAMEPAD_BUTTON_Y: button = GAMEPAD_BUTTON_RIGHT_FACE_UP; break;
//                     case GLFW_GAMEPAD_BUTTON_B: button = GAMEPAD_BUTTON_RIGHT_FACE_RIGHT; break;
//                     case GLFW_GAMEPAD_BUTTON_A: button = GAMEPAD_BUTTON_RIGHT_FACE_DOWN; break;
//                     case GLFW_GAMEPAD_BUTTON_X: button = GAMEPAD_BUTTON_RIGHT_FACE_LEFT; break;

//                     case GLFW_GAMEPAD_BUTTON_LEFT_BUMPER: button = GAMEPAD_BUTTON_LEFT_TRIGGER_1; break;
//                     case GLFW_GAMEPAD_BUTTON_RIGHT_BUMPER: button = GAMEPAD_BUTTON_RIGHT_TRIGGER_1; break;

//                     case GLFW_GAMEPAD_BUTTON_BACK: button = GAMEPAD_BUTTON_MIDDLE_LEFT; break;
//                     case GLFW_GAMEPAD_BUTTON_GUIDE: button = GAMEPAD_BUTTON_MIDDLE; break;
//                     case GLFW_GAMEPAD_BUTTON_START: button = GAMEPAD_BUTTON_MIDDLE_RIGHT; break;

//                     case GLFW_GAMEPAD_BUTTON_DPAD_UP: button = GAMEPAD_BUTTON_LEFT_FACE_UP; break;
//                     case GLFW_GAMEPAD_BUTTON_DPAD_RIGHT: button = GAMEPAD_BUTTON_LEFT_FACE_RIGHT; break;
//                     case GLFW_GAMEPAD_BUTTON_DPAD_DOWN: button = GAMEPAD_BUTTON_LEFT_FACE_DOWN; break;
//                     case GLFW_GAMEPAD_BUTTON_DPAD_LEFT: button = GAMEPAD_BUTTON_LEFT_FACE_LEFT; break;

//                     case GLFW_GAMEPAD_BUTTON_LEFT_THUMB: button = GAMEPAD_BUTTON_LEFT_THUMB; break;
//                     case GLFW_GAMEPAD_BUTTON_RIGHT_THUMB: button = GAMEPAD_BUTTON_RIGHT_THUMB; break;
//                     default: break;
//                 }

//                 if (button != -1)   // Check for valid button
//                 {
//                     if (buttons[k] == GLFW_PRESS)
//                     {
//                         CORE.Input.Gamepad.currentButtonState[i][button] = 1;
//                         CORE.Input.Gamepad.lastButtonPressed = button;
//                     }
//                     else CORE.Input.Gamepad.currentButtonState[i][button] = 0;
//                 }
//             }

//             // Get current axis state
//             const float *axes = state.axes;

//             for (int k = 0; (axes != NULL) && (k < GLFW_GAMEPAD_AXIS_LAST + 1) && (k < MAX_GAMEPAD_AXIS); k++)
//             {
//                 CORE.Input.Gamepad.axisState[i][k] = axes[k];
//             }

//             // Register buttons for 2nd triggers (because GLFW doesn't count these as buttons but rather axis)
//             CORE.Input.Gamepad.currentButtonState[i][GAMEPAD_BUTTON_LEFT_TRIGGER_2] = (char)(CORE.Input.Gamepad.axisState[i][GAMEPAD_AXIS_LEFT_TRIGGER] > 0.1f);
//             CORE.Input.Gamepad.currentButtonState[i][GAMEPAD_BUTTON_RIGHT_TRIGGER_2] = (char)(CORE.Input.Gamepad.axisState[i][GAMEPAD_AXIS_RIGHT_TRIGGER] > 0.1f);

//             CORE.Input.Gamepad.axisCount = GLFW_GAMEPAD_AXIS_LAST + 1;
//         }
//     }

//     CORE.Window.resizedLastFrame = false;

//     if (CORE.Window.eventWaiting) glfwWaitEvents();     // Wait for in input events before continue (drawing is paused)
//     else glfwPollEvents();      // Poll input events: keyboard/mouse/window events (callbacks)
// #endif  // PLATFORM_DESKTOP

// #if defined(PLATFORM_WEB)
//     CORE.Window.resizedLastFrame = false;
// #endif  // PLATFORM_WEB

// // Gamepad support using emscripten API
// // NOTE: GLFW3 joystick functionality not available in web
// #if defined(PLATFORM_WEB)
//     // Get number of gamepads connected
//     int numGamepads = 0;
//     if (emscripten_sample_gamepad_data() == EMSCRIPTEN_RESULT_SUCCESS) numGamepads = emscripten_get_num_gamepads();

//     for (int i = 0; (i < numGamepads) && (i < MAX_GAMEPADS); i++)
//     {
//         // Register previous gamepad button states
//         for (int k = 0; k < MAX_GAMEPAD_BUTTONS; k++) CORE.Input.Gamepad.previousButtonState[i][k] = CORE.Input.Gamepad.currentButtonState[i][k];

//         EmscriptenGamepadEvent gamepadState;

//         int result = emscripten_get_gamepad_status(i, &gamepadState);

//         if (result == EMSCRIPTEN_RESULT_SUCCESS)
//         {
//             // Register buttons data for every connected gamepad
//             for (int j = 0; (j < gamepadState.numButtons) && (j < MAX_GAMEPAD_BUTTONS); j++)
//             {
//                 GamepadButton button = -1;

//                 // Gamepad Buttons reference: https://www.w3.org/TR/gamepad/#gamepad-interface
//                 switch (j)
//                 {
//                     case 0: button = GAMEPAD_BUTTON_RIGHT_FACE_DOWN; break;
//                     case 1: button = GAMEPAD_BUTTON_RIGHT_FACE_RIGHT; break;
//                     case 2: button = GAMEPAD_BUTTON_RIGHT_FACE_LEFT; break;
//                     case 3: button = GAMEPAD_BUTTON_RIGHT_FACE_UP; break;
//                     case 4: button = GAMEPAD_BUTTON_LEFT_TRIGGER_1; break;
//                     case 5: button = GAMEPAD_BUTTON_RIGHT_TRIGGER_1; break;
//                     case 6: button = GAMEPAD_BUTTON_LEFT_TRIGGER_2; break;
//                     case 7: button = GAMEPAD_BUTTON_RIGHT_TRIGGER_2; break;
//                     case 8: button = GAMEPAD_BUTTON_MIDDLE_LEFT; break;
//                     case 9: button = GAMEPAD_BUTTON_MIDDLE_RIGHT; break;
//                     case 10: button = GAMEPAD_BUTTON_LEFT_THUMB; break;
//                     case 11: button = GAMEPAD_BUTTON_RIGHT_THUMB; break;
//                     case 12: button = GAMEPAD_BUTTON_LEFT_FACE_UP; break;
//                     case 13: button = GAMEPAD_BUTTON_LEFT_FACE_DOWN; break;
//                     case 14: button = GAMEPAD_BUTTON_LEFT_FACE_LEFT; break;
//                     case 15: button = GAMEPAD_BUTTON_LEFT_FACE_RIGHT; break;
//                     default: break;
//                 }

//                 if (button != -1)   // Check for valid button
//                 {
//                     if (gamepadState.digitalButton[j] == 1)
//                     {
//                         CORE.Input.Gamepad.currentButtonState[i][button] = 1;
//                         CORE.Input.Gamepad.lastButtonPressed = button;
//                     }
//                     else CORE.Input.Gamepad.currentButtonState[i][button] = 0;
//                 }

//                 //TRACELOGD("INPUT: Gamepad %d, button %d: Digital: %d, Analog: %g", gamepadState.index, j, gamepadState.digitalButton[j], gamepadState.analogButton[j]);
//             }

//             // Register axis data for every connected gamepad
//             for (int j = 0; (j < gamepadState.numAxes) && (j < MAX_GAMEPAD_AXIS); j++)
//             {
//                 CORE.Input.Gamepad.axisState[i][j] = gamepadState.axis[j];
//             }

//             CORE.Input.Gamepad.axisCount = gamepadState.numAxes;
//         }
//     }
// #endif

// #if defined(PLATFORM_ANDROID)
//     // Register previous keys states
//     // NOTE: Android supports up to 260 keys
//     for (int i = 0; i < 260; i++) CORE.Input.Keyboard.previousKeyState[i] = CORE.Input.Keyboard.currentKeyState[i];

//     // Android ALooper_pollAll() variables
//     int pollResult = 0;
//     int pollEvents = 0;

//     // Poll Events (registered events)
//     // NOTE: Activity is paused if not enabled (CORE.Android.appEnabled)
//     while ((pollResult = ALooper_pollAll(CORE.Android.appEnabled? 0 : -1, NULL, &pollEvents, (void**)&CORE.Android.source)) >= 0)
//     {
//         // Process this event
//         if (CORE.Android.source != NULL) CORE.Android.source->process(CORE.Android.app, CORE.Android.source);

//         // NOTE: Never close window, native activity is controlled by the system!
//         if (CORE.Android.app->destroyRequested != 0)
//         {
//             //CORE.Window.shouldClose = true;
//             //ANativeActivity_finish(CORE.Android.app->activity);
//         }
//     }
// #endif

// #if (defined(PLATFORM_RPI) || defined(PLATFORM_DRM)) && defined(SUPPORT_SSH_KEYBOARD_RPI)
//     // NOTE: Keyboard reading could be done using input_event(s) or just read from stdin, both methods are used here.
//     // stdin reading is still used for legacy purposes, it allows keyboard input trough SSH console

//     if (!CORE.Input.Keyboard.evtMode) ProcessKeyboard();

//     // NOTE: Mouse input events polling is done asynchronously in another pthread - EventThread()
//     // NOTE: Gamepad (Joystick) input events polling is done asynchonously in another pthread - GamepadThread()
// #endif
}
