/++
A simple wrapper for raylib-d package. 

Also contains [sily.raylib.component] and [sily.raylib.gameobject] to
simplify game creation.

[sily.raylib] module itself contains public imports to all modules.
If you would prefer to import them in renamed (xxx.) format, then 
import [sily.raylib.renamed] or if you would prefer to have class-like
names import [sily.raylib.classed] instead.

Please also note that mass public import is discouraged and that you
mostly should import only what you need.
+/
module sily.raylib;

public import sily.raylib.audio;
public import sily.raylib.component;
public import sily.raylib.config;
public import sily.raylib.file;
public import sily.raylib.gameobject;
public import sily.raylib.gui;
public import sily.raylib.input;
public import sily.raylib.math;
public import sily.raylib.monitor;
public import sily.raylib.physics;
public import sily.raylib.render;
public import sily.raylib.resource;
public import sily.raylib.window;
public import sily.raylib.types;

