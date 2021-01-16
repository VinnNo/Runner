extends Sprite

export var bIsFlipped = false;

tool

func _init():
	if (Engine.is_editor_hint()):
		flip_v = bIsFlipped;

func _ready():
	if (bIsFlipped):
		flip_v = true;
	$AnimationPlayer.play("Idle");

func _on_Area2D_body_entered(body):
	if (body.has_method("Change_Gravity")):
		body.Change_Gravity();
		GodScript.bQuickCam = true;
		$AnimationPlayer.play("Hit");

func Set_Idle():
	$AnimationPlayer.play("Idle");
