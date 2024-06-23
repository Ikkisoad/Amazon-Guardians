extends Control

@onready var master_h: HSlider = $masterH
@onready var g_music_h: HSlider = $GMusicH
@onready var sfx_music_h: HSlider = $SFXMusicH

const BUS_NAMES := ["Master", "SFX", "music"]
const DB_MAX = 6
const DB_MIN = -24

@onready var masterBus = AudioServer.get_bus_index(BUS_NAMES[0])
@onready var sfxBus = AudioServer.get_bus_index(BUS_NAMES[1])
@onready var musicBus = AudioServer.get_bus_index(BUS_NAMES[2])


func _ready() -> void:
	GetBaseVolume()
	
func GetBaseVolume() -> void:
	master_h.value = db_to_linear(AudioServer.get_bus_volume_db(masterBus))
	g_music_h.value = db_to_linear(AudioServer.get_bus_volume_db(musicBus))
	sfx_music_h.value = db_to_linear(AudioServer.get_bus_volume_db(sfxBus))


func _on_master_h_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(masterBus, linear_to_db(value))

func _on_g_music_h_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(musicBus, linear_to_db(value))

func _on_sfx_music_h_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(sfxBus, linear_to_db(value))
