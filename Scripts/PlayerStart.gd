extends Node2D

tool

var player = null;

func _ready():
	if (Engine.is_editor_hint()):
		$Player_Start/Sprite/AnimationPlayer.play("Idle Editor");
	else:
		$Player_Start/Sprite/AnimationPlayer.play("Idle");
		var p = get_parent();
		player = GodScript.ActivePlayer;
		GodScript.Player_Position = global_position;
		GodScript.Cam_Y = global_position.y;
		GodScript.RunDir = 1;


func Spawn_Player():
	if (player == null):
		return;
	var a = player.instance();
	var p = get_parent();
	p.add_child(a);
	a.global_position = global_position;
	queue_free(); 

