extends BaseWeapon
class_name ProjectileWeapon

const projectile_script= preload("res://Projectile.gd")

enum ProjectilePosition { DEFAULT, CENTERED }

@export var projectile_scene: PackedScene
@export var projectile_speed: float
@export var projectile_start_position: ProjectilePosition= ProjectilePosition.DEFAULT

func shoot(player: Player):
	var projectile= projectile_scene.instantiate()
	
	match projectile_start_position:
		ProjectilePosition.DEFAULT:
			projectile.position= player.right_hand.global_position
		ProjectilePosition.CENTERED:
			projectile.position= (player.right_hand.global_position + player.left_hand.global_position) / 2
	
	projectile.rotation= player.global_rotation
	projectile.set_script(projectile_script)
	projectile.speed= projectile_speed
	player.get_tree().current_scene.add_child(projectile)
	
