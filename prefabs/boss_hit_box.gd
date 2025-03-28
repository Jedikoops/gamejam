extends StaticBody2D

func _hurt(damage):
	get_parent()._hurt(damage)
