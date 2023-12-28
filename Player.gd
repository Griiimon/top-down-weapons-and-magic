extends Node2D
class_name Player

signal weapon_switched(weapon_name)

# All the weapon the player has to switch between
@export var weapons: Array[BaseWeapon]

@onready var right_hand = $"Visual/Right Hand"
@onready var left_hand = $"Visual/Left Hand"

@onready var attack_delay = $"Attack Delay"
@onready var attack_cooldown = $"Attack Cooldown"

# The current index in the weapons Array
var current_weapon_idx: int:
	# Set a new index
	set(idx):
		# If previous weapon object existed, delete it
		if get_weapon_object(): 
			get_weapon_object().queue_free()
			# Wait for queue_free() to finish up
			await get_tree().process_frame
			
		# Make sure new weapon index isn't out of bounds
		current_weapon_idx= wrapi(idx, 0, weapons.size())

		var weapon: BaseWeapon= weapons[current_weapon_idx]
		var obj= weapon.hand_scene.instantiate()
		right_hand.add_child(obj)

		weapon_switched.emit(weapon.name)


func _ready():
	if weapons.size() == 0:
		push_error("Player has no weapons")
		get_tree().quit()

	current_weapon_idx= 0

func _physics_process(delta):
	if Input.is_action_just_pressed("next_weapon"):
		current_weapon_idx+= 1
	else:

		# Get Weapon Resource
		var weapon: BaseWeapon= weapons[current_weapon_idx]
		
		if Input.is_action_just_pressed("attack"):
			weapon.start_attack(self)
			
			# For additional weapon animations etc, if available in the
			# weapon object
			if get_weapon_object().has_method("start_attack"):
				get_weapon_object().start_attack()
			
			if weapon.attack_delay > 0:
				attack_delay.wait_time= weapon.attack_delay
				attack_delay.start()
				
		if Input.is_action_pressed("attack"):
			# Only trigger continued attack if no attack delay or it's passed
			# And if no attack cooldown or it's passed
			if attack_delay.is_stopped() and attack_cooldown.is_stopped():
				weapon.continue_attack(self)

				# For additional weapon animations etc, if available in the
				# weapon object
				if get_weapon_object().has_method("continue_attack"):
					get_weapon_object().continue_attack()
				
				if weapon.attack_interval > 0:
					attack_cooldown.wait_time= weapon.attack_interval
					attack_cooldown.start()
		
		elif Input.is_action_just_released("attack"):
			weapon.end_attack(self)

			# For additional weapon animations etc, if available in the
			# weapon object
			if get_weapon_object().has_method("end_attack"):
				get_weapon_object().end_attack()

func play_animation(anim_name: String, anim_duration: float= 1.0, from_end: bool= false):
	$AnimationPlayer.play(anim_name, -1, anim_duration, from_end)

# Get weapon object, currently in players hand
func get_weapon_object()-> Node2D:
	if right_hand.get_child_count() == 0:
		return null
	return right_hand.get_child(0)
