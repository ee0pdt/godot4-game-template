extends AudioStreamPlayer


@export var subtitle_text: String = "Enter title here"


func _ready():
	finished.connect(_clear_text)


func _process(_delta):
	if playing:
		%Subtitle.text = "[center]" + subtitle_text + "[/center]"


func _clear_text():
	%Subtitle.text = ""
