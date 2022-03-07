#pragma once

#include <QObject>

#include <vector>

struct Point
{
	float x;
	float y;
};

class Driver : public QObject
{
	Q_OBJECT
public:
	Driver(QObject* parent = nullptr) : QObject(parent) {}

	static Driver*
	singleton()
	{
		static Driver self;
		return &self;
	}

	Q_INVOKABLE void
	insertNode(float x, float y);

private:
	std::vector<Point> mPoints;
};
