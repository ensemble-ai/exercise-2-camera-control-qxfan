class_name FourWaySpeedupPushZone
extends CameraControllerBase

@export var push_ratio:float
@export var pushbox_top_left:Vector2 = Vector2(-8.0,-8.0)
@export var pushbox_bottom_right:Vector2 = Vector2(8.0,8.0)
@export var speedup_zone_top_left:Vector2 = Vector2(-4.0,-4.0)
@export var speedup_zone_bottom_right:Vector2 = Vector2(4.0,4.0)
var box_left:float = pushbox_top_left.x
var box_right:float = pushbox_bottom_right.x
var box_top:float = pushbox_top_left.y
var box_bottom:float = pushbox_bottom_right.y
var zone_left:float = speedup_zone_top_left.x
var zone_right:float = speedup_zone_bottom_right.x
var zone_top:float = speedup_zone_top_left.y
var zone_bottom:float = speedup_zone_bottom_right.y

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
	
	#boundary checks
	#left
	var diff_between_left_edges = (tpos.x - target.WIDTH / 2.0) - (cpos.x + box_left)
	if diff_between_left_edges < 0:
		global_position.x += diff_between_left_edges
	#right
	var diff_between_right_edges = (tpos.x + target.WIDTH / 2.0) - (cpos.x + box_right)
	if diff_between_right_edges > 0:
		global_position.x += diff_between_right_edges
	#top
	var diff_between_top_edges = (tpos.z - target.HEIGHT / 2.0) - (cpos.z + box_top)
	if diff_between_top_edges < 0:
		global_position.z += diff_between_top_edges
	#bottom
	var diff_between_bottom_edges = (tpos.z + target.HEIGHT / 2.0) - (cpos.z + box_bottom)
	if diff_between_bottom_edges > 0:
		global_position.z += diff_between_bottom_edges

	#speedup zone
	#left
	push_ratio = target.velocity.length() / 3
	var zone_diff_between_left_edges = (tpos.x - target.WIDTH / 2.0) - (cpos.x + zone_left)
	if zone_diff_between_left_edges < 0:
		global_position += push_ratio * target.velocity.normalized() * delta
	#right
	var zone_diff_between_right_edges = (tpos.x + target.WIDTH / 2.0) - (cpos.x + zone_right)
	if zone_diff_between_right_edges > 0:
		global_position += push_ratio * target.velocity.normalized() * delta
	#top
	var zone_diff_between_top_edges = (tpos.z + target.HEIGHT / 2.0) - (cpos.x + zone_top)
	if zone_diff_between_top_edges < 0:
		global_position += push_ratio * target.velocity.normalized() * delta
	#bottom
	var zone_diff_between_bottom_edges = (tpos.z + target.HEIGHT / 2.0) - (cpos.x + zone_bottom)
	if zone_diff_between_bottom_edges > 0:
		global_position += push_ratio * target.velocity.normalized() * delta
		
	super(delta)


func draw_logic() -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	immediate_mesh.surface_add_vertex(Vector3(box_right, 0, box_top))
	immediate_mesh.surface_add_vertex(Vector3(box_right, 0, box_bottom))
	
	immediate_mesh.surface_add_vertex(Vector3(box_right, 0, box_bottom))
	immediate_mesh.surface_add_vertex(Vector3(box_left, 0, box_bottom))
	
	immediate_mesh.surface_add_vertex(Vector3(box_left, 0, box_bottom))
	immediate_mesh.surface_add_vertex(Vector3(box_left, 0, box_top))
	
	immediate_mesh.surface_add_vertex(Vector3(box_left, 0, box_top))
	immediate_mesh.surface_add_vertex(Vector3(box_right, 0, box_top))
	
	immediate_mesh.surface_add_vertex(Vector3(zone_right, 0, zone_top))
	immediate_mesh.surface_add_vertex(Vector3(zone_right, 0, zone_bottom))
	
	immediate_mesh.surface_add_vertex(Vector3(zone_right, 0, zone_bottom))
	immediate_mesh.surface_add_vertex(Vector3(zone_left, 0, zone_bottom))
	
	immediate_mesh.surface_add_vertex(Vector3(zone_left, 0, zone_bottom))
	immediate_mesh.surface_add_vertex(Vector3(zone_left, 0, zone_top))
	
	immediate_mesh.surface_add_vertex(Vector3(zone_left, 0, zone_top))
	immediate_mesh.surface_add_vertex(Vector3(zone_right, 0, zone_top))
	immediate_mesh.surface_end()

	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.BLACK
	
	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	
	#mesh is freed after one update of _process
	await get_tree().process_frame
	mesh_instance.queue_free()
