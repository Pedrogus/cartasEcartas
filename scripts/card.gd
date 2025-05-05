@tool
class_name Card
extends Node2D

@export var const_name: String = "Nome"
@export var const_point: int = 1
@export var const_image: Texture

@onready var costlbl: Label = $CostDisplay/ConstLbl
@onready var namelbl: Label = $CardName/NameLbl
@onready var image: Sprite2D = $CardImage/Image
@onready var area: Area2D = $Area2D

var is_hovered = false
var is_raised = false 
var raised = 50

func _ready() -> void:
	set_card_data(const_point, const_name, const_image)

func set_card_data(cost: int, name: String, texture: Texture) -> void:
	const_point = cost
	const_name = name
	const_image = texture
	_update_graphics()

func _update_graphics() -> void:
	# Atualiza o custo
	if costlbl:
		if costlbl.text != str(const_point):
			costlbl.text = str(const_point)
	else:
		print("Erro: Label de custo (costlbl) não encontrada!")

	# Atualiza o nome
	if namelbl:
		if namelbl.text != const_name:
			namelbl.text = const_name
	else:
		print("Erro: Label de nome (namelbl) não encontrada!")

	# Atualiza a imagem
	if image:
		if const_image:
			image.texture = const_image
		else:
			print("Aviso: Nenhuma textura definida para a carta.")
	else:
		print("Erro: Sprite2D de imagem (image) não encontrada!")
		

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			if is_hovered and not is_raised:
				raise_card()
		else:
			if is_raised:
				lower_card()


func raise_card() -> void:
	if not is_raised:
		is_raised = true
		position.y -= raised
	

# Abaixa o card
func lower_card() -> void:
	if is_raised:
		is_raised = false
		position.y += raised
	
# detecta quando o mouse está na carta
func _on_area_2d_mouse_entered() -> void: is_hovered = true
	


func _on_area_2d_mouse_exited() -> void:
	is_hovered = false
	if is_raised:
		lower_card()


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void: if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed and is_hovered:
			raise_card()
		elif not event.pressed and is_raised:
			lower_card()
