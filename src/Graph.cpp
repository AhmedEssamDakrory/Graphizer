#include "Graph.h"
#include "utils.h"

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

	auto id = mIDGenerator++;
	mNodes.push_back(std::unique_ptr<Node>(new Node{id, x, y}));
	auto color = generate_distinct_hsb_color(id);
	emit nodeInserted(x, y, QColor::fromHsv(color.h, color.s, color.b));
}

QVariantMap
Graph::selectNode(int x, int y)
{
	QVariantMap res{};
	res.insert("x", -1);
	res.insert("y", -1);

	auto selectedNode = getNode(x, y);
	if (selectedNode)
	{
		res.insert("x", selectedNode->x);
		res.insert("y", selectedNode->y);
	}

	return res;
}

void
Graph::connect(int x1, int y1, int x2, int y2)
{
	auto node1 = getNode(x1, y1);
	if (node1)
	{
		auto node2 = getNode(x2, y2);
		if (node2)
		{
			// connect (undirected graph edge)
			node1->neighbours.push_back(node2);
			node2->neighbours.push_back(node1);
		}
	}
}

// private functions
Node*
Graph::getNode(int x, int y)
{
	for (const auto& node : mNodes)
	{
		if (distance(x, y, node->x, node->y) <= mNodeRadius)
		{
			return node.get();
		}
	}
	return nullptr;
}