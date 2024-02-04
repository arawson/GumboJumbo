class_name Faction
extends Node


@export var faction_id: int = 0


@export var aggressive_towards: Array[Faction]


func _ready():
    _ready_post()


func _ready_post():
    pass


func add_unit(root: Node3D):
    print("F: add_unit")
    var unit = root.get_node("Unit") as Unit
    assert(unit != null, "nodes added to a Faction must have a unit child node")
    unit.faction_id = faction_id
    add_child(root)
