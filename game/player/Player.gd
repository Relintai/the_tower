extends KinematicBody

var camera_angle : float = 0
var mouse_sensitivity : float = 0.3
var camera_change : Vector2

var velocity : Vector3
var direction : Vector3

#flying
const FLY_SPEED = 10
const FLY_ACCEL = 8
var flying : bool = false

#waling
var gravity : float = -9.8 * 4
const MAX_SPEED = 10
const MAX_RUNNING_SPEED = 16
const ACCEL = 14
const DEACCEL = 14

#jumping
var jump_height = 12
var has_contact : bool = false
var double_jumped : bool = false

var jump_height_modifier : float = 1
var gravity_modifier : float = 1
var walk_speed_modifier : float = 1
var run_speed_modifier : float = 1
var accel_modifier : float = 1

#audio player
const WALK_STEP_TIME = 0.5
const MIN_SOUND_TIME_LIMIT = 0.3

var foot_audio : AudioStreamPlayer3D
var step_timer : float = 0
var foot : bool = false
var last_sound_timer : float = 0

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	foot_audio = $foot as AudioStreamPlayer3D

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		if not $Menu.visible:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			$Menu.show()
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			$Menu.hide()
		
	if Input.is_action_just_pressed("restart"):
		if get_node("../../").has_method("reload"):
			get_node("../../").reload()

func _physics_process(delta):
	aim()
	
	last_sound_timer += delta
	
	if flying:
		fly(delta)
	else:
		walk(delta)

func fly(delta):
	direction = Vector3()
	
	var aim : Basis = $Head/Camera.global_transform.basis
	
	if Input.is_action_pressed("move_forward"):
		direction -= aim.z
		
	if Input.is_action_pressed("move_backward"):
		direction += aim.z
		
	if Input.is_action_pressed("move_left"):
		direction -= aim.x
		
	if Input.is_action_pressed("move_right"):
		direction += aim.x
		
	if  Input.is_action_pressed("move_jump"):
		direction.y += 1
		
	direction = direction.normalized()
	
	var target : Vector3 = direction * FLY_SPEED * run_speed_modifier
	velocity = velocity.linear_interpolate(target, FLY_ACCEL * delta)
	
	move_and_slide(velocity)

func walk(delta):
	direction = Vector3()
	
	var aim : Basis = $Head/Camera.global_transform.basis
	
	if Input.is_action_pressed("move_forward"):
		direction -= aim.z
		
	if Input.is_action_pressed("move_backward"):
		direction += aim.z
		
	if Input.is_action_pressed("move_left"):
		direction -= aim.x
		
	if Input.is_action_pressed("move_right"):
		direction += aim.x
		
	direction = direction.normalized()
	
	if is_on_floor():
		has_contact = true
	else:
		if !$Contact.is_colliding():
			has_contact = false
			
	if has_contact and !is_on_floor():
		move_and_collide(Vector3(0, -1, 0))
	
	velocity.y += gravity * delta * gravity_modifier
	
	var temp_velocity : Vector3 = velocity
	temp_velocity.y = 0
	
	var speed : float
	var accel_multiplier : float = 1
	if Input.is_action_pressed("move_sprint"):
		accel_multiplier = 1.2
		speed = MAX_RUNNING_SPEED * run_speed_modifier
	else:
		speed = MAX_SPEED * walk_speed_modifier
		
	var accel : float
	if direction.dot(temp_velocity) > 0:
		accel = ACCEL * accel_multiplier
	else:
		accel = DEACCEL * accel_multiplier
	
	var target : Vector3 = direction * speed
	temp_velocity = temp_velocity.linear_interpolate(target, ACCEL * delta)
	
	velocity.x = temp_velocity.x
	velocity.z = temp_velocity.z

	if not has_contact and not double_jumped and Input.is_action_just_pressed("move_jump"):
		double_jumped = true
		velocity.y = jump_height * jump_height_modifier
		
	if has_contact and Input.is_action_just_pressed("move_jump"):
		velocity.y = jump_height * jump_height_modifier
		has_contact = false
		double_jumped = false
		
		if not foot_audio.playing and last_sound_timer >= MIN_SOUND_TIME_LIMIT:
			foot_audio.play()
			last_sound_timer = 0
			
		step_timer = 0
		
	velocity = move_and_slide(velocity, Vector3(0, 1, 0), true)
	
	if not has_contact and is_on_floor():
		if not foot_audio.playing and last_sound_timer >= MIN_SOUND_TIME_LIMIT:
			foot_audio.play()
			last_sound_timer = 0
			
		step_timer = 0
	
	var v : Vector3 = velocity
	v.y = 0
	if has_contact and v.length() > 1:
		step_timer += delta
		
		if step_timer >= WALK_STEP_TIME:
			step_timer = 0

			if not foot_audio.playing and last_sound_timer >= MIN_SOUND_TIME_LIMIT:
				foot_audio.play()
				last_sound_timer = 0


func _unhandled_input(event):
	if event is InputEventMouseMotion:
		camera_change = event.relative
		
func aim():
	if camera_change.length() > 0:
		$Head.rotate_y(deg2rad(-camera_change.x * mouse_sensitivity))
			
		var change : float = -camera_change.y * mouse_sensitivity
			
		if camera_angle + change > -90 and camera_angle + change < 90:
			$Head/Camera.rotate_x(deg2rad(change))
			camera_angle += change
			
		camera_change = Vector2()

func ladder_area_entered(ladder):
	flying = true
	
func ladder_area_exited(ladder):
	flying = false

func is_player():
	return true
