extends CanvasLayer


@onready var transition_rect: ColorRect = $TransitionRect
@onready var crt:ColorRect = $CRT
@onready var overlay_rect: ColorRect = $OverlayRect


var transition_amount = 0.0:
	set(tr):
		transition_amount = tr
		var shader_material = transition_rect.material as ShaderMaterial
		shader_material.set_shader_parameter("progress", transition_amount)

var aberration = 0.005:
	set(ab):
		aberration = ab
		var shader_material = crt.material as ShaderMaterial
		shader_material.set_shader_parameter("aberration", aberration)

var brightness:float = 1.2:
	set(br):
		brightness = br
		var shader_material = crt.material as ShaderMaterial
		shader_material.set_shader_parameter("brightness", brightness)
	

var warp_amount:float = 0.0:
	set(wa):
		warp_amount = wa
		var shader_material = crt.material as ShaderMaterial
		shader_material.set_shader_parameter("warp_amount", brightness)


var overlay_opacity:float = 0.0:
	set(oa):
		overlay_opacity = oa
		overlay_rect.color.a = overlay_opacity
