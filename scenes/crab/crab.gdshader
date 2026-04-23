shader_type canvas_item;

uniform int start_frame = 0;
uniform int current_frame = 0;
uniform float mix_ratio = 1.0;
uniform bool on = false;

const vec3 colors[6] = vec3[] (
	vec3(0.129, 0.173, 0.157), // base dark (#212c28)
vec3(0.447, 0.643, 0.533), // mid teal (#72a488)
vec3(0.60,  0.75,  0.65),  // brighter teal
vec3(0.80,  0.90,  0.80),  // pale green highlight
vec3(1.0,   0.99,  0.60),  // soft yellow flash (#fffc99 toned)
vec3(0.05,  0.08,  0.07)  // deep shadow
);

void fragment() {
	if (on) {
		// https://en.wikipedia.org/wiki/Rec._709#Luma_coefficients
		float brightness = dot(COLOR.rgb, vec3(0.2126, 0.7152, 0.0722));

		// Calculate the starting frame based on brightness
		int offset = 0;
		if (brightness > 0.75) {
			offset = 2;
		} else if (brightness > 0.25) {
			offset = 1;
		}

		// Get the color, wrapping around at the end of the array
		int color_index = (start_frame + current_frame + offset) % colors.length();
		vec3 color = colors[color_index];

		// Apply the color to the sprite
		COLOR = vec4(mix(COLOR.rgb, color, mix_ratio), COLOR.a);
	}
}