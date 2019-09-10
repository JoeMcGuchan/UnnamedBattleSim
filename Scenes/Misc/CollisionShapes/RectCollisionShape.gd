extends CollisionShape2D

#set this rect so it covers exactly from  
func stretch_to(pos : Vector2,r):
	position = position+pos/2
	scale.y = r
	scale.x = pos.length()/2
	rotation = pos.angle()