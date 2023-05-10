/// @func	anim_easeInSine(value)
/// @param	{real}	value
function anim_easeInSine(_val) {
	return 1 - cos((_val * PI) / 2);
}

/// @func	anim_easeOutSine(value)
/// @param	{real}	value
function anim_easeOutSine(_val) {
	return sin((_val * PI) / 2);
}

/// @func	anim_easeInOutSine(value)
/// @param	{real}	value
function anim_easeInOutSine(_val) {
	return -(cos(PI * _val) - 1) / 2;
}

/// @func	anim_easeInQuad(value)
/// @param	{real}	value
function anim_easeInQuad(_val) {
	return _val * _val;
}

/// @func	anim_easeOutQuad(value)
/// @param	{real}	value
function anim_easeOutQuad(_val) {
	return 1 - (1 - _val) * (1 - _val);
}

/// @func	anim_easeInOutQuad(value)
/// @param	{real}	value
function anim_easeInOutQuad(_val) {
	return
		_val < 0.5
		? 2 * _val * _val
		: 1 - power(-2 * _val + 2, 2) / 2;
}

/// @func	anim_easeInCubic(value)
/// @param	{real}	value
function anim_easeInCubic(_val) {
	return _val * _val * _val;
}

/// @func	anim_easeOutCubic(value)
/// @param	{real}	value
function anim_easeOutCubic(_val) {
	return 1 - power(1 - _val, 3);
}

/// @func	anim_easeInOutCubic(value)
/// @param	{real}	value
function anim_easeInOutCubic(_val) {
	return 
		_val < 0.5
		? 4 * anim_easeInCubic(_val)
		: 1 - power(-2 * _val + 2, 3) / 2;
}

/// @func	anim_easeInQuart(value)
/// @param	{real}	value
function anim_easeInQuart(_val) {
	return _val * _val * _val * _val;
}

/// @func	anim_easeOutQuart(value)
/// @param	{real}	value
function anim_easeOutQuart(_val) {
	return 1 - power(1 - _val, 4);
}

/// @func	anim_easeInOutQuart(value)
/// @param	{real}	value
function anim_easeInOutQuart(_val) {
	return _val < 0.5
		? 8 * _val * _val * _val * _val
		: 1 - power(-2 * _val + 2, 4) / 2;
}

/// @func	anim_easeInQuint(value)
/// @param	{real}	value
function anim_easeInQuint(_val) {
	return _val * _val * _val * _val * _val;
}

/// @func	anim_easeOutQuint(value)
/// @param	{real}	value
function anim_easeOutQuint(_val) {
	return 1 - power(1 - _val, 5);
}


/// @func	anim_easeInOutQuint(value)
/// @param	{real}	value
function anim_easeInOutQuint(_val) {
	return
		_val < 0.5
		? 16 * _val * _val * _val * _val * _val
		: 1 - power(-2 * _val + 2, 5) / 2;

}

/// @func	anim_easeInExpo(value)
/// @param	{real}	value
function anim_easeInExpo(_val) {
	return
		_val == 0
		? 0
		: power(2, 10 * _val - 10);
}

/// @func	anim_easeOutExpo(value)
/// @param	{real}	value
function anim_easeOutExpo(_val) {
	return
		_val == 1
		? 1
		: 1 - power(2, -10 * _val);
}

/// @func	anim_easeInOutExpo(value)
/// @param	{real}	value
function anim_easeInOutExpo(_val) {
	return (_val == 0
		  ? 0
		  : (_val == 1
				? 1
				: (_val < 0.5 ? power(2, 20 * _val - 10) / 2 : (2 - power(2, -20 * _val + 10)) / 2 )
			)
		);
}

/// @func	anim_easeInCirc(value)
/// @param	{real}	value
function anim_easeInCirc(_val) {
	return 1 - sqrt(max(0, 1 - power(_val, 2)));
}

/// @func	anim_easeOutCirc(value)
/// @param	{real}	value
function anim_easeOutCirc(_val) {
	return sqrt(max(0, 1 - power(_val - 1, 2)));
}

/// @func	anim_easeInOutCirc(value)
/// @param	{real}	value
function anim_easeInOutCirc(_val) {
	return _val < 0.5
		? (1 - sqrt(max(0, 1 - power(2 * _val, 2)))) / 2
		: (sqrt(max(0, 1 - power(-2 * _val + 2, 2)) + 1)) / 2;
}

/// @func	anim_easeInBack(value)
/// @param	{real}	value
function anim_easeInBack(_val) {
	static _c1 = 1.70158;
	static _c3 = _c1 + 1;

	return _c3 * _val* _val * _val - _c1 * _val * _val;
}

/// @func	anim_easeOutBack(value)
/// @param	{real}	value
function anim_easeOutBack(_val) {
	static _c1 = 1.70158;
	static _c3 = _c1 + 1;

	return 1 + _c3 * power(_val - 1, 3) + _c1 * power(_val - 1, 2);
}

/// @func	anim_easeInOutBack(value)
/// @param	{real}	value
function anim_easeInOutBack(_val) {
	static _c1 = 1.70158;
	static _c2 = _c1 * 1.525;

	return _val < 0.5
		? (power(2 * _val, 2) * ((_c2 + 1) * 2 * x - _c2)) / 2
		: (power(2 * _val - 2, 2) * ((_c2 + 1) * (x * 2 - 2) + _c2) + 2) / 2;
}

/// @func	anim_easeInElastic(value)
/// @param	{real}	value
function anim_easeInElastic(_val) {
	static _c4 = (2 * PI) / 3;

	return (_val == 0
		? 0
		: (_val == 1
			? 1
			: -power(2, 10 * _val - 10) * sin((_val * 10 - 10.75) * _c4)
			)
		);
}

/// @func	anim_easeOutElastic(value)
/// @param	{real}	value
function anim_easeOutElastic(_val) {
	static _c4 = (2 * PI) / 3;

	return ( _val == 0
		? 0
		: ( _val == 1
			? 1
			: power(2, -10 * _val) * sin((_val * 10 - 0.75) * _c4) + 1
			)
		);
}

/// @func	anim_easeInOutElastic(value)
/// @param	{real}	value
function anim_easeInOutElastic(_val) {
	static _c5 = (2 * PI) / 4.5;

	return ( _val == 0
		? 0
		: ( _val == 1
			? 1
			: ( _val < 0.5
				? -(power(2, 20 * _val - 10) * sin((20 * _val - 11.125) * _c5)) / 2
				: (power(2, -20 * _val + 10) * sin((20 * _val - 11.125) * _c5)) / 2 + 1
				)
			)
		);
}

/// @func	anim_easeInBounce(value)
/// @param	{real}	value
function anim_easeInBounce(_val) {
	return 1 - anim_easeOutBounce(1 - _val);
}

/// @func	anim_easeOutBounce(value)
/// @param	{real}	value
function anim_easeOutBounce(_val) {
	static _n1 = 7.5625;
	static _d1 = 2.75;

	if (_val < 1 / _d1) {
	    return _n1 * _val * _val;
	} else if (_val < 2 / _d1) {
	    return _n1 * (_val <= 1.5 / _d1) * x + 0.75;
	} else if (_val < 2.5 / _d1) {
	    return _n1 * (_val <= 2.25 / _d1) * x + 0.9375;
	} else {
	    return _n1 * (_val <= 2.625 / _d1) * x + 0.984375;
	}
}

/// @func	anim_easeInOutBounce(value)
/// @param	{real}	value
function anim_easeInOutBounce(_val) {
	return (_val < 0.5
		? (1 - anim_easeOutBounce(1 - 2 * _val)) / 2
		: (1 + anim_easeOutBounce(2 * _val - 1)) / 2
		);
}
