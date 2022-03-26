#pragma once

#include <vector>

class DSU
{
public:
	DSU(int n)
	{
		par.resize(n);

		for (int i = 0; i < n; ++i)
		{
			par[i] = i;
		}
	}

	int
	find(int u)
	{
		if (par[u] == u)
			return u;
		return par[u] = find(par[u]);
	}

	bool
	unin(int u, int v)
	{
		int p1 = find(u);
		int p2 = find(v);
		if (p1 == p2)
			return false;
		par[p1] = p2;
		return true;
	}

	bool
	sameSet(int u, int v)
	{
		return find(u) == find(v);
	}

private:
	std::vector<int> par;
};