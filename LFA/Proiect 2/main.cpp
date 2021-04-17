#include <bits/stdc++.h>
#include <fstream>

using namespace std;

ifstream f("date.in");
ofstream g("date.out");

set <char> alphabet;

///NFA
class NFA
{
public:
    int nrNodes, input_state;
    vector <map <char, set<int> > > transitions;
    vector <bool> final_states;

    void removeLambda();

    int get_nrNodes() const
    {
        return nrNodes;
    }

    int get_input_state() const
    {
        return input_state;
    }

    vector <map <char, set<int> > > get_transitions() const
    {
        return transitions;
    }

    vector <bool> get_final_states() const
    {
        return final_states;
    }

    friend istream& operator>>(istream&, NFA&);
    friend ostream& operator<<(ostream&, const NFA&);
};
istream& operator>>(istream& in, NFA& a)
{
    int aux;

    in >> a.nrNodes >> aux;

    a.transitions.resize(a.nrNodes+1);
    a.final_states.resize(a.nrNodes+1);

    for(int i = 1; i <= aux; ++i)
    {
        int x, y;
        char c;

        in >> x >> y >> c;

        a.transitions[x][c].insert(y);

        if(c != '$')
            alphabet.insert(c);
    }

    in >> a.input_state >> aux;

    for(int i = 1, x; i <= aux; ++i)
    {
        in >> x;
        a.final_states[x] = 1;
    }

    return in;
}

ostream& operator<<(ostream& out, const NFA& a)
{
    out << a.nrNodes << " stari\n";
    out << "Starea initiala: " << a.input_state << "\n";
    out << "Stari finale: ";

    for(int i = 1; i <= a.nrNodes; ++i)
        if(a.final_states[i]) out << i << " ";

    out << "\n";

    for(int i = 1; i <= a.nrNodes; ++i)
        for(auto it : a.transitions[i])
            for(auto j : it.second)
                out << i << " " << j << " " << it.first << "\n";

    return out;
}


void NFA::removeLambda()
{
    bool ok = 1;

    while(ok)
    {
        ok = 0;
        for(int i = 1; i <= nrNodes; ++i)
        {
            if(!transitions[i].count('$'))
                continue;
            for(auto it : transitions[i]['$'])
            {
                for(auto it2 : transitions[it])
                    for(auto to : it2.second)
                    {
                        transitions[i][it2.first].insert(to);
                        ok = 1;
                    }
                if(final_states[it])
                    final_states[i] = 1, ok = 1;
            }
            transitions[i]['$'].clear();
        }
    }
}

///DFA
class DFA
{
public:
    int nrNodes, input_state;
    vector <map <char, int> > transitions;
    vector <bool> final_states;

    DFA(const NFA& nfa_automat);

    friend ostream& operator<<(ostream&, const DFA&);
};
ostream& operator<<(ostream& out, const DFA& a)
{
    out << a.nrNodes << " stari\n";
    out << "Starea initiala: " << a.input_state << "\n";
    out << "Stari finale: ";

    for(int i = 1; i <= a.nrNodes; ++i)
        if(a.final_states[i]) out << i << " ";

    out << "\n";

    for(int i = 1; i <= a.nrNodes; ++i)
    {
        if(a.transitions[i].empty()) continue;
        for(auto it : a.transitions[i])
            out << i << " " << it.second << " " << it.first << "\n";
    }

    return out;
}

DFA::DFA(const NFA& nfa_automat)
    {
        nrNodes = 0;

        map <set <int>, int> Map;
        vector <map <char, set<int> > > nfaTranz = nfa_automat.get_transitions();
        vector <bool> nfa_final = nfa_automat.get_final_states();
        queue <set <int> > Q;
        set <int> aux;

        final_states.push_back(0);

        input_state = nfa_automat.get_input_state();

        aux.insert(input_state);

        final_states.push_back(nfa_final[input_state]);
        Map[aux] = ++nrNodes;
        transitions.push_back(map <char, int>());

        Q.push(aux);

        while(!Q.empty())
        {
            set <int> nodes = Q.front();
            Q.pop();

            for(char c : alphabet)
            {
                aux.clear();

                for(auto it : nodes)
                {
                    if(!nfaTranz[it].count(c)) continue;
                    for(auto to : nfaTranz[it][c]) aux.insert(to);
                }
                if(!aux.size()) continue;
                if(!Map.count(aux))
                {
                    Map[aux] = ++nrNodes;
                    bool Final = 0;
                    for(auto it : aux)
                        if(nfa_final[it])
                            Final = 1;

                    final_states.push_back(Final);
                    transitions.push_back(map <char, int>());

                    Q.push(aux);
                }
                transitions[Map[nodes]][c] = Map[aux];
            }
        }
    }

int main()
{
    NFA nfa_automat;
    f >> nfa_automat;

    nfa_automat.removeLambda();
    g << "Lambda-NFA in NFA:\n";
    g << nfa_automat;

    DFA dfa_automat(nfa_automat);
    g << "NFA in DFA:\n";
    g << dfa_automat;

}
