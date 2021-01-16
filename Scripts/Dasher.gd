extends Entity

# Called when the node enters the scene tree for the first time.
func _ready():
	Set_States(JUMP);
	GodScript.Cam_Y = global_position.y;
	GodScript.bGamePaused = false;


func _physics_process(delta):
	if (GodScript.bGamePaused):
		return;
	var q = Input.is_action_just_pressed("kEscape");
	if (q):
		get_tree().quit();
	Do_States(delta);
	Apply_Movement(delta);
	Update_God();
	Do_Animations(STATE);

func Set_States(val):
	match (val):
		(IDLE):
			STATE = IDLE;
		(RUN):
			Set_Run_Direction(GodScript.RunDir);
			STATE = RUN;
		(JUMP):
			Set_Run_Direction(GodScript.RunDir);
			STATE = JUMP;

func Do_States(delta):
	Set_Physics();
	$FloorRay1.force_raycast_update();
	$FloorRay2.force_raycast_update();
	$FloorRay3.force_raycast_update();
	$WallRay.force_raycast_update();
	
	if ($WallRay.is_colliding()):
		Player_Hit();
		
	var rp = $RunParticles;
	var e = $RunParticles.emitting;
		
	match (STATE):
		(IDLE):
			if (e):
				rp.emitting = false;
			kRight = false;
			kLeft = false;
			VEL = Vector2(0,0);
		(RUN):
			if (!e):
				rp.emitting = true;
			Horizontal_Movement(delta);
			var bCollided = Check_Floors();
			if (!bCollided):
				Set_States(JUMP)
				bOnGround = false;
			#bOnGround = bCollided;
			if (Input.is_action_just_pressed("kJump")):
				#VEL.y = (jumpHeight * gravityDir.y);
				Do_Jump(jumpHeight);
				Set_States(JUMP);
		(JUMP):
			if (e):
				rp.emitting = false;
#			if (scale.x != GodScript.RunDir):
#				scale.x = GodScript.RunDir;
			Verticle_Movement(delta);
			Horizontal_Movement(delta);
			var bCollided = Check_Floors();
			if (On_Landed(bCollided)):
				bOnGround = bCollided;
				Set_States(RUN);
				GodScript.Cam_Y = global_position.y;
				GodScript.bQuickCam = false;
			if (bOnGround):
				Set_States(RUN);
			kJumpRel = Input.is_action_just_released("kJump");
		(HIT):
			if (e):
				rp.emitting = false;
			kRight = false;
			kLeft = false;
			VEL = Vector2(0,0);

func Do_Animations(inState):
	match (inState):
		(IDLE):
			$Sprite/Sprite_Player.play("Idle");
		(RUN):
			$Sprite/Sprite_Player.play("Run");
		(JUMP):
#			if (VEL.y < jumpApex && VEL.y > -jumpApex):
#				$Sprite/Sprite_Player.play("JumpMid");
#			else:
#				if (gravityDir == dirUp):
#					if (VEL.y > 0):
#						$Sprite/Sprite_Player.play("JumpDown");
#					else:
#						$Sprite/Sprite_Player.play("JumpUp");
#				else:
#					if (VEL.y < 0):
#						$Sprite/Sprite_Player.play("JumpDown");
#					else:
#						$Sprite/Sprite_Player.play("JumpUp");
			$Sprite/Sprite_Player.play("Twirl");
		(HIT):
			$Sprite/Sprite_Player.playback_speed = 1;
			$Sprite/Sprite_Player.play("Hit");

func Check_Floors():
	var col1 = $FloorRay1.is_colliding();
	var col2 = $FloorRay2.is_colliding();
	var col3 = $FloorRay3.is_colliding();
	var a = (col1 || col2 || col3);
	return a;

func Update_God():
	GodScript.Player_Position = global_position;
	GodScript.GravDir = gravityDir;

func Change_Gravity():
	if (gravityDir == dirUp):
		gravityDir = dirDown;
		scale.y = -1;
	else:
		gravityDir = dirUp;
		scale.y = 1;

func Player_Died():
	GodScript.Reset_Level();
	pass;

func Player_Hit():
	STATE = HIT;
	pass;

func Set_Run_Direction(val):
	if (RunDir != val):
		VEL = Vector2(0,0);
		VEL = move_and_slide(VEL, gravityDir);
	if (val > 0):
		$Sprite.flip_h = false;
		kRight = true;
		kLeft = false;
	else:
		$Sprite.flip_h = true;
		kRight = false;
		kLeft = true;
		$WallRay.cast_to.x = 7.7 * val;
	RunDir = val;
	GodScript.RunDir = RunDir;

