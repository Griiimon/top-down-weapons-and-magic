extends Resource
class_name BaseWeapon

@export var name: String
# The scene that is instantiated for the player to hold in his hand
@export var hand_scene: PackedScene
# The name of the attack animation in the players AnimationPlayer
@export var attack_animation: String


@export var attack_delay: float= 0
@export var attack_interval: float= 0

func start_attack(player: Player):
	pass

func continue_attack(player: Player):
	pass

func end_attack(player: Player):
	pass

