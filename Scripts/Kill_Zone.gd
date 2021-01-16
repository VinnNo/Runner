extends Area2D




func _ready():
	pass;




func _on_Kill_Zone_body_entered(body):
	if (body.has_method("Player_Hit")):
		GodScript.Player_Hit(body);
