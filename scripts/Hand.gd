@tool
class_name Hand extends Node2D

@export var hand_radius: int = 1000
@export var card_angle: float = -90
@export var angle_limit: float = 20
@export var max_card_spreed_angle: float = 5

@onready var card_test = $TestCard
@onready var colision_shape: CollisionShape2D = $DebugShape

var hand: Array = []

func add_card(card: Node2D):
	hand.push_back(card)
	add_child(card)
	reposition_card()

func remove_card(index: int) -> Node2D:
	var removing_card = hand[index]
	hand.remove_at(index)
	remove_child(removing_card)
	reposition_card()
	return removing_card


func reposition_card(): 
	var card_spreed = min(angle_limit / hand.size(), max_card_spreed_angle)
	var start_angle = -(card_spreed * (hand.size()- 1))/ 2 - 90
	for card in hand :
		_card_transform_update(card, start_angle)
		start_angle += card_spreed
		

func get_card_position(angle_in_deg: float) -> Vector2:
	var x: float = hand_radius * cos(deg_to_rad(angle_in_deg))
	var y: float = hand_radius * sin(deg_to_rad(angle_in_deg))
	
	return Vector2(int(x), int(y))
	
	
func _card_transform_update(card: Node2D, angle_in_drag: float):
	card.set_position(get_card_position(angle_in_drag))
	card.set_rotation(deg_to_rad(angle_in_drag + 90))
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Verifica se DebugShape foi encontrado
	if colision_shape == null:
		print("Erro: DebugShape não encontrado!")
		return
	
	# Verifica se DebugShape tem um shape
	if colision_shape.shape == null:
		print("Erro: DebugShape não tem um shape atribuído!")
		return
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	# tool logic
	if colision_shape and colision_shape.shape:
		var shape = colision_shape.shape as CircleShape2D
		if shape and shape.radius != hand_radius:
			shape.radius = hand_radius
	
	card_test.set_position(get_card_position(card_angle))
	card_test.set_rotation(deg_to_rad(card_angle + 90))
