extends Node3D

@onready var health_label: Label3D = $Label3D
@export var max_health := 5
var health : int:
    set(new_health):
        health = new_health
        on_health_set()
    get:
        return health

func on_health_set() -> void:
    health_label.text = str(health) + "/" + str(max_health)
    var green = Color.GREEN
    var red = Color.RED
    var blended_color := red.lerp(green, float(health) / float(max_health))
    health_label.modulate = blended_color
    if health < 1:
        get_tree().reload_current_scene()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    health = max_health    

func  take_damage() -> void:
    health -= 1
