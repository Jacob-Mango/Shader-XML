#version 330 core

layout(location = 0) in vec4 position;
layout(location = 1) in vec3 normal;
layout(location = 2) in vec2 uv;
layout(location = 3) in vec3 binormal;
layout(location = 4) in vec3 tangent;

uniform mat4 sys_ProjectionMatrix;
uniform mat4 sys_ViewMatrix;
uniform mat4 sys_ModelMatrix;

out DataBlock
{
	vec4 position;
	vec3 normal;
	vec2 uv;
	vec3 binormal;
	vec3 tangent;
} vs_out;

void main()
{
	mat4 model = sys_ModelMatrix;
	vec4 transformedPos = model * vec4(position.xyz, 1.0);

	gl_Position = sys_ProjectionMatrix * sys_ViewMatrix * transformedPos;

	vs_out.position = transformedPos;
	vs_out.normal = normalize(vec3(model * vec4(normal, 0)));
	vs_out.binormal = normalize(vec3(model * vec4(binormal, 0)));
	vs_out.tangent = normalize(vec3(model * vec4(tangent, 0)));
	vs_out.uv = uv;
}