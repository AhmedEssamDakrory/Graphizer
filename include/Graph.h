#pragma once

#include <QObject>
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

signals:
	void
	nodeInserted(int x, int y);

private:
	int mNodeRadius = 20;
	std::vector<std::unique_ptr<Node>> mNodes;
};