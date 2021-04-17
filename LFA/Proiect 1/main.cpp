/// NFA si generarea primelor k elemente in ordine lexicografica

#include <iostream>
#include <vector>
#include <bits/stdc++.h>

using namespace std;

// fisiere
ifstream f("date.in");
ofstream g("date.out");

struct adiacent
{
    int st;
    char c;
};

// vector care contine starea adiacenta a lui i si litera corespunzatoare
vector <adiacent> a[101];

// vector de satari finale
vector <int> stari_finale;

int n, m, k, stare_initiala, nr_cuv, nr_generare;
char c, cuv[101], s[101];
bool ok;

// NFA
void nfa(char cuv[], int poz, int stare, bool &ok)
{

    int litera, urmatoare;

    for(int i = 0; i < a[stare].size(); i ++)
    {
        urmatoare = a[stare][i].st;
        litera = a[stare][i].c;

        if(litera == cuv[poz])
            if(poz == strlen(cuv) - 1)
            {
                for(int j = 0; j < k; j ++) //verificam daca ultima stare in care ajungem e stare finala
                    if(urmatoare == stari_finale[j])
                        ok = 1;
            }
            else
                nfa(cuv, poz + 1, urmatoare, ok);
    }

}

struct coada
{
    int st;
    string partial;
};

// coada care retine pereche de forma stare si cuvnat format pana in satrea curenta
queue <coada> Q;

unordered_set <string> afisare;

// generarea cuvintelor
void generator(int nr_cuv)
{

    coada nod;
    int i, j, nr = 0, stare_urmatoare;
    string actual_cuv, urmator_cuv;
    char litera;

    // intializarea cozii
    Q.push({stare_initiala,""});

    while(!Q.empty() && nr < nr_cuv)
    {
        nod = Q.front();
        actual_cuv = nod.partial;
        Q.pop();

        for(i = 0; i < a[nod.st].size(); i ++)
        {
            stare_urmatoare = a[nod.st][i].st;
            litera = a[nod.st][i].c;
            urmator_cuv = actual_cuv + litera;

            Q.push({ stare_urmatoare, urmator_cuv });

            // verificare ultima stare este finala
            for(j = 0; j < k; j ++)
                if(stare_urmatoare == stari_finale[j])
                {
                    // se verifica daca cuvantul curent a mai fost afist
                    if( afisare.find(urmator_cuv) == afisare.end())
                    {
                        afisare.insert(urmator_cuv);
                        g << nr + 1 << ": " << urmator_cuv << endl;
                        nr ++;
                        break;
                    }

                }

        }
    }
}

// functue care verifica daca cuvantul s este acceptat de automat
void acceptare(bool ok, char s[])
{
    if(ok == 1)
        g << ok << " --- Cuvantul \"" << s << "\" apartine limbajului";
    else
        g << ok << " --- Cuvantul \"" << s << "\" nu apartine limbajului";
    g<<endl;
}

// functie care citeste datele automatului
void citire_automat()
{
    int x, y;

    // n stari, m tranzitii
    f >> n >> m;

    for(int i = 1; i <= m; i ++)
    {
        // creearea vectorului a
        f >> x >> y >> c;
        a[x].push_back({y,c});
    }

    // stare initiala
    f >> stare_initiala;

    // numar stari finale
    f >> k;

    // vector de stari finale
    for(int i = 0; i < k; i++)
    {
        f >> x;
        stari_finale.push_back(x);
    }
}

int main()
{
    citire_automat();

    g << "Verificarea cuvintelor:" << endl << endl;

    // citire si verificare a apartenentei cuvintelor
    f >> nr_cuv;
    for(int i = 0; i < nr_cuv; i++)
    {
        f>>s;
        ok= 0;

        // apelare functie de verificares
        nfa(s, 0, stare_initiala, ok);
        acceptare(ok, s);
    }

    g << endl <<"----------------------------------------------------------------" << endl << endl;

    f >> nr_generare;
    g << "Generarea primelor " << nr_generare << " cuvinte in ordine lexicografica:" << endl << endl;

    generator(nr_generare);
}
