#region Sine
/// @func	anim_easeInSine(value, factor)
/// @param	{Real}	value	The value to animate.
/// @param	{Real}	factor	The factor of the animation. (Default: 1)
function anim_easeInSine(_val, _factor = 1) {
	return _factor * (1 - cos((_val * pi) / 2));
}

/// @func	anim_easeOutSine(value, factor)
/// @param	{Real}	value	The value to animate.
/// @param	{Real}	factor	The factor of the animation. (Default: 1)
function anim_easeOutSine(_val, _factor = 1) {
	return _factor * sin((_val * pi) / 2);
}

/// @func	anim_easeInOutSine(value, factor)
/// @param	{Real}	value	The value to animate.
/// @param	{Real}	factor	The factor of the animation. (Default: 1)
function anim_easeInOutSine(_val, _factor = 1) {
	return _factor * (-(cos(pi * _val) - 1) / 2);
}
#endregion

#region Quad
/// @func	anim_easeInQuad(value, factor)
/// @param	{Real}	value	The value to animate.
/// @param	{Real}	factor	The factor of the animation. (Default: 1)
function anim_easeInQuad(_val, _factor = 1) {
	return _factor * _val * _val;
}

/// @func	anim_easeOutQuad(value, factor)
/// @param	{Real}	value	The value to animate.
/// @param	{Real}	factor	The factor of the animation. (Default: 1)
function anim_easeOutQuad(_val, _factor = 1) {
	return _factor * (1 - (1 - _val) * (1 - _val));
}

/// @func	anim_easeInOutQuad(value, factor)
/// @param	{Real}	value	The value to animate.
/// @param	{Real}	factor	The factor of the animation. (Default: 1)
function anim_easeInOutQuad(_val, _factor = 1) {
	return _factor * (
		_val < 0.5
		? 2 * _val * _val
		: 1 - power(-2 * _val + 2, 2) / 2
	);
}
#endregion

#region Cubic
/// @func	anim_easeInCubic(value, factor)
/// @param	{Real}	value	The value to animate.
/// @param	{Real}	factor	The factor of the animation. (Default: 1)
function anim_easeInCubic(_val, _factor = 1) {
	return _factor * _val * _val * _val;
}

/// @func	anim_easeOutCubic(value, factor)
/// @param	{Real}	value	The value to animate.
/// @param	{Real}	factor	The factor of the animation. (Default: 1)
function anim_easeOutCubic(_val, _factor = 1) {
	return _factor * (1 - power(1 - _val, 3));
}

/// @func	anim_easeInOutCubic(value, factor)
/// @param	{Real}	value	The value to animate.
/// @param	{Real}	factor	The factor of the animation. (Default: 1)
function anim_easeInOutCubic(_val, _factor = 1) {
	return _factor * (
		_val < 0.5
		? 4 * power(_val, 3)
		: 1 - power(-2 * _val + 2, 3) / 2
	);
}
#endregion

#region Quart
/// @func anim_easeInQuart(value, factor)
/// @param	{Real}	value	The value to animate.
/// @param	{Real}	factor	The factor of the animation. (Default: 1)
function anim_easeInQuart(_val, _factor = 1) {
	return _factor * (_val * _val * _val * _val);
}

/// @func anim_easeOutQuart(value, factor)
/// @param	{Real}	value	The value to animate.
/// @param	{Real}	factor	The factor of the animation. (Default: 1)
function anim_easeOutQuart(_val, _factor = 1) {
	return _factor * (1 - power(1 - _val, 4));
}

/// @func anim_easeInOutQuart(value, factor)
/// @param	{Real}	value	The value to animate.
/// @param	{Real}	factor	The factor of the animation. (Default: 1)
function anim_easeInOutQuart(_val, _factor = 1) {
	return _factor * (
		_val < 0.5
		? 8 * _val * _val * _val * _val
		: 1 - power(-2 * _val + 2, 4) / 2
	);
}
#endregion

#region Quint
/// @func anim_easeInQuint(value, factor)
/// @param	{Real}	value	The value to animate.
/// @param	{Real}	factor	The factor of the animation. (Default: 1)
function anim_easeInQuint(_val, _factor = 1) {
	return _factor * (_val * _val * _val * _val * _val);
}

/// @func anim_easeOutQuint(value, factor)
/// @param	{Real}	value	The value to animate.
/// @param	{Real}	factor	The factor of the animation. (Default: 1)
function anim_easeOutQuint(_val, _factor = 1) {
	return _factor * (1 - power(1 - _val, 5));
}

/// @func anim_easeInOutQuint(value, factor)
/// @param	{Real}	value	The value to animate.
/// @param	{Real}	factor	The factor of the animation. (Default: 1)
function anim_easeInOutQuint(_val, _factor = 1) {
	return _factor * (
		_val < 0.5
		? 16 * _val * _val * _val * _val * _val
		: 1 - power(-2 * _val + 2, 5) / 2
	);
}
#endregion

#region Exponential
/// @func anim_easeInExpo(value, factor)
/// @param	{Real}	value	The value to animate.
/// @param	{Real}	factor	The factor of the animation. (Default: 1)
function anim_easeInExpo(_val, _factor = 1) {
	return _factor * (
		_val == 0
		? 0
		: power(2, 10 * _val - 10)
	);
}

/// @func anim_easeOutExpo(value, factor)
/// @param	{Real}	value	The value to animate.
/// @param	{Real}	factor	The factor of the animation. (Default: 1)
function anim_easeOutExpo(_val, _factor = 1) {
	return _factor * (
		_val == 1
		? 1
		: 1 - power(2, -10 * _val)
	);
}

/// @func anim_easeInOutExpo(value, factor)
/// @param	{Real}	value	The value to animate.
/// @param	{Real}	factor	The factor of the animation. (Default: 1)
function anim_easeInOutExpo(_val, _factor = 1) {
	return _val == 0
		? 0
		: (_val == 1
			? _factor
			: (_val < 0.5 ? power(2, 20 * _val - 10) / 2 * _factor : (2 - power(2, -20 * _val + 10)) / 2 * _factor)
		);
}
#endregion

#region Circ
/// @func anim_easeInCirc(value, factor)
/// @param	{Real}	value	The value to animate.
/// @param	{Real}	factor	The factor of the animation. (Default: 1)
function anim_easeInCirc(_val, _factor = 1) {
	return _factor * (1 - sqrt(1 - power(_val, 2)));
}

/// @func anim_easeOutCirc(value, factor)
/// @param	{Real}	value	The value to animate.
/// @param	{Real}	factor	The factor of the animation. (Default: 1)
function anim_easeOutCirc(_val, _factor = 1) {
	return _factor * sqrt(1 - power(_val - 1, 2));
}

/// @func anim_easeInOutCirc(value, factor)
/// @param	{Real}	value	The value to animate.
/// @param	{Real}	factor	The factor of the animation. (Default: 1)
function anim_easeInOutCirc(_val, _factor = 1) {
	return _val < 0.5
		? _factor * (1 - sqrt(1 - power(2 * _val, 2))) / 2
		: _factor * (sqrt(max(0, 1 - power(-2 * _val + 2, 2))) + 1) / 2;
}
#endregion

#region Back
/// @func anim_easeInBack(value, factor)
/// @param	{Real}	value	The value to animate.
/// @param	{Real}	factor	The factor of the animation. (Default: 1)
function anim_easeInBack(_val, _factor = 1) {
	static _c1 = 1.70158;
	static _c3 = _c1 + 1;

	return _factor * (_c3 * _val * _val * _val - _c1 * _val * _val);
}

/// @func anim_easeOutBack(value, factor)
/// @param	{Real}	value	The value to animate.
/// @param	{Real}	factor	The factor of the animation. (Default: 1)
function anim_easeOutBack(_val, _factor = 1) {
	static _c1 = 1.70158;
	static _c3 = _c1 + 1;

	return _factor * (1 + _c3 * power(_val - 1, 3) + _c1 * power(_val - 1, 2));
}

/// @func anim_easeInOutBack(value, factor)
/// @param	{Real}	value	The value to animate.
/// @param	{Real}	factor	The factor of the animation. (Default: 1)
function anim_easeInOutBack(_val, _factor = 1) {
	static _c1 = 1.70158;
	static _c2 = _c1 * 1.525;

	return _val < 0.5
		? _factor * (power(2 * _val, 2) * ((_c2 + 1) * 2 * _val - _c2)) / 2
		: _factor * (power(2 * _val - 2, 2) * ((_c2 + 1) * (2 * _val - 2) + _c2) + 2) / 2;
}
#endregion

#region Elastic
/// @func anim_easeInElastic(value, factor)
/// @param	{Real}	value	The value to animate.
/// @param	{Real}	factor	The factor of the animation. (Default: 1)
function anim_easeInElastic(_val, _factor = 1) {
	static _c4 = (2 * pi) / 3;

	return _factor * (
		_val == 0
		? 0
		: -power(2, 10 * _val - 9) * sin((_val * 10 - 10) * _c4)
	);
}

/// @func anim_easeOutElastic(value, factor)
/// @param	{Real}	value	The value to animate.
/// @param	{Real}	factor	The factor of the animation. (Default: 1)
function anim_easeOutElastic(_val, _factor = 1) {
	static _c4 = (2 * pi) / 3;

	return _factor * (
		_val == 0
		? 0
		: (_val == 1
			? 1
			: power(2, -10 * _val) * sin((_val * 10 - 10) * _c4) + 1
		)
	);
}

/// @func anim_easeInOutElastic(value, factor)
/// @param	{Real}	value	The value to animate.
/// @param	{Real}	factor	The factor of the animation. (Default: 1)
function anim_easeInOutElastic(_val, _factor = 1) {
	static _c5 = (2 * pi) / 4.5;

	return _factor * (
		_val == 0
		? 0
		: (_val == 1
			? 1
			: (_val < 0.5
				? -(power(2, 20 * _val - 10) * sin((20 * _val - 11.125) * _c5)) / 2 + 0.5
				: (power(2, -20 * _val + 10) * sin((20 * _val - 11.125) * _c5)) / 2 + 0.5
			)
		)
	);
}
#endregion

#region Bounce
/// @func anim_easeInBounce(value, factor)
/// @param	{Real}	value	The value to animate.
/// @param	{Real}	factor	The factor of the animation. (Default: 1)
function anim_easeInBounce(_val, _factor = 1) {
	return 1 - anim_easeOutBounce(1 - _val, _factor);
}

/// @func anim_easeOutBounce(value, factor)
/// @param	{Real}	value	The value to animate.
/// @param	{Real}	factor	The factor of the animation. (Default: 1)
function anim_easeOutBounce(_val, _factor = 1) {
	static _n1 = 7.5625;
	static _d1 = 2.75;

	if (_val < 1 / _d1) {
		return _factor * (_n1 * _val * _val);
	} else if (_val < 2 / _d1) {
		return _factor * (_n1 * (_val - 1.5 / _d1) * (_val - 1.5 / _d1) + 0.75);
	} else if (_val < 2.5 / _d1) {
		return _factor * (_n1 * (_val - 2.25 / _d1) * (_val - 2.25 / _d1) + 0.9375);
	} else {
		return _factor * (_n1 * (_val - 2.625 / _d1) * (_val - 2.625 / _d1) + 0.984375);
	}
}

/// @func anim_easeInOutBounce(value, factor)
/// @param	{Real}	value	The value to animate.
/// @param	{Real}	factor	The factor of the animation. (Default: 1)
function anim_easeInOutBounce(_val, _factor = 1) {
	return _val < 0.5
		? (1 - anim_easeOutBounce(1 - 2 * _val, _factor)) / 2
		: (1 + anim_easeOutBounce(2 * _val - 1, _factor)) / 2;
}
#endregion
