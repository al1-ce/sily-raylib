/// Virtual input (keyboard as joystick)
module sily.raylib.input.virtual;

import sily.raylib.input.keyboard;

import sily.vector;

// TODO: overlap
// enum OverlapMode {
//     cancel, older, newer
// }

/// Single virtual axis (i.e map left-right to -1.0..1.0)
struct VirtualAxis {
    private Key _pos;
    private Key _neg;

    @disable this();
    
    /++
    Creates virtual axis
    Params:
        pos = Positive axis key (to be +1)
        neg = Negative axis key (to be -1)
    +/
    this(Key pos, Key neg) {
        _pos = pos;
        _neg = neg;
    }
    
    /// Returns virtual axis state
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

/// N-size virtual axis (i.e map left-right to x=-1.0..1.0 and down-up to y=-1.0..1.0, etc)
struct VirtualController(size_t N) if (N > 0) {
    private Key[N] pos;
    private Key[N] neg;

    alias Axis = Vector!(float, N);

    @disable this();

    /++
    Creates virtual axis
    Params:
        keys = Array of keys in order (pos, neg, pos, neg...)
    Example:
    ---
    // D, W - positive, A, S - negative
    auto vc2 = VirtualController!2(Key.KEY_D, Key.KEY_A, Key.KEY_W, Key.KEY_S);
    auto vc1 = VirtualController!1(Key.KEY_D, Key.KEY_A);
    ---
    +/
    this(Key[N * 2] keys...) {
        for (int i = 0; i < N; ++i) {
            pos[i] = keys[i * 2];
            neg[i] = keys[i * 2 + 1];
        }
    }
    
    /// Returns virtual axis state as normalised vector
    Axis axis() {
        Axis a = 0;

        foreach (i; 0..N) {
            if (pos[i].isDown && neg[i].isDown) {
                a[i] = 0.0f;
            } else
            if (pos[i].isDown) {
                a[i] = 1.0f;
            } else 
            if (neg[i].isDown) {
                a[i] = -1.0f;
            } else {
                a[i] = 0.0f;
            }
        }

        if (!a.isNormalised) {
            a.normalise();
        }
        return a;
    }
}

/// Double virtual axis (i.e map left-right to x=-1.0..1.0 and down-up to y=-1.0..1.0)
alias VirtualJoy = VirtualController!2;

