extends ProjectileWeapon
class_name SpellWeapon

func start_attack(player: Player):
	player.play_animation(attack_animation)

func continue_attack(player: Player):
	shoot(player)

func end_attack(player: Player):
	# Play animation backwards when attack is finished
	player.play_animation(attack_animation, -1, true)
