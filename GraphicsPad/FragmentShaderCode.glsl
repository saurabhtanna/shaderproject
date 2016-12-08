#version 430

out vec4 daColor;
in vec3 normalWorld;
in vec3 vertexPositionWorld;
in vec2 UVs;
in vec3 orthoWorld;

uniform vec3 lightPositionWorld;
uniform vec4 ambientLight;
uniform vec3 eyePositionWorld;
//uniform sampler2D dogTexture;
//uniform sampler2D normalMapTexture;
uniform sampler2D specMap;

void main()
{	
	//sampling the texture
	vec4 specSample = texture(specMap, UVs);

	
	//Rotation matrix for normal map on a cube
	//mat3 normalMapTransformation;
  	//normalMapTransformation[0] = vec3(1.0, 0.0, 0.0);
  	//normalMapTransformation[1] = vec3(0.0, 1.0, 0.0);
	//normalMapTransformation[2] = orthoWorld;

	//vec3 normalTangetR = normalMapTransformation * vec3(texSample);
	//vec3 normalTangent = vec3(texSample * 2.0 - 1.0);


	

	//diffuse

	vec3 lightVectorWorld = normalize(lightPositionWorld - vertexPositionWorld);
	float brightness = dot(lightVectorWorld, normalize(normalWorld));
	vec4 diffuseLight = vec4(brightness, 0, 0, 1.0);

	//attenuation
	float lightDistance = distance(lightPositionWorld, vertexPositionWorld);
	float attenuationConstant = 0.9f;
	float attenuationConstantLinear = 0.2;
	float attenuationConstantQuadratic = 0.1;
	float lightAttenuation = 1/(attenuationConstant + (attenuationConstantLinear * lightDistance) + (attenuationConstantQuadratic * pow(lightDistance, 2)));
	diffuseLight = lightAttenuation * diffuseLight;
	
	//specular
	vec3 reflectedLightVectorWorld = reflect(-lightVectorWorld, normalWorld);
	vec3 eyeVectorWorld = normalize(eyePositionWorld - vertexPositionWorld);
	float s = dot(reflectedLightVectorWorld, eyeVectorWorld);
	s = pow(s, 60);
	vec4 specularLight = vec4(0, 0, s, 1);

	

	//daColor = clamp(diffuseLight, 0 ,1) + ambientLight + clamp(specularLight, 0, 1);

	daColor = specSample * (clamp(diffuseLight, 0, 1) + ambientLight + clamp(specularLight, 0, 1));
}