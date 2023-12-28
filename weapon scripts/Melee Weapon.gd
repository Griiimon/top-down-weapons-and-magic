extends BaseWeapon
class_name MeleeWeapon

@export var attack_speed: float= 1.0


func start_attack(player: Player):
	player.play_animation(attack_animation, attack_speed)
