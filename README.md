# Breakout-Game
A remake of Breakout using the Godot engine.

There is a regen block mechanic implemented, and the game uses inheritance for other blocks like it to be added easily.
Composition would probably be a better implementation, so that blocks can share the special properties of several blocks at once.

The game works on PC, and mostly works on mobile (keys movement mode is messed up)

There are two movement modes: keys (using arrow keys or A-D/tapping left-right on the screen) and follow (follows the mouse/finger)
Those modes can only be changed from within the Paddle class nodes. The exports use keys mode.
