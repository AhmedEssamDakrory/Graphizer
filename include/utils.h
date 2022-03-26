#pragma once

#include <stdint.h>

struct HSBColor
{
	int h;
	int s;
	int b;
};

inline static HSBColor
generate_distinct_hsb_color(uint32_t id)
{
	constexpr int hueFactor = 20;
	int hue = (id * hueFactor) % 255;

	HSBColor color{};
	color.s = 175;
	color.b = 175;
	color.h = hue;

	return color;
}