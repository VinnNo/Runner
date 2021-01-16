extends Sprite

func _on_Area2D_body_entered(body):
	GodScript.Player_Hit(body);
