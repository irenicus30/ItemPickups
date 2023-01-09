extends CenterContainer


var inventory = preload("res://items/Inventory.tres")
@onready var item_texture_rect = $ItemTextureRect


func display_item(item):
    if item is Item:
        item_texture_rect.texture = item.texture
    else:
        item_texture_rect.texture = preload("res://assets/EmptyInventorySlot.png")


func _get_drag_data(_position):
    var item_index = get_index()
    var item = inventory.remove_item(item_index)
    if item is Item:
        var data = {}
        data.item = item
        data.item_index = item_index
        var drag_preview = TextureRect.new()
        drag_preview.texture = item.texture
        set_drag_preview(drag_preview)
        
        return data


func _can_drop_data(_position, data):
    return data is Dictionary and data.has("item")


func _drop_data(_position, data):
    var my_item_index = get_index()
    inventory.swap_items(my_item_index, data.item_index)
    inventory.set_item(my_item_index, data.item)
