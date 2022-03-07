#include "Driver.h"

void
Driver::insertNode(float x, float y)
{
	Point node{x, y};
	mPoints.push_back(node);
}