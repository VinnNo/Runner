extends Node2D

class_name Level

tool

var ei;
var es;

export var P_Start = preload("res://Scenes/PlayerStart.tscn");
var Tilemap = null;
export var Tileset_Path = "res://Resources/Cartoon_Tileset.tres"
var PlayerStart = null;

func _init():
	if (Engine.is_editor_hint()):
		var t = Set_Editor_Hint();
		editor_description = t;

func _enter_tree():
#	ei = EditorInterface.instance();
#	es = ei;
#	es.connect("selection_changed", self, "Selection_Changed");
	pass;

func Selection_Changed():
	var selected = es.get_selected_nodes();
	if (!selected.empty()):
		var selected_node = selected[0];
		print(selected);

func _ready():
	if (Engine.is_editor_hint()):
		var n = get_node("Player_Start");
		if (!n):
			var a = P_Start.instance();
			a.set_name("Player_Start");
			add_child(a);
			a.set_owner(self);
		n = get_node("TileMap_Level");
		if (!n):
			var a = TileMap.new();
			a.set_name("TileMap_Level");
			add_child(a);
			a.set_owner(self);
			if (a.tile_set != load(Tileset_Path)):
				a.tile_set = load(Tileset_Path);
			if (a.cell_size != Vector2(16,16)):
				a.cell_size = Vector2(16,16);
			
			
	add_to_group("Game", true);


#A dummy function.
func level():
	pass;


func Set_Editor_Hint():
	var t = "";
	t = "You will need:\n";
	t += "   -An Autumn..\n";
	t += "   -A Zophia...\n";
	t += "   -And a oGameCamera\n";
	return t;



func fence():
	var fence = MeshInstance.new();
	fence.set_name("MeshName");
	add_child(fence);
	fence.set_owner(self) ;
