extends StaticBody3D

var synced := false

func _ready() -> void:
	await NavigationServer3D.map_changed
	synced = true

func _physics_process(delta: float) -> void:
	if not synced: return
	if not $PathfindingComponent3D.has_path():
		var path: Vector3 = $PathfindingComponent3D.random_point_in_radius(25, Vector3.ZERO)
		$PathfindingComponent3D.set_path(path)
	global_position += global_position.direction_to($PathfindingComponent3D.next_point()) * 3 * delta
