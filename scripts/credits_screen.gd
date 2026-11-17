extends Control

@export var scroll_speed: float = 50.0
@onready var back: Button = $ScrollContainer/VBoxContainer/Back
@onready var scroll_container: ScrollContainer = $ScrollContainer
@onready var credits_text: RichTextLabel = $ScrollContainer/VBoxContainer/CreditsText

var credits_content := """
[center]
[font_size=36][b]The Loser Knight[/b][/font_size]


[font_size=24][color=yellow]Development[/color][/font_size]

Crowleyf


[font_size=24][color=yellow]Assets[/color][/font_size]

The art is based on  the sprites by analogStudios_ and RottingPixels
Knight - from camelot_
Slime - from dungeonSprites_
World Tileset - from Four Seasons Platformer Tileset
Platforms and Coin - from Four seasons platformer sprites
FONTS - by Jayvee Enaguas
Soldier - by Zerie
Main Menu Buttons, coins, deaths and timer icons - by my friend Artem

[font_size=24][color=yellow]Sounds[/color][/font_size]
MUSIC - by Brackeys, Sofia Thirslund
SOUNDS - by Brackeys, Asbjørn Thirslund





[font_size=20]Thanks for playing![/font_size]


[/center]
"""

func _ready() -> void:
	credits_text.text = credits_content
	scroll_container.scroll_vertical = 0

func _process(delta: float) -> void:
	var current_scroll := scroll_container.scroll_vertical
	scroll_container.scroll_vertical += int(scroll_speed * delta)
	
	if scroll_container.scroll_vertical == current_scroll and scroll_container.scroll_vertical > 0:
		scroll_container.scroll_vertical = 0

	if Input.is_action_pressed("ui_accept") or Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		scroll_container.scroll_vertical += int(scroll_speed * 3.0 * delta)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		_close_credits()


func _on_back_button_pressed() -> void:
	_close_credits()

func _close_credits() -> void:
	queue_free()
