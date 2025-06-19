# Autoloaded
extends Node

signal shoot(shooting_position: Vector2, ammo_resource: AmmoResource, direction: Vector2)
signal is_dead(entity: Node)
signal weapon_switch(weapon_res: WeaponResource, shortcut: String)
signal stat_found(stat_res: StatResource)

