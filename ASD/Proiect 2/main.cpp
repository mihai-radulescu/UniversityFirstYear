#include <bits/stdc++.h>
#include <fstream>

using namespace std;

ifstream f("date.in");
ofstream g("date.out");

class AVL_tree
{
public:
    int val, h;
    AVL_tree *left;
    AVL_tree *right;
};

///Utilitare
int max(int a, int b)
{
    return (a > b)? a : b;
}

int height(AVL_tree * N)
{
    if(N == NULL)
        return 0;
    return N->h;
}

int balance_factor(AVL_tree *N)
{
    if(N == NULL)
        return 0;
    return height(N->left) - height(N->right);
}

AVL_tree * val_min(AVL_tree* N)
{
    AVL_tree* curent = N;

    while (curent->left != NULL)
        curent = curent->left;

    return curent;
}

AVL_tree* val_max(AVL_tree* N)
{
    AVL_tree* curent = N;

    while (curent->right != NULL)
        curent = curent->right;

    return curent;
}

///Rotatii
AVL_tree *rightRotate(AVL_tree *a)
{
    AVL_tree *b = a->left;
    AVL_tree *p = b->right;

    b->right = a;
    a->left = p;

    a->h = max(height(a->left), height(a->right))+1;
    b->h = max(height(b->left), height(b->right))+1;

    return b;
}

AVL_tree *leftRotate(AVL_tree *a)
{
    AVL_tree *b = a->right;
    AVL_tree *p = b->left;

    b->left = a;
    a->right = p;

    a->h = max(height(a->left), height(a->right))+1;
    b->h = max(height(b->left), height(b->right))+1;

    return b;
}

///Inserare
AVL_tree* init_root(int val)
{
    AVL_tree* new_nod = new AVL_tree();

    new_nod->val = val;
    new_nod->right = NULL;
    new_nod->left = NULL;
    new_nod->h = 1;

    return new_nod;
}

AVL_tree* insert_node(AVL_tree *N,int val)
{
    if(N == NULL)
        return init_root(val);
    if(val < N->val)
        N->left = insert_node(N->left, val);
    else if(val > N->val)
        N->right = insert_node(N->right, val);
    else return N;

    N->h = 1+ max(height(N->right), height(N->left));

    int balance = balance_factor(N);

    if(balance > 1 && val < N->left->val)
        return rightRotate(N);

    if (balance < -1 && val > N->right->val)

        return leftRotate(N);


    if (balance > 1 && val > N->left->val)
    {
        N->left = leftRotate(N->left);
        return rightRotate(N);

    }

    if (balance < -1 && val < N->right->val)
    {
        N->right = rightRotate(N->right);
        return leftRotate(N);
    }

    return N;
}


///Stergere
AVL_tree* delete_node(AVL_tree* root, int val)
{
    if (root == NULL)
        return root;

    if ( val < root->val )
        root->left = delete_node(root->left, val);
    else if( val > root->val )
        root->right = delete_node(root->right, val);
    else
    {
        if( (root->left == NULL) || (root->right == NULL) )
        {
            AVL_tree *temp = root->left ? root->left : root->right;

            if (temp == NULL)
            {
                temp = root;
                root = NULL;
            }
            else
                *root = *temp;
            free(temp);

        }
        else
        {
            AVL_tree* temp = val_min(root->right);
            root->val = temp->val;
            root->right=delete_node(root->right, temp->val);

        }
    }
    if(root == NULL)
        return root;
    root->h = 1 + max(height(root->left), height(root->right));

    int balance = balance_factor(root);

    if (balance > 1 && balance_factor(root->left) >= 0)
        return rightRotate(root);

    if (balance > 1 && balance_factor(root->left) < 0)
    {
        root->left = leftRotate(root->left);
        return rightRotate(root);
    }

    if (balance < -1 && balance_factor(root->right) <= 0)
        return  leftRotate(root);

    if (balance < -1 && balance_factor(root->right) > 0)
    {
        root->right = rightRotate(root->right);
        return leftRotate(root);
    }
return root;
}


///Cautare
void search_node(AVL_tree *root, int val)
{
    if(root == NULL)
        g << 0;
    else
    {
        if(val < root->val)
            search_node(root->left, val);
        else
            if(val > root->val)
            search_node(root->right, val);
        else
            g << 1;
    }
}


///Succesor
void  succesor(AVL_tree* root, int val)
{
    if(root == NULL)
        g<<-1;
    else if(root->val < val)
        succesor(root->right, val);
    else if((root->left == NULL)|| ((val_max(root->left))->val < val))
        g<<root->val;

    else
        succesor(root->left,val);


}


///Predecesor
void  predecesor(AVL_tree* root, int val)
{
    if(root==NULL)
        g<<-1;
    else if(root->val>val)
        predecesor(root->left, val);
    else if((root->right==NULL)|| ((val_min(root->right))->val > val))
        g<<root->val;

    else
        predecesor(root->right,val);


}


///Interval
void interval(AVL_tree *root, int val1, int val2)
{
    if(root != NULL)
    {
        if(val1 > root->val)
            interval(root->right, val1, val2);
        else if(val2 < root->val)
            interval(root->left, val1,val2);
        else
        {
            interval(root->left, val1, val2);

            g << root->val << " ";

            interval(root->right, val1, val2);
        }
    }
}


///Meniu
int main()
{
    int n;
    int x,y,z;

    f >> n;

    AVL_tree* root = NULL;

    while(n--)
    {
        f>>x;

        switch(x)
        {
        case 1:

            f >> y;
            root = insert_node(root, y);
            break;

        case 2:

            f >> y;
            root = delete_node(root, y);
            break;

        case 3:

            f >> y;
            search_node(root, y);
            g << "\n";
            break;

        case 4:

            f >> y;
            succesor(root, y);
            g << "\n";
            break;

        case 5:

            f >> y;
            predecesor(root, y);
            g << "\n";
            break;

        case 6:

            f >> y >> z;
            interval(root, y, z);
            g << "\n";
            break;

        }

    }
}
