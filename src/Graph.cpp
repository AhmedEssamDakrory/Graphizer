#include "Graph.h"

#include <math.h>

// helper functions
inline static float
distance(float x1, float y1, float x2, float y2)
{
	float x = x2 - x1;
	float y = y2 - y1;
	return std::sqrtf(x * x + y * y);
}

// public functions
void
Graph::insertNode(int x, int y)
{
	// check that this node doesn't intersect with any of the existing nodes
	for (const auto& node : mNodes)
	{
		if (distance(x, y, node->x, node->y) < 2 * mNodeRadius)
			return;
	}

	mNodes.push_back(std::unique_ptr<Node>(new Node{x, y}));
	emit nodeInserted(x, y);
}