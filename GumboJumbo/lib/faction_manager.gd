extends Node


var _factions: Dictionary = {}


func register_faction(f: Faction) -> void:
	if _factions.has(f.faction_id) and _factions[f.faction_id] == f:
		return
	assert(not _factions.has(f.faction_id), "Can't add 2 different factions with the same id")
	_factions[f.faction_id] = f
	print("FM: Faction registered %s id %s" % [f.name, f.faction_id])


func get_faction(id: int) -> Faction:
	return _factions[id] as Faction


func clear_factions():
	_factions = {}


func get_factions() -> Array[Faction]:
	var result: Array[Faction] = []
	for f in _factions.values():
		result.append(f)
	return result
