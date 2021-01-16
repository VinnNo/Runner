extends Node

var Player_Position = Vector2(0,0);
var Cam_Y = 0;
var bQuickCam = false;

var RunDir = 1;
var GravDir = Vector2(0,0);

var bGamePaused = true;

var GameOver_Texture;

var nLevel = preload("res://Scenes/TestWorld.tscn");
var autumn = preload("res://Autumn_level 2.tscn");
var Autumn3 = preload("res://Autumn_level 3.tscn");
var Autumn5 = preload("res://Autumn_level 5.tscn");

var ActivePlayer = preload("res://Scenes/Player_Pinky.tscn");
var ActiveLevel = preload("res://Autumn_level 2.tscn");

func Approach(start, end, shift):
	if (start < end):
		return min(start + shift, end);
	else:
		return max(start - shift, end);

func Reset_Level():
	var p = get_parent();
	for i in p.get_children():
		if (i.is_in_group("Game")):
			i.queue_free();
	var a = ActiveLevel.instance();
	p.add_child(a);

func Player_Hit(body):
	if (body.has_method("Player_Hit")):
		body.Player_Hit();

func Set_RunDir(val):
	pass;
