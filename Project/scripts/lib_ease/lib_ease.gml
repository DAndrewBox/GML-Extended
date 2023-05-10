/// @func	anim_easeInSine(value, min, max)
/// @param	{real}	value
/// @param	{real}	min
/// @param	{real}	max
function anim_easeInSine(_val, _min = 0, _max = 1) {
	return (_max - _min) * (1 - cos((_val * PI) / 2)) + _min;
}

/// @func	anim_easeOutSine(value, min, max)
/// @param	{real}	value
/// @param	{real}	min
/// @param	{real}	max
function anim_easeOutSine(_val, _min = 0, _max = 1) {
	return (_max - _min) * sin((_val * PI) / 2) + _min;
}

/// @func	anim_easeInOutSine(value, min, max)
/// @param	{real}	value
/// @param	{real}	min
/// @param	{real}	max
function anim_easeInOutSine(_val, _min = 0, _max = 1) {
	return (_max - _min) * (-(cos(PI * _val) - 1) / 2) + _min;
}

/// @func	anim_easeInQuad(value, min, max)
/// @param	{real}	value
/// @param	{real}	min
/// @param	{real}	max
function anim_easeInQuad(_val, _min = 0, _max = 1) {
	return (_max - _min) * _val * _val + _min;
}

/// @func	anim_easeOutQuad(value, min, max)
/// @param	{real}	value
/// @param	{real}	min
/// @param	{real}	max
function anim_easeOutQuad(_val, _min = 0, _max = 1) {
	return (_max - _min) * (1 - (1 - _val) * (1 - _val)) + _min;
}

/// @func	anim_easeInOutQuad(value, min, max)
/// @param	{real}	value
/// @param	{real}	min
/// @param	{real}	max
function anim_easeInOutQuad(_val, _min = 0, _max = 1) {
	return (_max - _min) * (
		_val < 0.5
		? 2 * _val * _val
		: 1 - power(-2 * _val + 2, 2) / 2
	) + _min;
}

/// @func	anim_easeInCubic(value, min, max)
/// @param	{real}	value
/// @param	{real}	min
/// @param	{real}	max
function anim_easeInCubic(_val, _min = 0, _max = 1) {
	return (_max - _min) * _val * _val * _val + _min;
}

/// @func	anim_easeOutCubic(value, min, max)
/// @param	{real}	value
/// @param	{real}	min
/// @param	{real}	max
function anim_easeOutCubic(_val, _min = 0, _max = 1) {
	return (_max - _min) * (1 - power(1 - _val, 3)) + _min;
}

/// @func	anim_easeInOutCubic(value, min, max)
/// @param	{real}	value
/// @param	{real}	min
/// @param	{real}	max
function anim_easeInOutCubic(_val, _min = 0, _max = 1) {
	return (_max - _min) * (
		_val < 0.5
		? (_max - _min) * (4 * power(_val, 3)) + _min
		: 1 - power(-2 * _val + 2, 3) / 2
	) + _min;
}

/// @func anim_easeInQuart(value, _min=0, _max=1)
/// @param {real} value
function anim_easeInQuart(_val, _min=0, _max=1) {
	return _min + (_max - _min) * (_val * _val * _val * _val);
}

/// @func anim_easeOutQuart(value, _min=0, _max=1)
/// @param {real} value
function anim_easeOutQuart(_val, _min=0, _max=1) {
	return _min + (_max - _min) * (1 - power(1 - _val, 4));
}

/// @func anim_easeInOutQuart(value, _min=0, _max=1)
/// @param {real} value
function anim_easeInOutQuart(_val, _min=0, _max=1) {
	return _min + (_max - _min) * (
		_val < 0.5
		? 8 * _val * _val * _val * _val
		: 1 - power(-2 * _val + 2, 4) / 2
	);
}

/// @func anim_easeInQuint(value, _min=0, _max=1)
/// @param {real} value
function anim_easeInQuint(_val, _min=0, _max=1) {
	return _min + (_max - _min) * (_val * _val * _val * _val * _val);
}

/// @func anim_easeOutQuint(value, _min=0, _max=1)
/// @param {real} value
function anim_easeOutQuint(_val, _min=0, _max=1) {
	return _min + (_max - _min) * (1 - power(1 - _val, 5));
}

/// @func anim_easeInOutQuint(value, _min=0, _max=1)
/// @param {real} value
function anim_easeInOutQuint(_val, _min=0, _max=1) {
	return _min + (_max - _min) * (
		_val < 0.5
		? 16 * _val * _val * _val * _val * _val
		: 1 - power(-2 * _val + 2, 5) / 2
	);
}

/// @func anim_easeInExpo(value, _min=0, _max=1)
/// @param {real} value
function anim_easeInExpo(_val, _min=0, _max=1) {
	return _min + (_max - _min) * (
		_val == 0
		? 0
		: power(2, 10 * _val - 10)
	);
}

/// @func anim_easeOutExpo(value, _min=0, _max=1)
/// @param {real} value
function anim_easeOutExpo(_val, _min=0, _max=1) {
	return _min + (_max - _min) * (
		_val == 1
		? 1
		: 1 - power(2, -10 * _val)
	);
}

/// @func	anim_easeInOutExpo(value, _min = 0, _max = 1)
/// @param	{real}	value
/// @param	{real}	_min
/// @param	{real}	_max
function anim_easeInOutExpo(_val, _min = 0, _max = 1) {
	return (_val == 0
		  ? _min
		  : (_val == 1
				? _max
				: (_val < 0.5 ? power(2, 20 * _val - 10) / 2 * (_max - _min) + _min : (2 - power(2, -20 * _val + 10)) / 2 * (_max - _min) + _min )
			)
		);
}

/// @func	anim_easeInCirc(value, _min = 0, _max = 1)
/// @param	{real}	value
/// @param	{real}	_min
/// @param	{real}	_max
function anim_easeInCirc(_val, _min = 0, _max = 1) {
	return 1 - sqrt(1 - power(_val, 2)) * (_max - _min) + _min;
}

/// @func	anim_easeOutCirc(value, _min = 0, _max = 1)
/// @param	{real}	value
/// @param	{real}	_min
/// @param	{real}	_max
function anim_easeOutCirc(_val, _min = 0, _max = 1) {
	return (_max - _min) * sqrt(1 - power(_val - 1, 2)) + _min;
}

/// @func	anim_easeInOutCirc(value, _min = 0, _max = 1)
/// @param	{real}	value
/// @param	{real}	_min
/// @param	{real}	_max
function anim_easeInOutCirc(_val, _min = 0, _max = 1) {
	return _val < 0.5
		? (1 - sqrt(1 - power(2 * _val, 2))) / 2 * (_max - _min) + _min
		: (sqrt(max(0, 1 - power(-2 * _val + 2, 2))) + 1) / 2 * (_max - _min) + _min;
}

/// @func	anim_easeInBack(value, _min = 0, _max = 1)
/// @param	{real}	value
/// @param	{real}	_min
/// @param	{real}	_max
function anim_easeInBack(_val, _min = 0, _max = 1) {
	static _c1 = 1.70158;
	static _c3 = _c1 + 1;

	return _c3 * _val* _val * _val - _c1 * _val * _val * (_max - _min) + _min;
}

/// @func	anim_easeOutBack(value, _min = 0, _max = 1)
/// @param	{real}	value
/// @param	{real}	_min
/// @param	{real}	_max
function anim_easeOutBack(_val, _min = 0, _max = 1) {
	static _c1 = 1.70158;
	static _c3 = _c1 + 1;

	return 1 + _c3 * power(_val - 1, 3) + _c1 * power(_val - 1, 2) * (_max - _min) + _min;
}

/// @func	anim_easeInOutBack(value, _min = 0, _max = 1)
/// @param	{real}	value
/// @param	{real}	_min
/// @param	{real}	_max
function anim_easeInOutBack(_val, _min = 0, _max = 1) {
	static _c1 = 1.70158;
	static _c2 = _c1 * 1.525;

	return _val < 0.5
		? (power(2 * _val, 2) * ((_c2 + 1) * 2 * _val - _c2)) / 2 * (_max - _min) + _min
		: (power(2 * _val - 2, 2) * ((_c2 + 1) * (2 * _val - 2) + _c2) + 2) / 2 * (_max - _min) + _min;
}

/// @func	anim_easeInElastic(value, _min = 0, _max = 1)
/// @param	{real}	value
/// @param	{real}	_min
/// @param	{real}	_max
function anim_easeInElastic(_val, _min = 0, _max = 1) {
	static _c4 = (2 * PI) / 3;

	return (_val == 0
		? _min
		: -power(2, 10 * _val - 9) * sin((_val * 10 - 10) * _c4) * (_max - _min)
		);
}

/// @func	anim_easeOutElastic(value, _min = 0, _max = 1)
/// @param	{real}	value
/// @param	{real}	_min
/// @param	{real}	_max
function anim_easeOutElastic(_val, _min = 0, _max = 1) {
	static _c4 = (2 * PI) / 3;

	return ( _val == 0
		? _min
		: ( _val == 1
			? _max
			: power(2, -10 * _val) * sin((_val * 10 - 10) * _c4) * (_max - _min) + _max
			)
		);
}

/// @func	anim_easeInOutElastic(value, _min = 0, _max = 1)
/// @param	{real}	value
/// @param	{real}	_min
/// @param	{real}	_max
function anim_easeInOutElastic(_val, _min = 0, _max = 1) {
	static _c5 = (2 * PI) / 4.5;

	return ( _val == 0
		? _min
		: ( _val == 1
			? _max
			: ( _val < 0.5
				? -(power(2, 20 * _val - 10) * sin((20 * _val - 11.125) * _c5)) / 2 * (_max - _min) + (_max + _min) / 2
				: (power(2, -20 * _val + 10) * sin((20 * _val - 11.125) * _c5)) / 2 * (_max - _min) + (_max + _min) / 2
				)
			)
		);
}

/// @func	anim_easeInBounce(value, _min = 0, _max = 1)
/// @param	{real}	value
/// @param	{real}	_min
/// @param	{real}	_max
function anim_easeInBounce(_val, _min = 0, _max = 1) {
	return 1 - anim_easeOutBounce(1 - _val, _min, _max);
}

/// @func	anim_easeOutBounce(value, _min = 0, _max = 1)
/// @param	{real}	value
/// @param	{real}	_min
/// @param	{real}	_max
function anim_easeOutBounce(_val, _min = 0, _max = 1) {
	static _n1 = 7.5625;
	static _d1 = 2.75;

	if (_val < 1 / _d1) {
	    return _n1 * _val * _val * (_max - _min) + _min;
	} else if (_val < 2 / _d1) {
	    return _n1 * (_val - 1.5 / _d1) * (_val - 1.5 / _d1) * (_max - _min) + (_max + _min);
	} else if (_val < 2.5 / _d1) {
	    return _n1 * (_val - 2.25 / _d1) * (_val - 2.25 / _d1) * (_max - _min) + (_max + _min);
	} else {
	    return _n1 * (_val - 2.625 / _d1) * (_val - 2.625 / _d1) * (_max - _min) + (_max + _min);
	}
}

/// @func	anim_easeInOutBounce(value, _min = 0, _max = 1)
/// @param	{real}	value
/// @param	{real}	_min
/// @param	{real}	_max
function anim_easeInOutBounce(_val, _min = 0, _max = 1) {
	return (_val < 0.5
		? (1 - anim_easeOutBounce(1 - 2 * _val, _min, _max)) / 2
		: (1 + anim_easeOutBounce(2 * _val - 1, _min, _max)) / 2
		);
}