class_name PathfindingComponent extends Node

const space := preload("res://scripts/common/space.gd")

@export var agent: Node3D
@export var region: NavigationRegion3D
@export var path_point_margin := .5

var map: RID
var path: PackedVector3Array = []
var path_index: int

func _ready() -> void:
	assert(agent != null  && region != null)
	map = region.get_navigation_map()

func set_path(to: Vector3, restrictive: bool = false) -> void:
	path = NavigationServer3D.map_get_path(map, agent.global_transform.origin, to, not restrictive)
	path_index = 0

func next_point() -> Vector3:
	if (not has_path()): return Vector3.ZERO
	if (agent.global_position.distance_to(path[path_index]) <= path_point_margin):
		path_index += 1
	if (path_index >= path.size()):
		path = []
		path_index = 0
		return Vector3.ZERO
	return path[path_index]

func random_point_in_radius(radius: float, around: Vector3) -> Vector3:
	var v := space.random_point_in_radius(radius)
	return NavigationServer3D.map_get_closest_point(map, around + Vector3(v.x, around.y, v.y))
	
func has_path() -> bool:
	return not path.is_empty()
