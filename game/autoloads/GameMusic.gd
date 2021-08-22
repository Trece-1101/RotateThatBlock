extends Node

var music_playing:String setget ,get_music_playing

func get_music_playing() -> String:
	return music_playing

func play_music(music: String) -> void:
	stop_all_music()
	if music == "menu":
		$MenuMusic.play()
	elif music == "level":
		$LevelMusic.play()
	
	music_playing = music

func stop_all_music() -> void:
	for child in get_children():
		if child is AudioStreamPlayer:
			child.stop()

func play_button() -> void:
	$ButtonSound.play()

func play_win() -> void:
	$Win.play()

func play_lose() -> void:
	$Lose.play()
