/// Virtual input (keyboard as joystick)
module sily.raylib.input.virtual;

import sily.raylib.input.keyboard;
import sily.raylib.input.gamepad;
import sily.raylib.input.joystick;

import sily.vector;

// TODO: overlap
// enum OverlapMode {
//     cancel, older, newer
// }

/// N-size virtual axis (i.e map left-right to x=-1.0..1.0 and down-up to y=-1.0..1.0, etc)
struct VirtualController(size_t N) if (N > 0) {
    @disable this();

    alias Axis = Vector!(float, N);

    private Key[N] pos;
    private Key[N] neg;

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

/// N-size virtual axis merging Joystick axis together
struct VirtualJoystick(size_t N) if (N > 0) {
    @disable this();

    alias Axis = Vector!(float, N);

    private int[N] _axis;
    private int[N] _idx;

    /++
    Creates virtual axis
    Params:
        p_vals = Array of gamepad axis (joyIDX, joyAXIS, joyIDX, joyAXIS)
    Example:
    ---
    auto vc2 = VirtualController!(2, JoystickAxis)(0, 0, 0, 1, 1, 4);
    auto vc1 = VirtualController!(1, JoystickAxis)(0, 1);
    ---
    +/
    this(int[N * 2] p_vals...) {
        for (int i = 0; i < N; ++i) {
            _idx[i] = p_vals[i * 2];
            _axis[i] = p_vals[i * 2 + 1];
        }
    }

    /// Returns virtual axis state as normalised vector
    Axis axis() {
        Axis a = 0;

        foreach (i; 0..N) {
            a[i] = joyAxis(_idx[i], _axis[i]);
        }

        if (!a.isNormalised) {
            a.normalise();
        }
        return a;
    }
}

/// TODO: virtual gamepad

/// Double virtual axis (i.e map left-right to x=-1.0..1.0 and down-up to y=-1.0..1.0)
alias VirtualAxis = VirtualController!1;
alias VirtualJoy = VirtualController!2;

