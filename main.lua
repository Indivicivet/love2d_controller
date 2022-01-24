function love.load()
	W = 1280
	H = 720
	love.window.setMode(W, H)
	love.window.setTitle("Joystick Test")
	
	font_size_big = H * 0.05
	font_big = love.graphics.newFont(font_size_big)
	
	joy = love.joystick.getJoysticks()[1]
end


function love.gamepadpressed(joystick, button)
	last_pressed = button
end


function draw_controller_state(w, h, x0, y0)
	love.graphics.push()
	love.graphics.translate(x0 or 0, y0 or 0)
	
	
	text_scale = math.min(math.min(h, w) / (20 * font_size_big), 1)
	love.graphics.print(
		"last pressed: " .. (last_pressed or "none"),
		font_big, w * 0.25, h * 0.05,
		0, text_scale, text_scale
	)
	
	
	joy_boxr = h * 0.1
	joy_stickr = h * 0.035
	joy_dotr = h * 0.005
	leftjoy_x0 = w * 0.3
	leftjoy_y0 = h * 0.75
	love.graphics.rectangle(
		"line",
		leftjoy_x0 - joy_boxr, leftjoy_y0 - joy_boxr,
		2 * joy_boxr, 2 * joy_boxr
	)
	leftjoy_x = leftjoy_x0 + joy_boxr * joy:getAxis(1)
	leftjoy_y = leftjoy_y0 + joy_boxr * joy:getAxis(2)
	love.graphics.circle(
		joy:isGamepadDown("leftstick") and "fill" or "line",
		leftjoy_x, leftjoy_y, joy_stickr
	)
	love.graphics.circle("fill", leftjoy_x, leftjoy_y, joy_dotr)
	
	rightjoy_x0 = w - leftjoy_x0
	rightjoy_y0 = leftjoy_y0
	love.graphics.rectangle(
		"line",
		rightjoy_x0 - joy_boxr, rightjoy_y0 - joy_boxr,
		2 * joy_boxr, 2 * joy_boxr
	)
	rightjoy_x = rightjoy_x0 + joy_boxr * joy:getAxis(3)
	rightjoy_y = rightjoy_y0 + joy_boxr * joy:getAxis(4)
	love.graphics.circle(
		joy:isGamepadDown("rightstick") and "fill" or "line",
		rightjoy_x, rightjoy_y, joy_stickr
	)
	love.graphics.circle("fill", rightjoy_x, rightjoy_y, joy_dotr)
	
	
	trig_boxwr = h * 0.1
	trig_boxhr = h * 0.06
	lefttrig_x0 = leftjoy_x0
	lefttrig_y0 = h * 0.2
	love.graphics.rectangle(
		"line",
		lefttrig_x0 - trig_boxwr, lefttrig_y0 - trig_boxhr,
		2 * trig_boxwr, 2 * trig_boxhr
	)
	amount_lefttrig = (1 + joy:getAxis(5)) / 2
	love.graphics.rectangle(
		"fill",
		lefttrig_x0 - trig_boxwr, lefttrig_y0 + trig_boxhr * (1 - 2 * amount_lefttrig),
		2 * trig_boxwr, 2 * trig_boxhr * amount_lefttrig
	)
	
	
	righttrig_x0 = w - lefttrig_x0
	righttrig_y0 = lefttrig_y0
	love.graphics.rectangle(
		"line",
		righttrig_x0 - trig_boxwr, righttrig_y0 - trig_boxhr,
		2 * trig_boxwr, 2 * trig_boxhr
	)
	amount_righttrig = (1 + joy:getAxis(6)) / 2
	love.graphics.rectangle(
		"fill",
		righttrig_x0 - trig_boxwr, righttrig_y0 + trig_boxhr * (1 - 2 * amount_righttrig),
		2 * trig_boxwr, 2 * trig_boxhr * amount_righttrig
	)
	
	shoulder_boxwr = trig_boxwr
	shoulder_boxhr = h * 0.02
	leftshoulder_x0 = lefttrig_x0
	leftshoulder_y0 = h * 0.3
	love.graphics.rectangle(
		joy:isGamepadDown("leftshoulder") and "fill" or "line",
		leftshoulder_x0 - shoulder_boxwr, leftshoulder_y0 - shoulder_boxhr,
		2 * shoulder_boxwr, 2 * shoulder_boxhr
	)
	
	rightshoulder_x0 = w - leftshoulder_x0
	rightshoulder_y0 = leftshoulder_y0
	love.graphics.rectangle(
		joy:isGamepadDown("rightshoulder") and "fill" or "line",
		rightshoulder_x0 - shoulder_boxwr, rightshoulder_y0 - shoulder_boxhr,
		2 * shoulder_boxwr, 2 * shoulder_boxhr
	)
	
	
	dpad_x0 = w * 0.3
	dpad_y0 = h * 0.5
	dpad_boxh = h * 0.048
	dpad_boxw = h * 0.072
	dpad_sep = dpad_boxh / 2 + h * 0.018
	love.graphics.rectangle(
		joy:isGamepadDown("dpright") and "fill" or "line",
		dpad_x0 + dpad_sep,
		dpad_y0 - dpad_boxh / 2,
		dpad_boxw, dpad_boxh
	)
	love.graphics.rectangle(
		joy:isGamepadDown("dpleft") and "fill" or "line",
		dpad_x0 - dpad_boxw - dpad_sep,
		dpad_y0 - dpad_boxh / 2,
		dpad_boxw, dpad_boxh
	)
	love.graphics.rectangle(
		joy:isGamepadDown("dpdown") and "fill" or "line",
		dpad_x0 - dpad_boxh / 2,
		dpad_y0 + dpad_sep,
		dpad_boxh, dpad_boxw
	)
	love.graphics.rectangle(
		joy:isGamepadDown("dpup") and "fill" or "line",
		dpad_x0 - dpad_boxh / 2,
		dpad_y0 - dpad_boxw - dpad_sep,
		dpad_boxh, dpad_boxw
	)
	
	
	buttons_x0 = w - dpad_x0
	buttons_y0 = dpad_y0
	buttons_sep = h * 0.08
	buttons_r = h * 0.045
	love.graphics.circle(
		joy:isGamepadDown("a") and "fill" or "line",
		buttons_x0, buttons_y0 - buttons_sep,
		buttons_r
	)
	love.graphics.circle(
		joy:isGamepadDown("b") and "fill" or "line",
		buttons_x0 + buttons_sep, buttons_y0,
		buttons_r
	)
	love.graphics.circle(
		joy:isGamepadDown("x") and "fill" or "line",
		buttons_x0 - buttons_sep, buttons_y0,
		buttons_r
	)
	love.graphics.circle(
		joy:isGamepadDown("y") and "fill" or "line",
		buttons_x0, buttons_y0 + buttons_sep,
		buttons_r
	)
	
	
	backstart_boxwr = h * 0.03
	backstart_boxhr = h * 0.06
	back_x0 = w * 0.4
	back_y0 = h * 0.4
	love.graphics.rectangle(
		joy:isGamepadDown("back") and "fill" or "line",
		back_x0 - backstart_boxwr, back_y0 - backstart_boxhr,
		backstart_boxwr, backstart_boxhr
	)
	start_x0 = w - back_x0
	start_y0 = back_y0
	love.graphics.rectangle(
		joy:isGamepadDown("start") and "fill" or "line",
		start_x0 - backstart_boxwr, start_y0 - backstart_boxhr,
		backstart_boxwr, backstart_boxhr
	)
	
	love.graphics.pop()
end


function love.draw()
	draw_controller_state(W, H)
	-- can go more compact by taking W <= H:
	--draw_controller_state(W * 0.5, H, W * 0.25)
end
