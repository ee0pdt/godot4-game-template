extends AudioStreamPlayer


@export var subtitle_text: String = "Enter title here"
var processed := false


func _ready() -> void:
	self.stream.set_loop(false)
	finished.connect(_clear_text)


func _process(_delta) -> void:
	if processed:
		return
	
	if playing:
		processed = true
		var msg = "[center]" + subtitle_text + "[/center]"
		GameEvents.subtitle.emit(msg)


func _clear_text() -> void:
	GameEvents.subtitle.emit("")
