shader_type canvas_item;

uniform sampler2D noise : source_color, repeat_enable;
uniform bool flash = false;

uniform float time = 1.0;
uniform float time_scale = 0.2;

void fragment() {
	vec2 shifted_uv = vec2(UV.x + sin(time*time_scale*0.2), UV.y + sin(time*time_scale*0.2));
	float n1 = texture(noise, shifted_uv).r;
	shifted_uv = vec2(UV.x*1.2 - sin(time*time_scale*0.5), -UV.y*1.2 - sin(time*time_scale*0.5));
	float n2 = texture(noise, shifted_uv).r;
	shifted_uv = vec2(-UV.x*0.7 - sin(time*time_scale*0.4), UV.y*0.7 + sin(time*time_scale*0.4));
	float n3 = texture(noise, shifted_uv).r;
	float n = (n1 + n2 - n3*2.0)*0.3;
	
	float dist = distance(UV - n*0.08, vec2(0.5));
	if (dist > 0.5) {
		discard;
	}
	
	dist = smoothstep(0.3, 0.55, dist);
	
	if (flash) {
		COLOR = vec4(1.0, 1.0, 1.0, dist);
	} else {
		COLOR = vec4(0.0, 1.0, 1.0, dist*0.7);
	}
}
