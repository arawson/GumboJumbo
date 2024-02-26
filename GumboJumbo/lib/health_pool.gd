class_name HealthPool
extends Node


@export var health: int = 100


signal damage_received(damage: int)
signal health_depleted()


func deal_damage(damage: int):
	health -= damage
	damage_received.emit(damage)
	if health <= 0:
		health_depleted.emit()
