extends StateMachine


func _ready():
	add_state("idle")
	add_state("move")
	add_state("dash")
	call_deferred("set_state", states.move)


func _state_logic(delta):
	match state:
		states.idle:
			parent.state_idle()
		states.move:
			parent.state_move()
		states.dash:
			parent.state_dash()
	
	if state != states.dash:
		if parent.input != Vector2.ZERO:
			parent.direction = parent.input
	
	
	parent._apply_velocity()


func _get_transition(delta):
	match state:
		states.idle:
			if parent.input != Vector2.ZERO:
				return states.move
			if parent.should_dash:
				return states.dash
		states.move:
			if parent.input == Vector2.ZERO:
				return states.idle
			if parent.should_dash:
				return states.dash
		states.dash:
			if parent.timer_dash_duration.is_stopped():
				return states.idle
	
	return null


func _enter_state(new_state, old_state):
	match state:
		states.idle:
			pass
		states.move:
			pass
		states.dash:
			parent.enter_state_dash()


func _exit_state(old_state, new_state):
	pass
