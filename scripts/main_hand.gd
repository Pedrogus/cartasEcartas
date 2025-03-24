extends Node2D

@onready var card_scene: PackedScene = preload("res://scene/card.tscn")


@onready var spawn_point =  $CanvasLayer/spawn

	# Array contendo os dados das cartas
	
var card_deck = []

func shuffle_deck():
	var base_cards = [
	{"cost": 5, "name": "Rei", "image": "res://assets/Rei_sprite.png", "count": 5},
		{"cost": 5, "name": "Rainha", "image": "res://assets/Rainha_sprite.png", "count": 5},
		{"cost": 2, "name": "Santa", "image": "res://assets/Santa_sprite.png", "count": 4},
		{"cost": 2, "name": "Inventor", "image": "res://assets/Inventor_sprite.png", "count": 4},
		{"cost": 1, "name": "Feiticeira", "image": "res://assets/Feiticeira_sprite.png", "count": 4},
		{"cost": 1, "name": "Pirata", "image": "res://assets/Pirata_sprite.png", "count": 3},
		{"cost": 0, "name": "Demônio", "image": "res://assets/Diabo_sprite.png", "count": 3}
	]
	
	card_deck.clear() 
	
	for card in base_cards:
		for i in range(card["count"]):	
			card_deck.append(card.duplicate(true))
	
	card_deck.shuffle()  # Embaralha as cartas
	
	print("Baralho iniciado com as cartas:")
	print("Número total de cartas no baralho:", card_deck.size())

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	var card = card_scene.instantiate()
	
	spawn_point.add_child(card)
	card.set_Cvalue(5, "Rei", load("res://assets/Rei_sprite.png"))
	card.visible = true
	pass 


func _on_button_3_pressed() -> void:
	if card_deck.is_empty():
		print("Baralho vazio! Embaralhando novamente...")
		shuffle_deck()

	var drawn_card = card_deck.pop_front()  # Pega a primeira carta do deck embaralhado
	
	print("Carta tirada: ", drawn_card["name"])
	print("Número de cartas restantes no baralho: ", card_deck.size())

	var card = card_scene.instantiate()
	spawn_point.add_child(card)

	card.set_Cvalue(drawn_card["cost"], drawn_card["name"], load(drawn_card["image"]))
	card.visible = true
	pass # Replace with function body.
