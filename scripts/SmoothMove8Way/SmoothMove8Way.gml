/**
 * Allows for smooth, integer, non-stair step movement along the cardinal directions 
 * and their intermediates.
 * @param {real} _x starting x position
 * @param {real} _y starting y position
 */
function SmoothMove8Way(_x, _y) constructor{
	start_x = _x;
	start_y = _y;
	angle = 0;
	delta = 0;
}
