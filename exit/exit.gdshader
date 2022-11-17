shader_type spatial;
uniform vec4 albedo;
uniform sampler2D albedo_texture;
uniform vec3 uv1_scale;
uniform vec3 uv1_offset;

uniform float brightness = 1.0;
uniform vec2 disp_scale = vec2(1.0,1.0); //Displacement map scale
uniform sampler2D flowMap; //Displacement map
uniform float strength = 1; //Force of the effect
uniform float speed = 1; //Speed of the effect

void vertex() {
	UV=UV*uv1_scale.xy+uv1_offset.xy;
}

void fragment() {
	float c = TIME * speed;
	vec4 offset = texture(flowMap, disp_scale.xy * vec2(UV.x + c, UV.y + c)) * strength;
	//ALPHA = albedo.a * texture(albedo_texture, (vec2(UV.x + offset.x, UV.y + offset.y) - vec2(0.5,0.5))).a;
	ALBEDO = brightness * albedo.rgb * texture(albedo_texture, (vec2(UV.x + offset.x, UV.y + offset.y) - vec2(0.5,0.5))).rgb;
}