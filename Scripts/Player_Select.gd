extends Node2D

enum PLAYERS {FROG, PINKY, TIKI, VR};
var ActivePlayer = null;
var TargetPlayer = PLAYERS.FROG;

export var nFROG = preload("res://Scenes/Player_Frog.tscn");
export var nPINKY = preload("res://Scenes/Player_Pinky.tscn");
export var nTIKI = preload("res://Scenes/Player_Tiki.tscn");
export var nVR = preload("res://Scenes/Player_VR.tscn");

var nPrev_Menu = "res://Scenes/Level_Select.tscn";

func _ready():
	var a = Update_Selection(TargetPlayer);
	Set_Camera(a);
	pass;

func _input(event):
	var e = event;
	var a;
	if e.is_action_type() == Input.is_action_just_pressed("kRight"):
	#if (e.is_action_just_pressed("kRight")):
		a = Update_Selection(TargetPlayer + 1);
		Set_Camera(a);
		TargetPlayer = a;
		print("Right")
	if (e.is_action_pressed("kLeft")):
		a = Update_Selection(TargetPlayer - 1);
		Set_Camera(a);
		TargetPlayer = a;
	if (e.is_action_pressed("kAction1")):
		Set_Active_Player(TargetPlayer);
	if (e.is_action_pressed("kEscape")):
		get_tree().quit();


func Update_Selection(val):
	var v = val;
	var a = PLAYERS;
	
	if (v > PLAYERS.size()):
		v = 0;
	if ( v < 0):
		v = PLAYERS.size();
	return v;

func Set_Active_Player(val):
	var v = val;
	var a = PLAYERS;
	
	match (v):
		(a.FROG):
			GodScript.ActivePlayer = nFROG;
		(a.PINKY):
			GodScript.ActivePlayer = nPINKY;
		(a.TIKI):
			GodScript.ActivePlayer = nTIKI;
		(a.VR):
			GodScript.ActivePlayer = nVR;
	GodScript.ActiveLevel = load(nPrev_Menu);
	GodScript.Reset_Level();

func Set_Camera(val):
	var v = val;
	var a = PLAYERS;
	var b = $Camera2D/AnimationPlayer;
	var b2 = $Flare_Effect/AnimationPlayer;
	var c = b.current_animation;
	var c2 = b2.current_animation;
	var s = "";
	
	match (v):
		(a.FROG):
			s = "Frog";
		(a.PINKY):
			s = "Pinky";
		(a.TIKI):
			s = "Tiki";
		(a.VR):
			s = "VR";
	
	if (c != s):
		b.play(s);
	if (c2 != s):
		b2.play(s);
	


