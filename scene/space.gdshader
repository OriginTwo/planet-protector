shader_type canvas_item;

uniform sampler2D noise : source_color, repeat_enable;

uniform float time = 0.0;
uniform float time_scale = 0.2;
uniform vec4 colors[4] : source_color;

uniform float stripe_angle = -1.0;
uniform float stripe_impact = 0.1;
uniform float stripe_frequency = 50.0;

void fragment() {
	vec2 shifted_uv = vec2(UV.x + sin(time*time_scale*0.2), UV.y + sin(time*time_scale*0.2));
	float n1 = texture(noise, shifted_uv).r;
	shifted_uv = vec2(UV.x*1.2 - sin(time*time_scale*0.5), UV.y*1.2 - sin(time*time_scale*0.5));
	float n2 = texture(noise, shifted_uv).r;
	shifted_uv = vec2(UV.x*0.7 - sin(time*time_scale*0.4), UV.y*0.7 + sin(time*time_scale*0.4));
	float n3 = texture(noise, shifted_uv).r;
	float n = (n1 + n2*0.5 + n3*0.5)*0.5;
	
	// vignette
	float dist = distance(UV, vec2(0.5));
	n *= dist*2.0*0.9;
	
	// stripe
	float stripe = stripe_impact*sin((UV.y - stripe_angle*UV.x)*stripe_frequency);
	n += stripe;
	
	// color
	vec3 color = colors[3].rgb;
	if (n > 0.48) {
		color = colors[2].rgb;
	}
	else if (n > 0.38) {
		color = colors[1].rgb;
	}
	else if (n > 0.35) {
		color = colors[0].rgb;
	}
	
	COLOR = vec4(color.rgb, 1);
}
