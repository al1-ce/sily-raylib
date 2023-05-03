/++
Unity-style GameObject. Intended to be heavily used with [sily.raylib.component] module.
+/
module sily.raylib.gameobject;

import sily.raylib.component.base;

// LINK: https://docs.unity3d.com/ScriptReference/GameObject.html

class GameObject {
    private IComponent[] _components;
    private string _name;
    private string[] _tags;
}
