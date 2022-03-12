#pragma once

#include <Graph.h>

#include <QObject>

#include <vector>

class Driver : public QObject
{
	Q_OBJECT
	Q_PROPERTY(Graph* graph READ graph CONSTANT);

public:
	Driver(QObject* parent = nullptr) : QObject(parent) { mGraph = new Graph{this}; }

	static Driver*
	singleton()
	{
		static Driver self;
		return &self;
	}

	Graph*
	graph() const
	{
		return mGraph;
	}

private:
	Graph* mGraph;
};
