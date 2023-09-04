camera_init_basic(room_width, room_height, 5);

camera_init_basic(200, 112, 10);
smooth_move = new SmoothMove8Way(x, y);
//game_set_speed(240, gamespeed_fps);

create_positions = function() {
	return array_create(10000, [smooth_move_8way_get_x(smooth_move), smooth_move_8way_get_y(smooth_move)]);
};

positions = create_positions();
positions_index = 0;


stick = gamepad_get_left_stick_data();
stick_mag = sqrt(sqr(stick.axis_h) + sqr(stick.axis_v));
stick_angle = arctan2(stick.axis_v, stick.axis_h) + pi/2;
