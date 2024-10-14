extends Node

# taken from: https://github.com/Deep-Fold/PixelPlanets/blob/8ec6ee305527946ae415f4e7875587c974add273/Planets/Planet.gd#L52
func generate(color_amount: int, hue_diff: float, saturation: float) -> PackedColorArray:
	var a := Vector3(0.5, 0.5, 0.5)
	var b := Vector3(0.5, 0.5, 0.5)*saturation
	var c := Vector3(randf_range(0.5, 1.5), randf_range(0.5, 1.5), randf_range(0.5, 1.5))*hue_diff
	var d := Vector3(randf_range(0.0, 1.0), randf_range(0.0, 1.0), randf_range(0.0, 1.0))*randf_range(1.0, 3.0)
	
	var colors: PackedColorArray
	var n = max(1, float(color_amount - 1))
	for i in range(0, color_amount, 1):
		var v: Vector3
		v.x = (a.x + b.x*cos(TAU*(c.x*float(i/n) + d.x)))
		v.y = (a.y + b.y*cos(TAU*(c.y*float(i/n) + d.y)))
		v.z = (a.z + b.z*cos(TAU*(c.z*float(i/n) + d.z)))
		colors.append(Color(v.x, v.y, v.z))
	
	return colors
