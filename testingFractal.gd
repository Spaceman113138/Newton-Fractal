extends MeshInstance2D



var cubicEQ: Vector4 = Vector4(1,0,0,0)
var derivitive: Vector3 = Vector3(3,0,0)
var zeroes: Array[Vector2] = [Vector2(1, 0), Vector2(-0.5, 0.8660254038), Vector2(-0.5, -0.8660254038)]
var color: Vector4 = Vector4(1,0,0,1)
@export var numIterations: int = 0
var initPos: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	initPos = global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var adjPosition: Vector2 = initPos / 100
	adjPosition.y = -adjPosition.y
	var currentPos: Vector2 = adjPosition
	var x: int = 0
	while x < numIterations:
		var change: Vector2 = division(eqValue(currentPos), derivitiveValue(currentPos));
		var new: Vector2 = Vector2(currentPos.x - change.x, currentPos.y - change.y)
		print(new)
		currentPos = Vector2(currentPos.x - change.x, currentPos.y - change.y);
		x += 1
	
		
	global_position = Vector2(currentPos.x, -currentPos.y) * 100
	


func division(v1: Vector2, v2: Vector2) -> Vector2:
	var a: float = v1.x
	var b: float = v1.y
	var c: float = v2.x
	var d: float = v2.y
	var e: float = (a*c + b*d) / (c*c + d*d)
	var f: float = (b*c - a*d) / (c*c + d*d)
	return Vector2(e,f);


# cx^2 + dx + e
#
# cx^2 = c(a + bi)(a + bi)
#        c(a^2 + 2abi - b^2)
#        c(a^2 - b^2), c(2abi)
# cx^2 = c(a^2 = b^2), c(2ab)i
#
# dx = d(a + bi)
#      da, dbi
# dx = da, dbi
#
# e = e
#
# real part = c(a^2 - b^2) + da + e
# imaj part = c(2ab) + db
func derivitiveValue(value: Vector2) -> Vector2:
	var a: float = value.x;
	var b: float = value.y;
	var c: float = derivitive.x;
	var d: float = derivitive.y;
	var e: float = derivitive.z;
	return Vector2(c*(pow(a,2.0) - pow(b,2.0)) + d*a + e,
				c*(2.0*b*a) + d*b);


func eqValue(value: Vector2) -> Vector2:
	var a: float = value.x;
	var b: float = value.y;
	var c: float = cubicEQ.x;
	var d: float = cubicEQ.z;
	var e: float = cubicEQ.z;
	var f: float = cubicEQ.w;
	return Vector2(c*(pow(a,3.0) - 3.0*a*pow(b,2.0)) + d*(pow(a,2.0) - pow(b,2.0)) + e*a + f
			   ,c*(3.0*pow(a,2)*b - pow(b,3)) + d*(2.0*a*b) + e*(b))
