extends Resource
class_name Inventory

signal items_changed(indexes)

export(Array, Resource) var items = [
	null, null, null,null, null, null,null, null, null
]

func set_item(index, item):
	var previous_item = items[index]
	items[index] = item
	emit_signal("items_changed", [index])
	return previous_item
	
func swap_item(index, target_index):
	var i = items[index]
	var t = items[target_index];
	items[index] = t
	items[target_index] = i
	emit_signal("items_changed", [index, target_index])
	
func remove_item(index):
	return set_item(index, null)
