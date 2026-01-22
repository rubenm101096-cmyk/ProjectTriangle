extends Polygon2D

onready var outline = $Outline

func _ready():
	color = Color.white

	outline.points = polygon
	outline.add_point(polygon[0])
