extends KinematicBody2D

class_name Entity

#Inputs
var kLeft = Input.is_action_pressed("ui_left");
var kRight = Input.is_action_pressed("ui_right");
var kJump = Input.is_action_just_pressed("ui_up");
var kJumpRel = Input.is_action_just_released("ui_up");
var kDash = Input.is_action_just_pressed("ui_end");
var kAction_1 = false;
var kAction_2 = false;
var kEscape = Input.is_action_just_pressed("ui_quit");
var kDown = Input.is_action_pressed("ui_down");

#onready var SpriteManager = $SpriteScaler/Sprite;

#Velocities and Direction
#Multiplier
export var vxMax = 400.0;
export var vyMax = 1000.0;
var VEL = Vector2(0,0);
var dirUp = Vector2(0, -1);
var dirDown = Vector2(0, 1);
var gravityDir = dirUp;
var bOnGround = false;
var bOnWall = false;

var tempFric = 0;
var tempAccel = 0;

# Physics
export var vScale = 1.0;
export var gAccel = 10.0;
export var aAccel = 30.0;
export var gFric = 400.0;
export var aFric = 200.0;
export var grav = 16.0;
export var gravSlide = 6.0;
export var jumpHeight = 650;
export var dashSpeed = 1000;
export var WallPushX = 1100;

var jumpApex = 450;
var bNotifyApex = false;
var bCanNotifyApex = false;
var bOn_Floor = false;

#States
var IDLE = 10;
var RUN = 11;
var JUMP = 12;
var DASH = 13;
var ATTACK = 14;
var HIT = 15;
var WAIT = 0;
var STATE = IDLE;

#Sprites
var xScale = 1.0;
var yScale = 1.0;
var Facing = 1;

var RunDir = 1;

#Skills
#Jump
export var bHasSkill_DoubleJump = true;
var jumpCount = 0;
export var jumpMax = 1;
#Dash
export var bHasSkill_Dash = true;
var bCanDash = true;
var bIsDash = false;
var dashTime = 0;
var dashTimeMax = 5;
var bWasDash = false;
#Ground Slam
var bCanGroundSlam = false;
var bIsGroundSlam = false;
var groundSlamSpeed = 1500;




func _ready():
	pass;

func Set_Stat_Scale():
	gAccel *= vScale;
	aAccel *= vScale;
	gFric *= vScale;
	aFric *= vScale;
	grav *= vScale;
	gravSlide *= vScale;
	jumpHeight *= vScale;
	dashSpeed *= vScale;
	WallPushX *= vScale;

#func _process(delta):
#	#Apply_Movement(delta);
#	pass
	

func Apply_Movement(delta):
	# Children need to check ground here
	
	VEL = move_and_slide(VEL, gravityDir);

func Set_Physics():
	
	if (bOnGround):
		tempAccel = gAccel;
		tempFric = gFric;
	else:
		tempAccel = aAccel;
		tempFric = aFric;

func Horizontal_Movement(delta):
	
	if (kLeft && !kRight):
		if (VEL.x > 0):
			VEL.x = 0;
		VEL.x = Approach(VEL.x, -vxMax, tempAccel);
	
	if (kRight && !kLeft):
		if (VEL.x < 0):
			VEL.x = 0;
		VEL.x = Approach(VEL.x, vxMax, tempAccel);
	
	if (!kLeft && !kRight):
		VEL.x = Approach(VEL.x, 0.0, tempFric);

func Verticle_Movement(delta):
		#Gravity
	if (!bOnGround):
		VEL.y = Approach(VEL.y, (vyMax * -gravityDir.y), grav);
	
	if (kJumpRel && VEL.y < 0):
		VEL.y *= 0.25;

func Do_Jump(Power):
	var bSucceeded = false;
	if (bOnGround):
		VEL.y = Power * gravityDir.y;
		bSucceeded = true;
	elif (bHasSkill_DoubleJump):
		if (jumpCount < jumpMax):
			jumpCount += 1;
			VEL.y = (Power / 2) * gravityDir.y;
			bSucceeded = true;
	return bSucceeded;


func On_Landed(inVal):
	if (!bOnGround && inVal):
		return true;
	else:
		return false;
	pass

func Do_Landed():
	jumpCount = 0;

func Get_Input():
	kLeft = Input.is_action_pressed("kLeft");
	kRight = Input.is_action_pressed("kRight");
	kJump = Input.is_action_just_pressed("kJump");
	kJumpRel = Input.is_action_just_released("kJump");
	kAction_1 = Input.is_action_just_pressed("kAction_1");
	kAction_2 = Input.is_action_pressed("kAction_2");
	kDash = Input.is_action_just_pressed("kDash");
	kEscape = Input.is_action_just_pressed("kEscape");

func Zero_Input():
	kLeft = false;
	kRight = false;
	kAction_1 = false;
	kAction_2 = false;
	kDash = false;
	kJump = false;
	kJumpRel = false;

func Approach(start, end, shift):
	if (start < end):
		return min(start + shift, end);
	else:
		return max(start - shift, end);




