extends Node2D

func _ready():
	$AnimationPlayer.play("Idle")
	pass

func _process(delta):
	if(!$AnimationPlayer.is_playing()):
		GlobalVariables.Nivel += 1
		get_tree().change_scene("res://Scenes/Nivel" + str(GlobalVariables.Nivel) + ".tscn")
		pass
	pass
