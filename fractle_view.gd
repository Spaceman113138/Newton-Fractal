extends MeshInstance2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	resize()
	get_tree().get_root().size_changed.connect(resize)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func resize():
	mesh.size = get_window().size
	RenderingServer.global_shader_parameter_set("size", get_window().size/2)


# a + bi

#  cx^3 + dx^2 + ex + f

# cx^3 = c(a + bi)(a + bi)(a + bi)
#        c(a^2 + 2abi -b^2)(a + bi)
#        c(a^3 + a^2bi + 2a^2bi - 2ab^2 - ab^2 - b^3i)
#        c(a^3 - 3ab^2 + 3a^2bi - b^3i)
#        c(a^3 - 3ab^2), c(3a^2bi - b^3i)
# cx^3 = c(a^3 - 3ab^2), c(3a^2b - b^3)i
#
# dx^2 = d(a + bi)(a + bi)
#        d(a^2 + 2abi - b^2)
#        d(a^2 - b^2), d(2abi)
# dx^2 = d(a^2 - b^2), d(2ab)i
#
# ex = e(a + bi)
#      e(a), e(bi)
# ex = e(a), e(b)i
#
# f = f
#
# real part = c(a^3 - 3ab^2) + d(a^2 - b^2) + e(a) + f
# imaj part = c(3a^2b - b^3) + c(2ab) + e(b)



# cx^2 + dx + e
#
# cx^2 = c(a + bi)(a + bi)
#        c(a^2 + 2bi - b^2)
#        c(a^2 - b^2), c(2bi)
# cx^2 = c(a^2 = b^2), c(2b)i
#
# dx = d(a + bi)
#      da, dbi
# dx = da, dbi
#
# e = e
#
# real part = c(a^2 - b^2) + da + e
# imaj part = c(2b) + db
