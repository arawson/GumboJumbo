class_name Unit
extends Node


var _faction_id: int = -1
@export var faction_id: int = -1:
    get:
        return _faction_id
    set(value):
        for c in components:
            if "faction_id" in c:
                c.faction_id = value
        _faction_id = value


@export var components: Array[Node]


func _ready():
    pass
