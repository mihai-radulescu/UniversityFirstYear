#include <fstream>
#include <bits/stdc++.h>

///Epsilon este citit cu caracterul $

using namespace std;

ifstream f("date.in");
ofstream g("date.out");

set <char> alfabet;

class RegularGrammar
{
public:
    int nrSimboluri;
    bool eFree = 0;
    unordered_map <string, set <string> > productie;

public:
    unordered_map <string, set <string> > getproductie() const
    {
        return productie;
    }

    void epsilonFree();

    friend istream& operator >>(istream&, RegularGrammar&);
    friend ostream& operator <<(ostream&, const RegularGrammar&);
};

istream& operator >>(istream& in, RegularGrammar& rg)
{
    string from, to;
    while(f >> from >> to)
        rg.productie[from].insert(to);
}

ostream& operator <<(ostream& out, const RegularGrammar& rg)
{
    for(auto &it : rg.productie)
    {
        out << it.first << " -> ";

        for(auto &j : it.second)
        {
            if(rg.eFree && j[0] == '$' && it.first != "S1")
                continue;
            out << j << " ";
        }

        out << "\n";
    }
    return out;
}

void RegularGrammar::epsilonFree()
{
    nrSimboluri = 0;

    for(auto &it : productie)
    {
        nrSimboluri++;

        for(auto &j : it.second)
            if(j[0] == '$')
            {

                for(auto &IT : productie)
                    for(auto &J : IT.second)
                        if(J[1] && J[1] == it.first[0])
                        {
                            string aux(1, J[0]);
                            IT.second.insert(aux);
                        }

                if(it.first[0] == 'S')
                {
                    string aux = "S1";
                    for(auto &J : it.second)
                        productie[aux].insert(J);
                    nrSimboluri++;
                }
            }
    }

    eFree = 1;
}


class NFA
{
public:
    int nrStari, si;
    vector <map <char, set<int> > > tranzitii;
    vector <bool> f;

public:
    NFA(const RegularGrammar& rg);

    void removeLambda();

    int getNrStari() const
    {
        return nrStari;
    }

    int getSI() const
    {
        return si;
    }

    vector <map <char, set<int> > > getTranz() const
    {
        return tranzitii;
    }

    vector <bool> getF() const
    {
        return f;
    }

    friend istream& operator>>(istream&, NFA&);
    friend ostream& operator<<(ostream&, const NFA&);
};

istream& operator >>(istream& in, NFA& a)
{
    int aux;
    in >> a.nrStari >> aux;

    a.tranzitii.resize(a.nrStari+1);
    a.f.resize(a.nrStari+1);

    for(int i = 1; i <= aux; ++i)
    {
        int x, y;
        char c;

        in >> x >> y >> c;
        a.tranzitii[x][c].insert(y);

        if(c != '$')
            alfabet.insert(c);
    }
    in >> a.si >> aux;

    for(int i = 1, x; i <= aux; ++i)
    {
        in >> x;
        a.f[x] = 1;
    }

    return in;
}
ostream& operator <<(ostream& out, const NFA& a)
{
    out << "Numar stari: " << a.nrStari << "\n";
    out << "Stare initiala: " << a.si << "\n";
    out << "Stari finale: ";

    for(int i = 1; i <= a.nrStari; ++i)
        if(a.f[i])
            out << i << " ";

    out << "\n\n";

    for(int i = 1; i <= a.nrStari; ++i)
        for(auto it : a.tranzitii[i])
            for(auto j : it.second)
                out << i << " " << j << " " << it.first << "\n";

    return out;
}

NFA::NFA(const RegularGrammar& rg)
{
    bool D0Exists = 0;
    unordered_map <string, set <string> > productie = rg.getproductie();
    int i = 0;
    map <string, int> marcate;
    for(auto &it : productie)
    {
        if(marcate.find(it.first) == marcate.end())
            marcate[it.first] = ++i;
        for(auto &j : it.second)
        {
            if(j[0] >= 'A' && j[0] <= 'Z')
            {
                string aux(1, j[0]);
                if(marcate.find(aux) == marcate.end())
                    marcate[aux] = ++i;
            }
            if(j[1] && j[1] >= 'A' && j[1] <= 'Z')
            {
                string aux(1, j[1]);
                if(marcate.find(aux) == marcate.end())
                    marcate[aux] = ++i;
            }
            if(!j[1] && j[0] != '$')
                D0Exists = 1;
        }
        if(it.first == "S1")
            si = i;
    }

    nrStari = i+D0Exists;
    tranzitii.resize(nrStari+1);
    f.resize(nrStari+1);

    for(auto &it : productie)
        for(auto &j : it.second)
        {
            if(j[0] == '$' && it.first != "S1")
                continue;

            if(j[0] == '$' && it.first == "S1")
            {
                string aux = "S1";
                f[marcate[aux]] = 1;
            }

            if(!j[1] && j[0] >= 'A' && j[0] <= 'Z')
            {
                string aux(1, j[0]);
                tranzitii[marcate[it.first]]['$'].insert(marcate[aux]);
            }

            if(!j[i] && j[0] >= 'a' && j[0] <= 'z')
            {
                alfabet.insert(j[0]);
                tranzitii[marcate[it.first]][j[0]].insert(nrStari);
            }

            if(j[1])
            {
                string aux(1, j[1]);
                tranzitii[marcate[it.first]][j[0]].insert(marcate[aux]);
                alfabet.insert(j[0]);
            }
        }

    f[nrStari] = 1;
}

void NFA::removeLambda()
{
    bool ok = 1;
    while(ok)
    {
        ok = 0;
        for(int i = 1; i <= nrStari; ++i)
        {
            if(!tranzitii[i].count('$'))
                continue;
            for(auto it : tranzitii[i]['$'])
            {
                for(auto it2 : tranzitii[it])
                    for(auto to : it2.second)
                    {
                        tranzitii[i][it2.first].insert(to);
                        ok = 1;
                    }
                if(f[it])
                    f[i] = 1, ok = 1;
            }
            tranzitii[i]['$'].clear();
        }
    }
}

int main()
{
    RegularGrammar grammar;

    f >> grammar;
    g << "Gramatica cu epsilon (initiala):\n";
    g << grammar;

    g << "\n------------------------------------------------------------------\n\n";

    grammar.epsilonFree();
    g << "Gramatica fara epsilon:\n";
    g << grammar;

    g << "\n------------------------------------------------------------------\n\n";

    NFA nfa(grammar);
    nfa.removeLambda();
    g << "NFA fara epsilon din gramatica regulata:\n\n";
    g << nfa;
}
