/// Same as gamepad
module sily.raylib.input.joystick;

public import sily.raylib.input.gamepad;

/// Checks if joystick is available
alias joystickAvailable = gamepadAvailable;

/// Returns joystick name
alias joystickName = gamepadName;

/// Returns count of axis available for joystick
alias joystickAxisCount = gamepadAxisCount;

/// Sets internal mappsings (raylib.SetGamepadMappings)
alias joystickSetMappings = gamepadSetMappings;

/// Returns axis state for joystick
alias joystickAxis = gamepadAxis;
/// Ditto
alias joyAxis = gamepadAxis;

/// Get last button pressed
alias joystickLastButton = gamepadLastButton;
