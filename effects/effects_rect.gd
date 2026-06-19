@tool
extends CanvasLayer



@onready var transition_rect: ColorRect = $TransitionRect


var transition_amount = 0.0:
	set(tr):
		transition_amount = tr
		var shader_material = transition_rect.material as ShaderMaterial
		shader_material.set_shader_parameter("progress", transition_amount)
