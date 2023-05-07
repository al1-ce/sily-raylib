/// Keyboard input
module sily.raylib.input.keyboard;

import rl = raylib;

/// Keyboard keys
alias Key = rl.KeyboardKey;

/// Is key pressed
bool isDown(Key key) {
    return rl.IsKeyDown(key);
}

/// Is key not pressed
bool isUp(Key key) {
    return rl.IsKeyUp(key);
}

/// Is key just pressed
bool isPressed(Key key) {
    return rl.IsKeyPressed(key);
}

/// Is key released
bool isReleased(Key key) {
    return rl.IsKeyReleased(key);
}

int getKeyPressed() {
    return rl.GetKeyPressed();
}

int getCharPressed() {
    return rl.GetCharPressed();
}

