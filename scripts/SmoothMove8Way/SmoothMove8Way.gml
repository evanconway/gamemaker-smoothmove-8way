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
	
	/**
	 * Returns boolean indicating if the given value is within the given range.
	 * Start of range is inclusive, end of range is exclusive.
	 *
	 * @param {real} _value
	 * @param {real} _start
	 * @param {real} _end
	 */
	in_range = function(_value, _start, _end) {
		return ((_value >= _start) && (_value < _end));
	};
}

/**
 * Sets the angle of the given SmoothMove8Way. The angle is rounded to the nearest cardinal
 * direction or intermediate.
 *
 * @param {Struct.SmoothMove8Way} _smooth_move SmoothMove8Way instance to set the angle of
 * @param {real} _angle the new angle in radians
 */
function smooth_move_8way_set_angle(_smooth_move, _angle) {
	with (_smooth_move) {
		if (_angle < 0) {
			_angle %= -2*pi
			_angle += 2*pi;
		}
		if (_angle >= 2*pi) _angle %= 2*pi;
	
		if ((_angle >= 15*pi/8) && (_angle < 1*pi/8)) _angle = 0*pi/8;
		else if ((_angle >= 1*pi/8) && (_angle < 3*pi/8)) _angle = 2*pi/8;
		else if ((_angle >= 3*pi/8) && (_angle < 5*pi/8)) _angle = 4*pi/8;
		else if ((_angle >= 5*pi/8) && (_angle < 7*pi/8)) _angle = 6*pi/8;
		else if ((_angle >= 7*pi/8) && (_angle < 9*pi/8)) _angle = 8*pi/8;
		else if ((_angle >= 9*pi/8) && (_angle < 11*pi/8)) _angle = 10*pi/8;
		else if ((_angle >= 11*pi/8) && (_angle < 13*pi/8)) _angle = 12*pi/8;
		else if ((_angle >= 13*pi/8) && (_angle < 15*pi/8)) _angle = 14*pi/8;

		angle = _angle;
	}
}
