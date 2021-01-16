extends Node2D

export var Power = 1000;



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func Do_Bounce():
	$Sprite/AnimationPlayer.play("Bounce");
	pass;


func Do_Idle():
	$Sprite/AnimationPlayer.play("Idle");


func _on_Area2D_body_entered(body):
	if (body.has_method("Do_Jump")):
		if (body.Do_Jump(Power)):
			body.STATE = body.JUMP;
		Do_Bounce();
