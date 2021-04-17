#include <iostream>
#include <fstream>
#include <vector>
#include <chrono>
#include <algorithm>

using namespace std;
using namespace std::chrono;

ifstream f("date.in");
ofstream g("date.out");

int nr_teste, t;
long long n ,vmax;

/// Functii utilitare

//Generarea unui vector random
void generator_test(vector<long long> &v, long long n, long long vmax)
{
    int i;

    v.clear();

    for (i = 0; i < n; i++)
    {
        v.push_back((rand()) % vmax + 1);
    }
}

//Verificare daca vectorul este sortat
bool verificare(vector<long long> v, long long n)
{
    for(int i = 0; i < n-1; ++i)
        if(v[i] > v[i+1])
            return false;

    return true;
}

//Determinare val maxima din vector
long long maxim(vector<long long> v, long long n)
{
    long long vmax, i;

    vmax = 0;

    for (i = 0; i < n; i++)
        if (v[i] > vmax)
            vmax = v[i];
    return vmax;
}

//Determinare numar cifre ale unui numara
int nr_cifre(long long k)
{
	int c = 0;
	while(k) {
		c++;
		k /= 10;
	}
	return c;
}

//Interclasare
void interclasare(vector<long long>& v, int st, int dr) {
	int i, j, mid;
	vector<long long> a;

	mid = (st + dr) / 2;
	i = st;
	j = mid +1;

	while (i <= mid && j <= dr)
    {
		if (v[i] < v[j])
			{
			    a.push_back(v[i]);
                i++;
			}
		else
			{
			    a.push_back(v[j]);
                j++;
			}
	}

	while (i <= mid)
		{
		    a.push_back(v[i]);
            i++;
		}
	while (j <= dr)
		{
		    a.push_back(v[j]);
            j++;
		}

	for (i = st; i <= dr; i++)
		v[i] = a[i - st];
}


///Sortari

//Bubble Sort
void bubble_sort(vector<long long>& v, long long n)
{
    bool ok;
    do
    {
        ok = 1;
        for(int i = 0; i < n-1; ++i)
            if(v[i] > v[i+1])
            {
                swap(v[i], v[i+1]);
                ok = 0;
            }
    } while(!ok);
}

//Merge Sort
void merge_sort(vector<long long> &v, int st, int dr)
{
    if(dr > st)
    {
        int mid;

        mid = (st+dr)/2;

        merge_sort(v, st, mid);
        merge_sort(v, mid+1, dr);

        interclasare(v, st, dr);
    }
}

//Count Sort
void count_sort(vector<long long> &v, long long n, long long vmax)
{
    int ap[vmax+1], i;
    vector<long long> aux;

    for(i = 0; i <= vmax; i++)
        ap[i] = 0;

    for(i = 0; i < n; i++)
        if(v[i] >= 0)
            ap[v[i]]++;
        else
            return;

    for(i = 0; i <= vmax; i++)
        while(ap[i]--)
            aux.push_back(i);

    v = aux;
}

//Quick Sort
void quick_sort(vector<long long> &v, int st, int dr)
{
    int i, j, x;

    x = v[rand()% (dr-st+1) + st];
    i = st;
    j = dr;

    while(i < j)
    {
        while(v[i] < x)
            i++;

        while(v[j] > x)
            j--;

        if(i <= j)
            swap(v[i++], v[j--]);
    }
    if(j > st)
        quick_sort(v, st, j);

    if(i < dr)
        quick_sort(v, i, dr);
}

//Radix Sort
void radix_sort(vector<long long> &v, long long n)
{
	int i, cifre, cif, poz;
	long long vmax, k, p;
	vector<long long> l[10];

	vmax = maxim(v, n);
	cifre = nr_cifre(vmax);
	p = 1;

	for (k = 0; k < cifre; k++)
    {
        for (i = 0; i < n; i++)
        {
            cif = (v[i] % (p * 10)) / p;
            l[cif].push_back(v[i]);
        }

        poz = 0;
		for (i = 0; i <= 9; i++)
		{
			for (unsigned int k = 0; k < l[i].size(); k++)
                v[poz++] = l[i][k];
			l[i].clear();
		}
		p *= 10;
	}

}

int main()
{
    f >> nr_teste;

    for(t = 1; t <= nr_teste; t++)
    {
        //citire date
        f >> n >> vmax;

        g << "Testul " << t << ": n = " << n << " si maxiumul = " << vmax << endl << endl;

        //generare vector
        vector<long long> v, sortat;

        generator_test(v, n, vmax);

        //Bubble Sort
        g << "Bubble Sort: ";

        sortat.clear();
        sortat = v;

        if(n >= 10000)
            g << "FAIL\n" << endl;
        else
        {
            auto start = high_resolution_clock::now();
            bubble_sort(sortat, n);
            auto stop = high_resolution_clock::now();

            if(verificare(sortat, n) == true)
            {
                auto duration = duration_cast<milliseconds>(stop-start);
                g << duration.count() << " ms\n" << endl;
            }
            else
                g << "Fail\n" << endl;
        }

        //Merge Sort
        g << "Merge Sort: ";

        sortat.clear();
        sortat = v;

        if(n >= 10000000)
            g << "FAIL\n" << endl;
        else
        {
            auto start = high_resolution_clock::now();
            merge_sort(sortat, 0, n-1);
            auto stop = high_resolution_clock::now();

            if(verificare(sortat, n) == true)
            {
                auto duration = duration_cast<milliseconds>(stop-start);
                g << duration.count() << " ms\n" << endl;
            }
            else
                g << "Fail\n" << endl;
        }

        //Quick Sort
        g << "Quick Sort: ";

        sortat.clear();
        sortat = v;

        if(n >= 10000000)
            g << "FAIL\n" << endl;
        else
        {
            auto start = high_resolution_clock::now();
            quick_sort(sortat, 0, n-1);
            auto stop = high_resolution_clock::now();

            if(verificare(sortat, n) == true)
            {
                auto duration = duration_cast<milliseconds>(stop-start);
                g << duration.count() << " ms\n" << endl;
            }
            else
                g << "Fail\n" << endl;
        }

        //Count Sort
        g << "Count Sort: ";

        sortat.clear();
        sortat = v;
        vmax = maxim(v, n);

        if(n >= 10000000 || vmax >= 1000000)
            g << "FAIL\n" << endl;
        else
        {
            auto start = high_resolution_clock::now();
            count_sort(sortat, n, vmax);
            auto stop = high_resolution_clock::now();

            if(verificare(sortat, n) == true)
            {
                auto duration = duration_cast<milliseconds>(stop-start);
                g << duration.count() << " ms\n" << endl;
            }
            else
                g << "Fail\n" << endl;
        }

        //Radix Sort
        g << "Radix Sort: ";

        sortat.clear();
        sortat = v;

        if(n >= 10000000)
            g << "FAIL\n" << endl;
        else
        {
            auto start = high_resolution_clock::now();
            radix_sort(sortat, n);
            auto stop = high_resolution_clock::now();

            if(verificare(sortat, n) == true)
            {
                auto duration = duration_cast<milliseconds>(stop-start);
                g << duration.count() << " ms\n" << endl;
            }
            else
                g << "Fail\n" << endl;
        }

        g << "----------------------------------------------------\n" << endl;

    }

}
