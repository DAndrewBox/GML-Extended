/// @description Setup
t = 0;
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

for (var i = 0; i < size(callbacks); i++) {
	callbacks[i] = asset_get_index("anim_" + callbacks[i]);
}