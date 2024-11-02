class_name PositionLockLerpSmoothing
extends CameraControllerBase

@export var follow_speed:float = 60.0
@export var catchup_speed:float = 80.0
@export var leash_distance:float = 10.0

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
	var distance = global_position.distance_to(target.global_position)
	
	if distance - leash_distance > 0:
		global_position += (tpos - cpos).normalized() * follow_speed * delta
	if target.velocity.is_zero_approx():
		global_position += (tpos - cpos).normalized() * catchup_speed * delta
	super(delta)


func draw_logic() -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	# 5X5 cross
	immediate_mesh.surface_add_vertex(Vector3(-2.5,0,0))
	immediate_mesh.surface_add_vertex(Vector3(2.5,0,0))
	immediate_mesh.surface_add_vertex(Vector3(0,0,-2.5))
	immediate_mesh.surface_add_vertex(Vector3(0,0,2.5))
	immediate_mesh.surface_end()

	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.WHITE
	
	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	
	#mesh is freed after one update of _process
	await get_tree().process_frame
	mesh_instance.queue_free()
