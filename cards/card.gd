extends Resource
class_name Card

enum Types {
	TURN_LEFT,
	TURN_RIGHT,
	SHEILD,
}

const card_names = {
	Types.TURN_LEFT: "Turn Left",
	Types.TURN_RIGHT: "Turn Right",
	Types.SHEILD: "Sheild",
}

@export var type: Types


func get_type_as_string() -> String:
	return card_names[type]
