class_name Card extends Node2D

@export var const_name: String = "Name"
@export var const_point: int = 1
@export var const_image: Texture 

@onready var costlbl: Label = $CostDisplay/ConstLbl
@onready var namelbl: Label = $CardName/NameLbl
@onready var image: Sprite2D = $CardImage/Image



func _ready() -> void:
	set_Cvalue(const_point, const_name,  const_image)
	visible = false

	
func set_Cvalue(_cost: int, _name: String, _image: Texture): 
	const_name = _name
	const_point = _cost
	const_image = _image
	
	costlbl.set_text(str(const_point))
	namelbl.set_text(const_name)
	if const_image:
		image.texture = const_image 

@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	pass
