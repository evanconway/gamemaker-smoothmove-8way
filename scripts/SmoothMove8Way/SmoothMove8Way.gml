/**
 * Allows for smooth, integer, non-stair step movement along the cardinal directions and their intermediates.
 *
 * @param {real} _x starting x position
 * @param {real} _y starting y position
 */
function SmoothMove8Way(_x, _y) constructor{
	// start values should only ever be integers
	start_x = _x;
	start_y = _y;
	
	angle = 0;
	delta = 0;
	
	/**
	 * Rounds given value to 0 if it's already close. This is mostly to deal
	 * with sin and cos not returning a perfect 0 on certain values.
	 *
	 * @param {real} _value
	 */
	function snap_to_zero(_value) {
		return abs(_value) < 0.001 ? 0 : _value;
	};
	
	/**
	 * Wrapper function around sin that snaps the result to 0 if it's within 0.001 of 0.
	 *
	 * @param {real} _angle angle in radians
	 */
	function snap_sin(_angle) {
		return snap_to_zero(sin(_angle));
	}
	
	/**
	 * Wrapper function around cos that snaps the result to 0 if it's within 0.001 of 0.
	 *
	 * @param {real} _angle angle in radians
	 */
	function snap_cos(_angle) {
		return snap_to_zero(cos(_angle));
	}
	
	/**
	 * Get the change in x for the current delta.
	 */
	get_magnitude_x = function() {
		return snap_cos(angle) * delta;
	}
	
		/**
	 * Get the change in y for the current delta.
	 */
	get_magnitude_y = function() {
		return snap_sin(angle) * delta;
	};
	
	/**
	 * SmoothMove works by inferring x and y positions based off the 2D vector created by
	 * angle and delta.it's moved by. This function returns true if the x magnitude of the
	 * vector is greater than the y magnitude, indicating that the y position should be 
	 * inferred from the x position. Returns false if the reverse is true.
	 *
	 */
	infer_y_from_x = function() {
		return (angle <= 1*pi/4 || angle >= 7*pi/4 || (angle >= 3*pi/4 && angle <= 5*pi/4));
	};
	
	/**
	 * Get the slope to be used to infer an x or y position. The slope changes depending on
	 * whether the x or y magnitude of the 2D vector is greater.
	 */
	slope = function() {
		if (delta == 0) return 0;
		var _slope = infer_y_from_x() ? get_magnitude_y() / get_magnitude_x() : get_magnitude_x() / get_magnitude_y();
		return floor(_slope * 1000 + 0.5) / 1000; // round to account for imperfections
	};
	
	/**
	 * Returns _a rounded towards the floor of _b.
	 *
	 * @param {real} _a
	 * @param {real} _b
	 */
	round_towards = function(_a, _b) {
		return (_a - floor(_b)) >= 0 ? floor(_a) : ceil(_a);
	};
	
	/**
	 * Sets delta to 0, and sets start_x and start_y to currently calculated x and y positions.
	 */
	reset = function() {
		var _x = smooth_move_8way_get_x(self);
		var _y = smooth_move_8way_get_y(self);
		start_x = _x;
		start_y = _y;
		delta = 0;
	};
}

/**
 * Get the calculated x position of the given SmoothMove8Way instance.
 *
 * @param {Struct.SmoothMove8Way} _smooth_move
 */
function smooth_move_8way_get_x(_smooth_move) {
	with (_smooth_move) {
		if (delta == 0) return start_x;
		if (infer_y_from_x()) {
			var _mag_x = get_magnitude_x();
			var _x = start_x + _mag_x;
			var _result = round_towards(_x, start_x);
			return _result;
		}
		
		// infer x position from y
		var _y = smooth_move_8way_get_y(self);
		var _slope = slope();
		var _change_y = _y - start_y;
		var _x = _slope * _change_y + start_x;
		var _result = round_towards(_x, start_x);
		return _result;
	}
}

/**
 * Get the calculated y position of the given SmoothMove8Way instance.
 *
 * @param {Struct.SmoothMove8Way} _smooth_move
 */
function smooth_move_8way_get_y(_smooth_move) {
		with (_smooth_move) {
		if (delta == 0) return start_y;
		if (!infer_y_from_x()) {
			var _mag_y = get_magnitude_y();
			var _y = start_y + _mag_y;
			var _result = round_towards(_y, start_y);
			return _result;
		}
		
		// infer y position from x
		var _x = smooth_move_8way_get_x(self);
		var _slope = slope();
		var _change_x = _x - start_x;
		var _y = _slope * _change_x + start_y;
		var _result = round_towards(_y, start_y);
		return _result;
	}
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
		if (_angle < 0) _angle = _angle % (-2*pi) + 2*pi;
		if (_angle >= 2*pi) _angle %= 2*pi;
	
		if ((_angle >= 15*pi/8) || (_angle < 1*pi/8)) _angle = 0*pi/8;
		else if ((_angle >= 1*pi/8) && (_angle < 3*pi/8)) _angle = 2*pi/8;
		else if ((_angle >= 3*pi/8) && (_angle < 5*pi/8)) _angle = 4*pi/8;
		else if ((_angle >= 5*pi/8) && (_angle < 7*pi/8)) _angle = 6*pi/8;
		else if ((_angle >= 7*pi/8) && (_angle < 9*pi/8)) _angle = 8*pi/8;
		else if ((_angle >= 9*pi/8) && (_angle < 11*pi/8)) _angle = 10*pi/8;
		else if ((_angle >= 11*pi/8) && (_angle < 13*pi/8)) _angle = 12*pi/8;
		else if ((_angle >= 13*pi/8) && (_angle < 15*pi/8)) _angle = 14*pi/8;
		
		if (angle == _angle) return;

		reset();
		angle = _angle;
	}
}

/**
 * Advances the change in distance of the given SmoothMove8Way by the given value.
 *
 * @param {Struct.SmoothMove8Way} _smooth_move
 * @param {real} _magnitude
 */
function smooth_move_8way_advance(_smooth_move, _magnitude) {
	with (_smooth_move) {
		if (_magnitude == 0) reset();
		delta += _magnitude;
	}
}

/**
 * Move the given SmoothMove8Way by the given vector.
 * 
 * @param {Struct.SmoothMove8Way} _smooth_move
 * @param {real} _angle angle in radians
 * @param {real} _magnitude magnitude of the vector
 */
function smooth_move_8way_move_by_vector(_smooth_move, _angle, _magnitude) {
	smooth_move_8way_set_angle(_smooth_move, _angle);
	smooth_move_8way_advance(_smooth_move, _magnitude);
}
