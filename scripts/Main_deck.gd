extends Node2D

@onready var card_scene: PackedScene = preload("res://scene/card.tscn")
@onready var rei: PackedScene = preload("res://scene/cards/kingCard.tscn")

@onready var hand: Hand = $CanvasLayer/Hand


var card_deck = []
@export var card_scenes: Dictionary = {
	"Rei": preload("res://scene/cards/kingCard.tscn"),
	"Rainha": preload("res://scene/cards/queenCard.tscn"),
	"Santa": preload("res://scene/cards/santaCard.tscn")
}

func shuffle_deck():
	var base_cards = [
		{"name": "Rei", "count": 1},
		{"name": "Rainha", "count": 1},
		{"name": "Santa", "count": 1}
	]
	
	card_deck.clear() 
	
	for card in base_cards:
		for i in range(card["count"]):
			var card_scene = card_scenes[card["name"]].instantiate()
			card_deck.append(card_scene)

	card_deck.shuffle()

	print("Baralho iniciado com as cartas:")
	print("Número total de cartas no baralho:", card_deck.size())

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	var rei_card = rei.instantiate()
	hand.add_card(rei_card)      
	print("Botão funciona e card criado")

func _on_button_3_pressed() -> void:
	if card_deck.is_empty():
		print("Baralho vazio! Embaralhando novamente...")
		shuffle_deck()

	var drawn_card = card_deck.pop_front()  # Retira a primeira carta do baralho
	
	print("Carta tirada: ", drawn_card.name)
	print("Número de cartas restantes no baralho: ", card_deck.size())
	
	var new_card = drawn_card.duplicate()
	
	var hand_node = hand
	if hand_node:
		hand_node.add_card(new_card)
