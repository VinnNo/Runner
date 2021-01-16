extends Sprite

export var bIsFlipped = false;
var bCanTouch = true;
var b = null;

func _ready():
	pass;

func _on_Area2D_body_entered(body):
	if (!bCanTouch):
		return;
	if (body.has_method("Player_Hit")):
		var a = body.RunDir;
		if (a > 0):
			a = -1;
		else:
			a = 1;
		body.Set_Run_Direction(a);
		b = body;
		bCanTouch = false;


func _on_Area2D_body_exited(body):
	if (body == b):
		b = null;
		bCanTouch = true;
