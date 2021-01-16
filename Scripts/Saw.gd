extends Node2D


func _ready():
	$Sprite/AnimationPlayer.play("Idle");

func _on_Area2D_body_entered(body):
	GodScript.Player_Hit(body);

