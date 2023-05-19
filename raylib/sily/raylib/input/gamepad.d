module sily.raylib.input.gamepad;

import std.conv: to;
import std.string: toStringz;

import rl = raylib;

// // Input-related functions: gamepads
// bool IsGamepadAvailable(int gamepad);                   // Check if a gamepad is available
// const char *GetGamepadName(int gamepad);                // Get gamepad internal name id
// bool IsGamepadButtonPressed(int gamepad, int button);   // Check if a gamepad button has been pressed once
// bool IsGamepadButtonDown(int gamepad, int button);      // Check if a gamepad button is being pressed
// bool IsGamepadButtonReleased(int gamepad, int button);  // Check if a gamepad button has been released once
// bool IsGamepadButtonUp(int gamepad, int button);        // Check if a gamepad button is NOT being pressed
// int GetGamepadButtonPressed(void);                      // Get the last gamepad button pressed
// int GetGamepadAxisCount(int gamepad);                   // Get gamepad axis count for a gamepad
// float GetGamepadAxisMovement(int gamepad, int axis);    // Get axis movement value for a gamepad axis
// int SetGamepadMappings(const char *mappings);           // Set internal gamepad mappings (SDL_GameControllerDB)

/// Checks if gamepad is available
bool gamepadAvailable(int idx) {
    return rl.IsGamepadAvailable(idx);
}

/// Returns gamepad name
string gamepadName(int idx) {
    return rl.GetGamepadName(idx).to!string;
}

/// Is button just pressed
bool buttonPressed(int idx, int button) {
    return rl.IsGamepadButtonPressed(idx, button);
}

/// Is button down (pressed)
bool buttonDown(int idx, int button) {
    return rl.IsGamepadButtonDown(idx, button);
}

/// Is button just released
bool buttonReleased(int idx, int button) {
    return rl.IsGamepadButtonReleased(idx, button);
}

/// Is button up (released)
bool buttonUp(int idx, int button) {
    return rl.IsGamepadButtonUp(idx, button);
}

/// Get last button pressed
int gamepadLastButton() {
    return rl.GetGamepadButtonPressed();
}

/// Returns count of axis available for gamepad
int gamepadAxisCount(int idx) {
    return rl.GetGamepadAxisCount(idx);
}

/// Returns axis state for gamepad
float gamepadAxis(int idx, int p_axis) {
    return rl.GetGamepadAxisMovement(idx, p_axis);
}

/// Sets internal mappsings (raylib.SetGamepadMappings)
int gamepadSetMappings(string mappings) {
    return rl.SetGamepadMappings(mappings.toStringz);
}