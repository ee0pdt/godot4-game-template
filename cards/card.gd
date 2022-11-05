extends Resource
class_name Card

enum Types {
	TURN_LEFT,
	TURN_RIGHT,
	SHEILD,
}

@export var type: Types
