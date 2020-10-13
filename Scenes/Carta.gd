extends Area2D

export var Nombre = ""
export var TiempoEspera = 2

var Estado = false

var Textura

var TexturaDorso

var TexturaCarta

var MouseActive

var Espera

var TimerEspera

var WIN

func _ready():
	
	Textura = $Texture
	TexturaDorso = Textura.texture
	if(Nombre == ""):
		Nombre= "A"
		pass
	TexturaCarta = load("res://Assets/Card/" + Nombre + ".png")
	MouseActive = false
	TimerEspera = $Timer
	TimerEspera.wait_time = TiempoEspera
	Espera = false
	WIN = false
	pass

func _process(delta):
	if(!GlobalVariables.EsperaGlobal and !Espera and !Estado and MouseActive and Input.is_action_just_pressed("Click")):
		GirarCarta()
		Espera = true
		TimerEspera.start()
		#print("Inicio Espera")
		pass
	pass

func GirarCarta():
	if(!Estado):
		Estado = true
		Textura.texture = TexturaCarta
		#print("Cambio a Carta")
		pass
	else:
		Estado = false
		Textura.texture = TexturaDorso
		#print("Cambio a Dorso")
		pass
	pass


func _on_Carta_mouse_entered():
	MouseActive = true
	#print("Entro Mouse")
	pass


func _on_Carta_mouse_exited():
	MouseActive = false
	#print("Salio Mouse")
	pass


func _on_Timer_timeout():
	Espera = false
	TimerEspera.stop()
	#print("Fin Espera")
	pass
