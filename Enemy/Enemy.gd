extends PathFollow3D

@export var movement_speed := 5
@export var max_health := 5
var health : int:
	set(new_health):
		health = new_health
		if new_health < health:
			animation_player.play("hit")
		if health < 1:
			queue_free()
	get:
		return health

@onready var base = get_tree().get_first_node_in_group("Base")
@onready var animation_player = $AnimationPlayer

func _ready() -> void:
	health = max_health

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if progress_ratio == 1.0:
		print(progress_ratio)
		base.take_damage()
		set_process(false)
	else:
		progress += delta * movement_speed

func take_damage() -> void:
	health -= 1
