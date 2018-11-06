extends KinematicBody2D

var direction : Vector2 = Vector2(0, -1)
var speed : float = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta: float):
	
	var total_velocity = direction * speed
	if Input.is_action_pressed("ui_left"):
		var target_velocity = total_velocity.tangent()
		
	if Input.is_action_pressed("ui_right"):
		pass
	
	var collide = move_and_collide(direction * speed * delta)
	
