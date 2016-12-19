#version 430

in layout(location=0) vec3 vertexPositionModel;
in layout(location=1) vec3 vertexColor;
in layout(location=2) vec3 normalModel;
in layout(location=3) vec2 UVModel;


uniform mat4 modelToProjectionMatrix;
uniform mat4 modelToWorldMatrix;

out vec3 normalWorld;
out vec3 vertexPositionWorld;
out vec2 UVs;
out vec3 orthoWorld;

void main()
{	
	vec3 tangentModel = vec3(+1.0f, +0.0f, +0.0f);
	
	if (normalModel[0] == +1.0f)
	{
		vec3 tangentModel = vec3(-1.0f, +0.0f, +0.0f);
		
	}
	if (normalModel[0] == -1.0f)
	{
			vec3 tangentModel = vec3(+0.0f, +0.0f, +1.0f);
	}
	vec3 orthoNormal = normalModel * tangentModel;
	orthoWorld = vec3(modelToWorldMatrix * vec4(orthoNormal, 0));
	
	
	vec4 v = vec4(vertexPositionModel, 1.0);
	gl_Position = modelToProjectionMatrix * v;
	vertexPositionWorld = vec3(modelToWorldMatrix * v);
	normalWorld = vec3(modelToWorldMatrix * vec4(normalModel, 0));
	UVs = UVModel;
}