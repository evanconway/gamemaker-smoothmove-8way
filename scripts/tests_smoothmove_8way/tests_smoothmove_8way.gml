function __tests_smoothmove_8way(){
	/**
	 * Assert function for testing real numbers in this package.
	 *
	 * @param {real} _value
	 * @param {real} _expected
	 * feather ignore once all
	 */
	var test_smooth_move_assert_real = function(_value, _expected, _msg = "Smooth move test fail!") {
		if (!is_real(_value)) show_error(_msg + $"\n Value {_value} is not a real.", true);
		if (!is_real(_expected)) show_error(_msg + $"\n Expected {_expected} is not a real.", true);
		if (is_nan(_value)) show_error(_msg + $"\n Value {_value} is not a real.", true);
		if (is_nan(_expected)) show_error(_msg + $"\n Expected {_expected} is not a real.", true);
		if (_value != _expected) show_error(_msg + $"\n Expected {_expected} got {_value}.", true);
	}
	
	// angle snapping
	var _test_angles = new SmoothMove8Way(0, 0);
	smooth_move_8way_set_angle(_test_angles, 0*pi/4);
	test_smooth_move_assert_real(_test_angles.angle, 0*pi/4, "Smooth move angle test 0*pi/4 fail!");
	smooth_move_8way_set_angle(_test_angles, 1*pi/4);
	test_smooth_move_assert_real(_test_angles.angle, 1*pi/4, "Smooth move angle test 1*pi/4 fail!");
	smooth_move_8way_set_angle(_test_angles, 2*pi/4);
	test_smooth_move_assert_real(_test_angles.angle, 2*pi/4, "Smooth move angle test 2*pi/4 fail!");
	smooth_move_8way_set_angle(_test_angles, 3*pi/4);
	test_smooth_move_assert_real(_test_angles.angle, 3*pi/4, "Smooth move angle test 3*pi/4 fail!");
	smooth_move_8way_set_angle(_test_angles, 4*pi/4);
	test_smooth_move_assert_real(_test_angles.angle, 4*pi/4, "Smooth move angle test 4*pi/4 fail!");
	smooth_move_8way_set_angle(_test_angles, 5*pi/4);
	test_smooth_move_assert_real(_test_angles.angle, 5*pi/4, "Smooth move angle test 5*pi/4 fail!");
	smooth_move_8way_set_angle(_test_angles, 6*pi/4);
	test_smooth_move_assert_real(_test_angles.angle, 6*pi/4, "Smooth move angle test 6*pi/4 fail!");
	smooth_move_8way_set_angle(_test_angles, 7*pi/4);
	test_smooth_move_assert_real(_test_angles.angle, 7*pi/4, "Smooth move angle test 7*pi/4 fail!");
	
	
	// negative and positive angles
	smooth_move_8way_set_angle(_test_angles, -11*pi);
	test_smooth_move_assert_real(_test_angles.angle, pi, "Smooth move angle test -3*pi fail!");
	smooth_move_8way_set_angle(_test_angles, 11*pi);
	test_smooth_move_assert_real(_test_angles.angle, pi, "Smooth move angle test -3*pi fail!");
	
	
	var _move_count = 1000;
	
	// north
	var _n = new SmoothMove8Way(0, 0);
	for (var _i = 0; _i < _move_count; _i++) {
		smooth_move_8way_move_by_vector(_n, 6*pi/4, 1);
	}
	test_smooth_move_assert_real(smooth_move_8way_get_x(_n), 0, "Smooth move north test 1 x fail!");
	test_smooth_move_assert_real(smooth_move_8way_get_y(_n), -1000, "Smooth move north test 1 y fail!");
	smooth_move_8way_move_by_vector(_n, 0, 0);
	test_smooth_move_assert_real(smooth_move_8way_get_x(_n), 0, "Smooth move north test 2 x fail!");
	test_smooth_move_assert_real(smooth_move_8way_get_y(_n), -1000, "Smooth move north test 2 y fail!");
	
	// south
	var _s = new SmoothMove8Way(0, 0);
	for (var _i = 0; _i < _move_count; _i++) {
		smooth_move_8way_move_by_vector(_s, 2*pi/4, 1);
	}
	test_smooth_move_assert_real(smooth_move_8way_get_x(_s), 0, "Smooth move south test 1 x fail!");
	test_smooth_move_assert_real(smooth_move_8way_get_y(_s), 1000, "Smooth move south test 1 y fail!");
	smooth_move_8way_move_by_vector(_s, 0, 0);
	test_smooth_move_assert_real(smooth_move_8way_get_x(_s), 0, "Smooth move south test 2 x fail!");
	test_smooth_move_assert_real(smooth_move_8way_get_y(_s), 1000, "Smooth move south test 2 y fail!");
	
	// east
	var _e = new SmoothMove8Way(0, 0);
	for (var _i = 0; _i < _move_count; _i++) {
		smooth_move_8way_move_by_vector(_e, 0*pi/4, 1);
	}
	test_smooth_move_assert_real(smooth_move_8way_get_x(_e), 1000, "Smooth move east test 1 x fail!");
	test_smooth_move_assert_real(smooth_move_8way_get_y(_e), 0, "Smooth move east test 1 y fail!");
	smooth_move_8way_move_by_vector(_e, 0, 0);
	test_smooth_move_assert_real(smooth_move_8way_get_x(_e), 1000, "Smooth move east test 2 x fail!");
	test_smooth_move_assert_real(smooth_move_8way_get_y(_e), 0, "Smooth move east test 2 y fail!");
	
	// west
	var _w = new SmoothMove8Way(0, 0);
	for (var _i = 0; _i < _move_count; _i++) {
		smooth_move_8way_move_by_vector(_w, 4*pi/4, 1);
	}
	test_smooth_move_assert_real(smooth_move_8way_get_x(_w), -1000, "Smooth move west test 1 x fail!");
	test_smooth_move_assert_real(smooth_move_8way_get_y(_w), 0, "Smooth move west test 1 y fail!");
	smooth_move_8way_move_by_vector(_w, 0, 0);
	test_smooth_move_assert_real(smooth_move_8way_get_x(_w), -1000, "Smooth move west test 2 x fail!");
	test_smooth_move_assert_real(smooth_move_8way_get_y(_w), 0, "Smooth move west test 2 y fail!");
	
	// north east
	var _ne = new SmoothMove8Way(0, 0);
	for (var _i = 0; _i < _move_count; _i++) {
		smooth_move_8way_move_by_vector(_ne, 7*pi/4, 1);
	}
	test_smooth_move_assert_real(smooth_move_8way_get_x(_ne), 707, "Smooth move north east test 1 x fail!");
	test_smooth_move_assert_real(smooth_move_8way_get_y(_ne), -707, "Smooth move north east test 1 y fail!");
	smooth_move_8way_move_by_vector(_ne, 0, 0);
	test_smooth_move_assert_real(smooth_move_8way_get_x(_ne), 707, "Smooth move north east test 2 x fail!");
	test_smooth_move_assert_real(smooth_move_8way_get_y(_ne), -707, "Smooth move north east test 2 y fail!");
	
	// north west
	var _nw = new SmoothMove8Way(0, 0);
	for (var _i = 0; _i < _move_count; _i++) {
		smooth_move_8way_move_by_vector(_nw, 5*pi/4, 1);
	}
	test_smooth_move_assert_real(smooth_move_8way_get_x(_nw), -707, "Smooth move north west test 1 x fail!");
	test_smooth_move_assert_real(smooth_move_8way_get_y(_nw), -707, "Smooth move north west test 1 y fail!");
	smooth_move_8way_move_by_vector(_nw, 0, 0);
	test_smooth_move_assert_real(smooth_move_8way_get_x(_nw), -707, "Smooth move north west test 2 x fail!");
	test_smooth_move_assert_real(smooth_move_8way_get_y(_nw), -707, "Smooth move north west test 2 y fail!");
	
	// south east
	var _se = new SmoothMove8Way(0, 0);
	for (var _i = 0; _i < _move_count; _i++) {
		smooth_move_8way_move_by_vector(_se, 1*pi/4, 1);
	}
	test_smooth_move_assert_real(smooth_move_8way_get_x(_se), 707, "Smooth move south east test 1 x fail!");
	test_smooth_move_assert_real(smooth_move_8way_get_y(_se), 707, "Smooth move south east test 1 y fail!");
	smooth_move_8way_move_by_vector(_se, 0, 0);
	test_smooth_move_assert_real(smooth_move_8way_get_x(_se), 707, "Smooth move south east test 2 x fail!");
	test_smooth_move_assert_real(smooth_move_8way_get_y(_se), 707, "Smooth move south east test 2 y fail!");
	
	// south west
	var _sw = new SmoothMove8Way(0, 0);
	for (var _i = 0; _i < _move_count; _i++) {
		smooth_move_8way_move_by_vector(_sw, 3*pi/4, 1);
	}
	test_smooth_move_assert_real(smooth_move_8way_get_x(_sw), -707, "Smooth move south west test 1 x fail!");
	test_smooth_move_assert_real(smooth_move_8way_get_y(_sw), 707, "Smooth move south west test 1 y fail!");
	smooth_move_8way_move_by_vector(_sw, 0, 0);
	test_smooth_move_assert_real(smooth_move_8way_get_x(_sw), -707, "Smooth move south west test 2 x fail!");
	test_smooth_move_assert_real(smooth_move_8way_get_y(_sw), 707, "Smooth move south west test 2 y fail!");
}

__tests_smoothmove_8way();
