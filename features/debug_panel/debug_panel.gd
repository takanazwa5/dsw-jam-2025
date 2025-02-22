extends CanvasLayer


var label_settings : LabelSettings = LabelSettings.new()


@onready var labels_container : VBoxContainer = %LabelsContainer


func _ready() -> void:

	show()

	label_settings.outline_color = Color.BLACK
	label_settings.outline_size = 10


func _unhandled_input(event: InputEvent) -> void:

	if event is InputEventKey and event.pressed and not event.echo:

		if event.physical_keycode == KEY_F1:

			visible = not visible


func add_property(value: Variant, display_name: String, order: int) -> void:

	if labels_container.get_node_or_null(display_name) == null:

		var label : Label = Label.new()
		label.name = display_name
		label.label_settings = label_settings
		labels_container.add_child(label)

	elif visible:

		var label : Label = labels_container.get_node(display_name)
		label.text = "%s: %s" % [display_name, value]
		labels_container.move_child(label, order)
