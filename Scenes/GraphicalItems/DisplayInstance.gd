extends Node2D

#the rules here are SIMPLE
#I want to display a thing on my game board
#but I don't want it to overlap with any thing else on said game board

#SOLUTION every object of the game board will now have a collision shape around it
#This displayinstance will cast the object outside of any collision shapes

enum DIRECTION {UP,UP_LEFT,LEFT,DOWN_LEFT,DOWN,DOWN_RIGHT,RIGHT,UP_RIGHT,CLOSEST}
export(DIRECTION) var main_direction = DIRECTION.CLOSEST

const MAX_DIST = 32

