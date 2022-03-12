#pragma once

#include <QObject>
#include <QVariantMap>

#include <unordered_map>
#include <vector>

struct Node
{
	int x;
	int y;
	std::vector<Node*> neighbours;
};

class Graph : public QObject
{
	Q_OBJECT

public:
	Graph(QObject* parent) : QObject(parent) {}

	Q_INVOKABLE void
	insertNode(int x, int y);

	Q_INVOKABLE QVariantMap
	selectNode(int x, int y);

	Q_INVOKABLE void
	connect(int x1, int y1, int x2, int y2);

signals:
	void
	nodeInserted(int x, int y);

private:
	// utility functions
	Node*
	getNode(int x, int y);

	int mNodeRadius = 20;
	std::vector<std::unique_ptr<Node>> mNodes;
};