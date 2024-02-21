extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_main_menu_start_game_pressed():
	$MainMenu.visible = false
	get_tree().paused = false


func _input(_event):
	if Input.is_action_just_pressed("pause"):
		$PauseMenu.open_pause_menu()
