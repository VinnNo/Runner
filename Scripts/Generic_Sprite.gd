extends Sprite

func _ready():
	var a = $AnimationPlayer;
	if (a == null):
		return;
	a.play("idle");


