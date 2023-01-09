class_name Collectable extends Node3D

enum Types {
	APPLE,
	BREAD
}

const names = {
	Types.APPLE: "APPLE",
	Types.BREAD: "BREAD",
}

@export var type: Types
@export var audio_stream: AudioStream


func get_type_as_string() -> String:
	return names[type]


#func _ready() -> void:
#	%Subtitle.subtitle_text = tr(get_type_as_string())


func _subtitle() -> void:
	TranslationServer.set_locale("el")
	%Subtitle.stream = audio_stream
	%Subtitle.subtitle_text = tr(get_type_as_string())
	%Subtitle.show()


func _on_area_3d_body_entered(body: Node3D) -> void:
	_subtitle();
