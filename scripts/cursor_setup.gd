extends Node

@onready var cursors = $CursorPreloader

func _ready():
	Input.set_custom_mouse_cursor(cursors.get_resource("CURSOR_ARROW"), Input.CURSOR_ARROW)
	Input.set_custom_mouse_cursor(cursors.get_resource("CURSOR_IBEAM"), Input.CURSOR_IBEAM)
	Input.set_custom_mouse_cursor(cursors.get_resource("CURSOR_POINTING_HAND"), Input.CURSOR_POINTING_HAND)
	Input.set_custom_mouse_cursor(cursors.get_resource("CURSOR_CROSS"), Input.CURSOR_CROSS)
	Input.set_custom_mouse_cursor(cursors.get_resource("CURSOR_WAIT"), Input.CURSOR_WAIT)
	Input.set_custom_mouse_cursor(cursors.get_resource("CURSOR_BUSY"), Input.CURSOR_BUSY)
	Input.set_custom_mouse_cursor(cursors.get_resource("CURSOR_DRAG"), Input.CURSOR_DRAG)
	Input.set_custom_mouse_cursor(cursors.get_resource("CURSOR_CAN_DROP"), Input.CURSOR_CAN_DROP)
	Input.set_custom_mouse_cursor(cursors.get_resource("CURSOR_FORBIDDEN"), Input.CURSOR_FORBIDDEN)
	Input.set_custom_mouse_cursor(cursors.get_resource("CURSOR_VSIZE"), Input.CURSOR_VSIZE)
	Input.set_custom_mouse_cursor(cursors.get_resource("CURSOR_HSIZE"), Input.CURSOR_HSIZE)
	Input.set_custom_mouse_cursor(cursors.get_resource("CURSOR_BDIAGSIZE"), Input.CURSOR_BDIAGSIZE)
	Input.set_custom_mouse_cursor(cursors.get_resource("CURSOR_FDIAGSIZE"), Input.CURSOR_FDIAGSIZE)
	Input.set_custom_mouse_cursor(cursors.get_resource("CURSOR_MOVE"), Input.CURSOR_MOVE)
	Input.set_custom_mouse_cursor(cursors.get_resource("CURSOR_VSPLIT"), Input.CURSOR_VSPLIT)
	Input.set_custom_mouse_cursor(cursors.get_resource("CURSOR_HSPLIT"), Input.CURSOR_HSPLIT)
	Input.set_custom_mouse_cursor(cursors.get_resource("CURSOR_HELP"), Input.CURSOR_HELP)
