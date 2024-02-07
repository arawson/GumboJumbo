class_name HealthPool
extends Node


@export var health: int


signal damage_dealt(damage: int)
signal health_depleted()


func deal_damage(damage: int):
	health -= damage
	damage_dealt.emit(damage)
	if health <= 0:
		health_depleted.emit()
