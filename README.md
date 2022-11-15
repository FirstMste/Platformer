# Platformer

Level setup:

BackGroundTilemap - first node.
Platform_TileMap - second node.(tileMap is messed up use the first tileset and the last 2 )
all objects get put in a "control" node  - third node.
Player - fourth node.
GLOAD - fith node.

Walking enemy - can be change in inspector. (start moving direction and if it can be killed)
All levels have the world.gd script on and then you can choose the background setting and position of player start. (Player still needs to be in scene)
On world.gd you can choose if the player is moving left from start to finish or right if moving left the sideDeath should be in the positive and reversed for right.
If the Goal is put inside a Control node by accident the next level function will not work.
If any objects are outside the Control node their functionaly will not work.
Player can be adjusted for speed,jump force,friction,aceel ect in inspector.
