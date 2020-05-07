extends Control

onready var canvas = get_node("ViewportContainer/Viewport/Canvas")

var sav = false
var fileSaver

func _ready():
#	fileSaver = get_node("FileDialog")
	pass # Replace with function body.

func _on_Button_button_up():
	sav = true
	fileSaver.show()
	pass # Replace with function body.

func _on_ViewportContainer_resized():
#	viewport.set_size(get_size())
	pass # Replace with function body.

func setUtensilColor(newColor):
	canvas.setColor(newColor)
	pass

func setUtensilWidth(newWidth):
	canvas.setWidth(newWidth)
	pass

func saveData(path):
	var img = get_node("ViewportContainer/Viewport").get_texture().get_data()
	img.flip_y() # if the image is saved upsidedown do this
	img.save_png(path)
	pass

# Now delete test_image.jpg, it's .import file, and it's files in the .import folder!
# Then you can load and use the image from anywhere in the file system using the following code:
# (It can even be a completely different project!)

func loadData(path):
	print("Path", path.get_extension())
	if(path.get_extension() == "png" or path.get_extension() == "PNG"):
		get_node("ViewportContainer/Viewport/TextureRect").texture = load_png(path)
	elif(path.get_extension() == "jpg" or path.get_extension() == "JPG"):
		get_node("ViewportContainer/Viewport/TextureRect").texture = load_jpg(path)

func load_png(file):
	var png_file = File.new()
	png_file.open(file, File.READ)
	var bytes = png_file.get_buffer(png_file.get_len())
	var img = Image.new()
	var data = img.load_png_from_buffer(bytes)
	var imgtex = ImageTexture.new()
	imgtex.create_from_image(img)
	png_file.close()
	return imgtex

func load_jpg(file):
	var jpg_file = File.new()
	jpg_file.open(file, File.READ)
	var bytes = jpg_file.get_buffer(jpg_file.get_len())
	var img = Image.new()
	var data = img.load_jpg_from_buffer(bytes)
	var imgtex = ImageTexture.new()
	imgtex.create_from_image(img)
	jpg_file.close()
	return imgtex

func stopDrawing():
	sav = true

func resumeDrawing():
	sav = false

func clearEverything():
	canvas.clearBoard()
	pass

func undoALine():
	canvas.undoLine()
	pass

func eraseALine():
	canvas.eraseLine()
	pass

func resumingLines():
	canvas.createLinesAgain()
	pass

func _on_Board_mouse_entered():
	sav = true
	pass # Replace with function body.

func _on_Board_mouse_exited():
	sav = false
	pass # Replace with function body.
