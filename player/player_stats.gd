extends Node


signal token_gathered(tokens:int)


var tokens = 0
var new_tokens = 0


func get_tokens() -> int:
	return tokens + new_tokens


func increment_new_tokens() -> int:
	new_tokens += 1
	token_gathered.emit(tokens + new_tokens)
	return tokens


func commit() -> void:
	tokens = tokens + new_tokens
	new_tokens = 0


func reset(hard = false) -> void:
	new_tokens = 0
	if hard:
		tokens = 0
