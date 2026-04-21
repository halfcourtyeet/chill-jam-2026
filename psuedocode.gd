# enemy tile object falls from the sky. 
# When unit collides with the area defined by the player and all the currently connected tiles (make a dynamic collision mesh):
# Calculate the closest available tile based on the collision point, scaled with player's global position.
# (This is also how we will calculate when that particular tile takes damage.)
# Delete the enemy tile object and add it to the player tile array.

# Every time a unit dies:
# For the four special tiles that are overlap the ship sprite (0,0, -1,0, -1,-1, 0,-1):
# Do a breadth first search through all connected tiles that "have" something in them (the little guy faces.)
# only visit if not already visited, mark each one as visited, BFS stuff, etc etc.
# After that, iterate through all active tiles. If they have not been visited, mark them for death
# Any tile marked for death becomes a tile "object" again.

# On the player tile update:
# Every player tile in the tileset has its own entry in a dictionary, which points to an object that tracks state.
# The objects can work via inheritance, so you can have a base PlayerTile object with health, etc,
# and have child and descendant PlayerTile objects that do different crazy stuff. 