/// @description Setup
t = 0;
inactive_t = 0;
callbacks = [
	"easeInSine",
	"easeOutSine",
	"easeInOutSine",
	"easeInQuad",
	"easeOutQuad",
	"easeInOutQuad",
	"easeInCubic",
	"easeOutCubic",
	"easeInOutCubic",
	"easeInQuart",
	"easeOutQuart",
	"easeInOutQuart",
	"easeInQuint",
	"easeOutQuint",
	"easeInOutQuint",
	"easeInExpo",
	"easeOutExpo",
	"easeInOutExpo",
	"easeInCirc",
	"easeOutCirc",
	"easeInOutCirc",
	"easeInBack",
	"easeOutBack",
	"easeInOutBack",
	"easeInElastic",
	"easeOutElastic",
	"easeInOutElastic",
	"easeInBounce",
	"easeOutBounce",
	"easeInOutBounce"
];

var _callbacks_len = get_size(callbacks);
for (var i = 0; i < _callbacks_len; i++) {
	callbacks[i] = asset_get_index("anim_" + callbacks[i]);
}

surf_lines = -1;
