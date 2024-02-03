
# A test of moving around the cylinder.
# This will turn into a regular enemy later.
extends CharacterBody3D


@export var cylinder_radius: float


# Movement
# Y behaves normally, since that is in the plane of the cylinder
# Cylinder is along X and Z, since we're using physics we need a restitution
# "force" to push the characters back onto the cylinder.


func _physics_process(delta):
    pass
