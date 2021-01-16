extends Sprite






func _ready():
	pass 




func _on_Area2D_body_entered(body):
	if (body.has_method("Player_Hit")):
		queue_free();
