extends PathFollow3D

@export var movement_speed := 5
@export var max_health := 2
@export var gold_value : int = 15


@onready var base = get_tree().get_first_node_in_group("Base")
@onready var animation_player = $AnimationPlayer
@onready var bank : MarginContainer = get_tree().get_first_node_in_group("Bank")

var health : int:
	set(new_health):
		if new_health < health:
			animation_player.play("hit")
		health = new_health
		if health < 1:
			bank.gold += gold_value
			queue_free()
	get:
		return health

func _ready() -> void:
	health = max_health

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if progress_ratio == 1.0:
		base.take_damage()
		set_process(false)
		queue_free()
	else:
		progress += delta * movement_speed

func take_damage() -> void:
	health -= 1
