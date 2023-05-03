module sily.raylib.input.virtual;

import sily.raylib.input.keyboard;

import sily.vector;

// TODO: overlap
// enum OverlapMode {
//     cancel, older, newer
// }

struct VirtualAxis {
    private Key _pos;
    private Key _neg;

    @disable this();

    this(Key pos, Key neg) {
        _pos = pos;
        _neg = neg;
    }

    float axis() {
        if (_pos.isPressed && _neg.isPressed) {
            return 0.0f;
        } else
        if (_pos.isPressed) {
            return 1.0f;
        } else 
        if (_neg.isPressed) {
            return -1.0f;
        } else {
            return 0.0f;
        }
    }
}

struct VirtualJoy {
    private Key _posX;
    private Key _negX;
    private Key _posY;
    private Key _negY;

    @disable this();

    this(Key posX, Key negX, Key posY, Key negY) {
        _posX = posX;
        _negX = negX;
        _posY = posY;
        _negY = negY;
    }

    vec2 axis() {
        float x = 0.0f;
        float y = 0.0f;

        if (_posX.isDown && _negX.isDown) {
            x = 0.0f;
        } else
        if (_posX.isDown) {
            x = 1.0f;
        } else 
        if (_negX.isDown) {
            x = -1.0f;
        } else {
            x = 0.0f;
        }

        if (_posY.isDown && _negY.isDown) {
            y = 0.0f;
        } else
        if (_posY.isDown) {
            y = 1.0f;
        } else 
        if (_negY.isDown) {
            y = -1.0f;
        } else {
            y = 0.0f;
        }

        vec2 v = vec2(x, y);
        if (!v.isNormalised) {
            v.normalise();
        }
        return v;
    }

}

