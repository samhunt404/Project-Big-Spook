extends Node

#get the navigationregion instance
@onready var navreg = get_tree().get_nodes_in_group("Navigation")
var map

func _ready():
	call_deferred("_setup_navserver")

func _setup_navserver():
	map = NavigationServer3D.map_create()
	NavigationServer3D.map_set_up(map,Vector3.UP)
	NavigationServer3D.map_set_active(map,true)
	
	#add navigation regions to the map
	for n in navreg:
		var region = NavigationServer3D.region_create()
		NavigationServer3D.region_set_transform(region,n.transform)
		NavigationServer3D.region_set_map(region,map)
		
		#set navmesh for region
		var navigation_mesh = n.navmesh
		NavigationServer3D.region_set_navigation_mesh(region, navigation_mesh)
	
	#wait for navigationserver to adapt to made changes
	await get_tree().physics_frame

func get_navigation_path(start : Vector3, end : Vector3 ) -> PackedVector3Array:
	return(NavigationServer3D.map_get_path(map,start,end,true))
