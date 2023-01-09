extends AudioStreamPlayer


@export var subtitle_text: String = "Enter title here"
var processed := false
var msg := ""


func _ready() -> void:
	self.stream.set_loop(false)
	finished.connect(_clear_text)


func _process(_delta) -> void:
	if processed:
		return
	
	if playing:
		processed = true
		msg = "[center]" + subtitle_text + "[/center]"
		GameEvents.subtitle.emit(msg)


func _clear_text() -> void:
	GameEvents.hide_subtitle.emit(msg)


func show():
	processed = false
	self.play();
