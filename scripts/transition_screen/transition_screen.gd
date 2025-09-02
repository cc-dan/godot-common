extends CanvasLayer
	
signal on_transition_finished
	
func transition(to_normal := false) -> void:
	%ColorRect.visible = true
	%AnimationPlayer.play("fade_to_black" if not to_normal else "fade_to_normal")

func _on_animation_finished(anim_name: StringName) -> void:
	%ColorRect.visible = false
	on_transition_finished.emit()
