module sily.raylib.resource.shader;

import sily.raylib.raytype;
import sily.raylib.log;

import sily.vector;
import sily.matrix;

import std.string: toStringz;

import rl = raylib;

alias rShader = rl.Shader;
alias rTexture = rl.Texture;

// load and unload function implemented in resource manager

/// Check if shader successfully loaded
bool isShaderReady(rShader shader) {
    return rl.IsShaderReady(shader);
}

/// Returns uniform location
int uniformLocation(rShader shd, string name) {
    return rl.GetShaderLocation(shd, name.toStringz);
}

/// Returns attribute location
int attributeLocation(rShader shd, string name) {
    return rl.GetShaderLocationAttrib(shd, name.toStringz);
}

/// Sets shader uniform
void setUniform(T)(rShader shd, int idx, T val) if (!is(T == rTexture) && !isMatrix!T && !isVector!T) {
    rl.SetShaderValue(shd, idx, cast(const(void)*) &val, getDataType!T);
}
/// Ditto
void setUniform(T)(rShader shd, int idx, T[] val) if (!is(T == rTexture) && !isMatrix!T && !isVector!T) {
    rl.SetShaderValue(shd, idx, cast(const(void)*) val.ptr, getDataType!T, val.length);
}
/// Ditto
void setUniform(T, size_t N)(rShader shd, int idx, vec!(T, N) val) {
    rl.SetShaderValue(shd, idx, cast(const(void)*) val.data.ptr, getDataType!T);
}
/// Ditto
void setUniform(rShader shd, int idx, const(void)* val, int type) {
    rl.SetShaderValue(shd, idx, val, type);
}
/// Ditto
void setUniform(rShader shd, int idx, const(void)* val, int type, int count) {
    rl.SetShaderValueV(shd, idx, val, type, count);
}
/// Ditto
void setUniform(rShader shd, int idx, mat4 val) {
    rl.SetShaderValueMatrix(shd, idx, val.rayType);
}
/// Ditto
void setUniform(rShader shd, int idx, rTexture val) {
    rl.SetShaderValueTexture(shd, idx, val);
}

private int getDataType(T)() {
    static if (is(T == float)) {
        return rl.ShaderUniformDataType.SHADER_UNIFORM_FLOAT;
    } else
    static if (is(T == vec2)) {
        return rl.ShaderUniformDataType.SHADER_UNIFORM_VEC2;
    } else
    static if (is(T == vec3)) {
        return rl.ShaderUniformDataType.SHADER_UNIFORM_VEC3;
    } else
    static if (is(T == vec4)) {
        return rl.ShaderUniformDataType.SHADER_UNIFORM_VEC4;
    } else
    static if (is(T == int)) {
        return rl.ShaderUniformDataType.SHADER_UNIFORM_INT;
    } else
    static if (is(T == ivec2)) {
        return rl.ShaderUniformDataType.SHADER_UNIFORM_IVEC2;
    } else
    static if (is(T == ivec3)) {
        return rl.ShaderUniformDataType.SHADER_UNIFORM_IVEC3;
    } else
    static if (is(T == ivec4)) {
        return rl.ShaderUniformDataType.SHADER_UNIFORM_IVEC4;
    } else
    static if (is(T == rTexture)) {
        return rl.ShaderUniformDataType.SHADER_UNIFORM_SAMPLER2D;
    } else {
        warning("Missing data type for " ~ T.stringof ~ ".");
        return rl.ShaderUniformDataType.SHADER_UNIFORM_INT;
    }
}

