shader_type canvas_item;
render_mode unshaded;

uniform vec4 cubicEQ;
uniform vec3 derivitive;
const vec2[3] zeroes = {vec2(1, 0), vec2(-0.5, 0.8660254038), vec2(-0.5, -0.8660254038)};
uniform vec4[3] colors;
global uniform int numIterations;
global uniform vec2 size;

// real part = c(a^3 - 3ab^2) + d(a^2 - b^2) + e(a) + f
// imaj part = c(3a^2b - b^3) + c(2ab) + e(b)
vec2 eqValue(vec2 value) {
	float a = value.x;
	float b = value.y;
	float c = cubicEQ.x;
	float d = cubicEQ.y;
	float e = cubicEQ.z;
	float f = cubicEQ.w;
	return vec2(c*(pow(a,3.0) - 3.0*a*pow(b,2.0)) + d*(pow(a,2.0) - pow(b,2.0)) + e*a + f
	           ,c*(3.0*pow(a,2)*b - pow(b,3)) + d*(2.0*a*b) + e*(b));
}

vec2 derivitiveValue(vec2 value) {
	float a = value.x;
	float b = value.y;
	float c = derivitive.x;
	float d = derivitive.y;
	float e = derivitive.z;
	return vec2(c*(pow(a,2.0) - pow(b,2.0)) + d*a + e,
	            c*(2.0*b*a) + d*b);
}

vec2 division(vec2 v1, vec2 v2) {
	float a = v1.x;
	float b = v1.y;
	float c = v2.x;
	float d = v2.y;
	float e = (a*c + b*d) / (c*c + d*d);
	float f = (b*c - a*d) / (c*c + d*d);
	return vec2(e,f);
}

int closestZero(vec2 startPos) {
	vec2 currentPos = startPos;
	for (int x = 0; x < numIterations; x += 1) {
		vec2 change = division(eqValue(currentPos), derivitiveValue(currentPos));
		currentPos = vec2(currentPos.x - change.x, currentPos.y - change.y);
	}
	
	if (distance(zeroes[0], currentPos) < distance(zeroes[1], currentPos) && distance(zeroes[0], currentPos) < distance(zeroes[2], currentPos)) {
		return 0;
	} else if (distance(zeroes[1], currentPos) < distance(zeroes[2], currentPos)) {
		return 1;
	} else {
		return 2;
	}
	
	//if (distance(zeroes[0], currentPos) < distance(zeroes[1], currentPos)) {
		//return 0;
	//} else {
		//return 1;
	//}
	
}

vec2 position(vec2 startingPos) {
	vec2 currentPos = startingPos;
	for (int x = 0; x < numIterations; x += 1) {
		vec2 change = division(eqValue(currentPos), derivitiveValue(currentPos));
		currentPos = vec2(currentPos.x - change.x, currentPos.y - change.y);
	}
	return currentPos;
}

void vertex() {
}

void fragment() {
	//vec2 pos = vec2(FRAGCOORD.x, FRAGCOORD.y) * (size * 2.0);
	//pos -= size;
	vec2 pos = vec2((FRAGCOORD.x - size.x)/100.0, (-(FRAGCOORD.y - size.y))/100.0);
	//if (pos.x < 0.0 && pos.y < 0.0) {
		//COLOR = vec4(0,0,0,1);
	//} else if (pos.x > 0.0 && pos.y < 0.0) {
		//COLOR = vec4(1,0,0,1);
	//} else if (pos.x < 0.0 && pos.y > 0.0) {
		//COLOR = vec4(0,1,0,1);
	//} else {
		//COLOR = vec4(1, 1, 0, 1);
	//}
	//vec2 newPos = position(pos);
	COLOR = colors[closestZero(pos)];
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
