extends Camera2D

signal quadrant_changed(quadrant: Vector2i)

var quadrant = Vector2i(0, 0)

var W = 240
var H = 135
var MX = 32
var MY = 16
var QW = W - 2 * MX
var QH = H - 2 * MY


func _on_worm_worm_moved(pos: Vector2, disp: Vector2) -> void:
	var x_0 = QW * quadrant.x + MX
	var x_1 = x_0 + QW
	
	var y_0 = QH * quadrant.y + MY
	var y_1 = y_0 + QH
	
	var q = quadrant
	
	if pos.x < x_0 and quadrant.x > -1 and disp.x < 0:
		quadrant.x -= 1
	elif pos.x > x_1 and quadrant.x < 1 and disp.x > 0:
		quadrant.x += 1
	elif pos.y < y_0 and quadrant.y > 0 and disp.y < 0:
		quadrant.y -= 1
	elif pos.y > y_1 and quadrant.y < 2 and disp.y > 0:
		quadrant.y += 1
	
	if quadrant != q:
		var tween = create_tween()
		quadrant_changed.emit(quadrant)
		tween.set_trans(Tween.TRANS_CUBIC)
		tween.tween_property(self, "position", quadrant_center(), 0.75)


func quadrant_center() -> Vector2:
	return Vector2(
		(quadrant.x + 0.5) * QW + MX,
		(quadrant.y + 0.5) * QH + MY,
	)
