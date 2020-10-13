extends Node2D

export(Array,String) var Pos = []

export(Array,String) var Cartas = []

export(int) var MaxPuntaje = 0

var DECK = []

var ContCarta

var Puntaje

var ArrayCarta = []

var iniciar = false

var TimerGirar
var TimeInicio

var NDECK = []

func _ready():
	MesclarPos()
	GlobalVariables.EsperaGlobal = false
	TimerGirar = $Timer
	Puntaje = 0
	$AudioStreamPlayer2D.play()
	TimeInicio = $Inicio
	GirarTodasLasCartas()
	TimeInicio.start()
	iniciar = false
	
	pass

func MesclarPos():
	var x = 0
	for x in range(0,Pos.size()):
		DECK.append(get_node(Cartas[x]))
		pass
	x=0
	for x in range(0,Pos.size()):
		NDECK.append(x)
		pass
	randomize()
	randomize()
	
	var N = 0
	for N in range(0,Pos.size()):
		var NR = int(rand_range(0,NDECK.size()-1))
		DECK[N].global_position = get_node(Pos[NDECK[NR]]).global_position
		NDECK.remove(NR)
		pass
	pass

func ContCartas():
	if(ArrayCarta.size() < 1):
		ContCarta = 0
		var ArrayIndex = []
		var n = 0
		for n in range(0,Pos.size()):
			if(!DECK[n].WIN and DECK[n].Estado):
				ArrayIndex.append(n)
				ContCarta += 1
				pass
			pass
		if(ContCarta >= 2):
			if(DECK[ArrayIndex[0]].Nombre == DECK[ArrayIndex[1]].Nombre):
				$EfectSi.play()
				Puntaje += 1
				DECK[ArrayIndex[0]].WIN = true
				DECK[ArrayIndex[1]].WIN = true
				#WIN
				pass
			else:
				$EfectNo.play()
				ArrayCarta.append(ArrayIndex[0])
				ArrayCarta.append(ArrayIndex[1])
				TimerGirar.start()
				GlobalVariables.EsperaGlobal = true
				pass
			pass
		pass
	pass

func _process(delta):
	if(iniciar):
		ContCartas()
		if(Puntaje == MaxPuntaje):
			if(GlobalVariables.Nivel == GlobalVariables.MaxNivel):
				get_tree().change_scene("res://Scenes/Menu.tscn")
				pass
			else:
				get_tree().change_scene("res://Scenes/SiguienteNivel.tscn")
			pass
		pass
	pass

func GirarCartas():
	if(ArrayCarta.size() > 1):
		DECK[ArrayCarta[0]].GirarCarta()
		DECK[ArrayCarta[1]].GirarCarta()
		ArrayCarta.remove(1)
		ArrayCarta.remove(0)
		GlobalVariables.EsperaGlobal = false
		pass
	pass

func _on_Timer_timeout():
	GirarCartas()
	TimerGirar.stop()
	pass


func _on_AudioStreamPlayer2D_finished():
	$AudioStreamPlayer2D.play()
	pass

func GirarTodasLasCartas():
	var x=0
	for x in range(0,DECK.size()):
		DECK[x].GirarCarta()
		pass
	pass

func _on_Inicio_timeout():
	GirarTodasLasCartas()
	TimeInicio.stop()
	iniciar = true
	pass # Replace with function body.
