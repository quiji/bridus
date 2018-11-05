extends Node

# cache the viewport reference
onready var viewport = get_viewport()

# get game content (screen) width and height from project settings
# BTW don't forget to use stretch mode 2d and aspect ignore (since we're managing aspect ourselves)
onready var content_width = ProjectSettings.get("display/window/size/width")
onready var content_height = ProjectSettings.get("display/window/size/height")


func _ready():
	
	# listen to window resize changes
	viewport.connect("size_changed", self, "window_resize")
	# actually, should call window_resize() once here for initial setup, I forgot
	window_resize()

func window_resize():
	# get the game window's size
	var window_size = OS.get_window_size()
	
	# see how big the window is compared to the viewport size
	# floor it so we only get round numbers (0, 1, 2, 3 ...)
	var scale_x = floor(window_size.x / viewport.size.x)
	var scale_y = floor(window_size.y / viewport.size.y)

	# use the smaller scale with 1x minimum scale
	var scale = max(1, min(scale_x, scale_y))

	# find the coordinate we will use to center the viewport inside the window
	var diff = window_size - (viewport.size * scale)
	var diffhalf = (diff * 0.5).floor()

	# attach the viewport to the rect we calculated
	viewport.set_attach_to_screen_rect(Rect2(diffhalf, viewport.size * scale))
	
	"""
	Old script worked only on 2D and ignore which dosn't work for pixel perfect games
	# see how big the window is compared to our content size
	# floor it so we only get round numbers (0, 1, 2, 3 ...)
	var x_multiple = floor( window_size.x / content_width )
	var y_multiple = floor( window_size.y / content_height )
	
	# use either x or y multiple .. the smaller one
	var multiple = min( x_multiple, y_multiple )
	
	# if resize window very small then multiple will come out as 0 so make it at least 1
	if (multiple < 1):
		multiple = 1
	
	# divide the window_size vector by our final multiple so we get the target size for the viewport
	# (we are dividing a vector by a scalar)
	var target_size = window_size / multiple

	# set the target_size to the viewport
	viewport.set_size_override(true, target_size)
	
	# center viewport on content
	viewport.global_canvas_transform = Transform2D( 0, Vector2( floor(target_size.x/2 - content_width/2), floor(target_size.y/2 - content_height/2) ) )
	"""

"""
extends Node

# don't forget to use stretch mode 'viewport' and aspect 'ignore'
onready var viewport = get_viewport()

func _ready():
    get_tree().connect("screen_resized", self, "_screen_resized")

func _screen_resized():
    var window_size = OS.get_window_size()

    # see how big the window is compared to the viewport size
    # floor it so we only get round numbers (0, 1, 2, 3 ...)
    var scale_x = floor(window_size.x / viewport.size.x)
    var scale_y = floor(window_size.y / viewport.size.y)

    # use the smaller scale with 1x minimum scale
    var scale = max(1, min(scale_x, scale_y))

    # find the coordinate we will use to center the viewport inside the window
    var diff = window_size - (viewport.size * scale)
    var diffhalf = (diff * 0.5).floor()

    # attach the viewport to the rect we calculated
    viewport.set_attach_to_screen_rect(Rect2(diffhalf, viewport.size * scale))
"""

