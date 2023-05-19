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

// SDL joy mappings
// string map = "" ~
//     "leftx:a0,lefty:a1,rightx:a2,righty:a3,lefttrigger:a4,righttrigger:a5" ~
//     "dpup:b0,dpright:b1,dpdown:b2,dpleft:b3,y:b4,b:b5,a:b6,x:b7," ~
//     "leftshoulder:b8,misc1:b9,rightshoulder:b10," ~
//     "touchpad:b11,back:b12,guide:b13,start:b14,leftstick:b15,rightstick:b16" ~
//     ",platform:Windows,";

// joystickSetMappings("030000001d2300000102000000000000, VKBsim Gladiator EVO  L  ," ~ map);
// joystickSetMappings("030000001d2300000002000000000000, VKBsim Gladiator EVO  R  ," ~ map);

