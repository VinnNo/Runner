extends Button

export var Level = preload("res://Autumn_level 2.tscn");


func _ready():
	pass 



func _on_Button_pressed():
	GodScript.ActiveLevel = Level;
	GodScript.Reset_Level();
	pass
