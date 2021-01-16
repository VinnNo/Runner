extends Camera2D

var bLockY = true;
var Locked_Y = 0;
export var Speed_Normal = 5;
export var Speed_Boost = 20;
export var speed = 5;
export var Cam_OffsetY = -32;

# Called when the node enters the scene tree for the first time.
func _ready():
	Locked_Y = global_position.y;
	GodScript.bGamePaused = false;
	pass # Replace with function body.

func _process(delta):
	if (GodScript.bQuickCam):
		speed = Speed_Boost;
	else:
		speed = Speed_Normal;
	global_position.x = GodScript.Player_Position.x + (232 * GodScript.RunDir);
	if (global_position.y != GodScript.Cam_Y + (Cam_OffsetY * -GodScript.GravDir.y)):
		global_position.y = GodScript.Approach(global_position.y, GodScript.Cam_Y + (Cam_OffsetY * -GodScript.GravDir.y), speed);
