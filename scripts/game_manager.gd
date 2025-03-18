extends Node2D

@onready var back_button: Button = $Canvas/BackButton
@onready var buttons: HBoxContainer = $Canvas/Game/Buttons
@onready var accept_dialog: ConfirmationDialog = $AcceptDialog
@onready var timer: GameTimer = $Timer
@onready var max_score: Label = $Canvas/Game/Header/Points/VBoxContainer2/MaxScore

func _ready() -> void:
	max_score.text = str(Score.max_score)



func retry():
	accept_dialog.hide()
	get_tree().reload_current_scene()

func main_menu():
	back_button.emit_signal("pressed")

func on_game_over(points:int):
	timer.stop()
	for button in buttons.get_children():
		if button is Button:
			button.disabled=true
	accept_dialog.show()
	accept_dialog.dialog_text="Logos construidos: "+str(points)+"\nTotal veces que ha detenido el tiempo: "+str(timer.amount_time_stopped)
	max_score.text = str(Score.max_score)
