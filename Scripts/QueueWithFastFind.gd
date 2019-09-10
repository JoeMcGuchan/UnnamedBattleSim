extends Object

class_name QueueWithFastFind

var queue = []
var item_in_queue = {}

func push(item):
	queue.push_back(item)
	item_in_queue[item] = true

func push_if_not_duplicate(item):
	if not item_in_queue.has(item):
		push(item)
		
func has(item):
	return item_in_queue.has(item)
	
func pop():
	var item = queue.pop_front()
	item_in_queue.erase(item)
	return item
	
func empty():
	return queue.empty()