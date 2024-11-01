class_name AutoScroll
extends CameraControllerBase

@export var top_left:Vector2 = Vector2(-10.0,-5.0)
@export var bottom_right:Vector2 = Vector2(10.0, 5.0)
@export var autoscroll_speed:Vector3 = Vector3(20.0, 0, 0)

var left:float = top_left.x
var right:float = bottom_right.x
var top:float = top_left.y
var bottom:float = bottom_right.y

func _ready() -> void: 
	super()
	position = target.position
	

func _process(delta: float) -> void:
	if !current:
		return
	
	if draw_camera_logic:
		
		draw_logic()
	
	var tpos = target.global_position
	var cpos = global_position
	
	global_position += autoscroll_speed * delta
	
	#boundary checks
	#left
	var left_diff = (tpos.x - target.WIDTH / 2.0) - (cpos.x + left)
	if left_diff < 0:
		target.global_position.x -= left_diff
	#right 
	var right_diff = (tpos.x + target.WIDTH / 2.0) - (cpos.x + right)
	if right_diff > 0:
		target.global_position.x -= right_diff
	#top
	var top_diff = (tpos.z - target.HEIGHT / 2.0) - (cpos.z + top)
	if top_diff < 0:
		target.global_position.z -= top_diff
	#bottom
	var bot_diff = (tpos.z + target.HEIGHT / 2.0) - (cpos.z + bottom)
	if bot_diff > 0:
		target.global_position.z -= bot_diff
		
	super(delta)


func draw_logic() -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	immediate_mesh.surface_add_vertex(Vector3(right, 0, top))
	immediate_mesh.surface_add_vertex(Vector3(right, 0, bottom))
	
	immediate_mesh.surface_add_vertex(Vector3(right, 0, bottom))
	immediate_mesh.surface_add_vertex(Vector3(left, 0, bottom))
	
	immediate_mesh.surface_add_vertex(Vector3(left, 0, bottom))
	immediate_mesh.surface_add_vertex(Vector3(left, 0, top))
	
	immediate_mesh.surface_add_vertex(Vector3(left, 0, top))
	immediate_mesh.surface_add_vertex(Vector3(right, 0, top))
	immediate_mesh.surface_end()

	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.BLACK
	
	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	
	#mesh is freed after one update of _process
	await get_tree().process_frame
	mesh_instance.queue_free()
