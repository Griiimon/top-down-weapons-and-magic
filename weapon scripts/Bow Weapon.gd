extends ProjectileWeapon
class_name BowWeapon

# gets extra class because of custom bow mechanics
# with drawing and shooting once


func end_attack(player: Player):
	shoot(player)
