extends KinematicBody

var speed = 20
var acceleration = 20
var gravity = 9.8
var jump = 5

var direction = Vector3()
var velocity = Vector3()
var fall = Vector3()

var mouse_sensitivity = 0.5

onready var head = $Head

# Mouse Visibility
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
# Camera movement
func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg2rad(-event.relative.x * mouse_sensitivity))
		head.rotate_x(deg2rad(-event.relative.y * mouse_sensitivity))
		head.rotation.x = clamp(head.rotation.x, deg2rad(-90), deg2rad(90))
	pass

#movement
func _process(delta):
	
	direction = Vector3()
	
	if not is_on_floor():
		fall.y = gravity * delta
	
	if Input.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
	if Input.is_action_pressed("ui_up"):
		
		direction -= transform.basis.z
		
	elif Input.is_action_pressed("ui_down"):
		
		direction += transform.basis.z
		
	if Input.is_action_pressed("ui_left"):
		
		direction -= transform.basis.x
		
	elif Input.is_action_pressed("ui_right"):
		
		direction += transform.basis.x
		
	direction = direction.normalized()
	move_and_slide(direction * speed, Vector3.UP)
	
	pass
