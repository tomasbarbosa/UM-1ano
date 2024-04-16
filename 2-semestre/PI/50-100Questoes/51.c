#include <stdio.h>
#include <stdlib.h>

typedef struct lligada{
    int valor;
    struct lligada *prox
}*LInt;


//1
int length(LInt l){
    int cont = 0;
    while(l != NULL){
        cont++;

        l = l->prox;
    }
    return cont;
}

//2
void freeL(LInt l){
LInt aux;
    aux = l;
   
   while(l != NULL){
    aux = l;
    l = l-> prox;
    free(aux);
   }
}

//3
void imprimeL(LInt l){
    while(l != NULL){
        printf("%d\n",l->valor);
        l = l->prox;
    }
}

//4
LInt reverseL (LInt l){
    LInt prox = l->prox;
    l->prox = NULL;
        while(prox){
            LInt temp = prox->prox;
            prox->prox = l;
            l = prox;
            prox = temp;

        }
        return l;

    }

//5
void insertOrd(LInt *l, int x){
    LInt novo = malloc(sizeof(struct lligada));
    novo->valor = x;
    LInt atual = *l;
    LInt ant = NULL;
    while(atual != NULL && atual->valor < x){
        ant = atual;
        atual = atual->prox;
    }

    if(ant == NULL){
        novo->prox = NULL;
        *l = novo;
    }
    else{
        novo->prox = atual;
        ant->prox = novo;
    }

}

//6
int removeOneOrd(LInt * l, int x){
    LInt atual = *l;
    LInt ant = NULL;
        while(atual != NULL && atual->valor != x){
            ant = atual;
            atual = atual-> prox;

        }
        if(atual == NULL){ //nao encontra
            return 1;
        }
        if(ant == NULL){ // encontra logo no primeiro elemento
            *l = atual->prox;
        }
        else
            ant->prox = atual->prox;

    return 0;
}

//7
void merge (LInt *r, LInt a, LInt b){
    if(a == NULL){
        *r = b;
    }
    else if(b == NULL){
        *r = a;
    }
    else if(a->valor <= b->valor){
        *r = a;
        a = a-> prox;
        merge(&(*r)->prox, a, b);
    }
    else{
        *r = b;
        b = b->prox;
        merge(&(*r)->prox, a, b);
    }
}

//8
void splitQS(LInt l, int x, LInt *mx, LInt *Mx){
    if(l == NULL)
    return;

    if(l->valor < x){
        *mx = l;
        *Mx = NULL;
        splitQS(l->prox,x,&((*mx)->prox),Mx);
    }
    else{
        *Mx = l;
        *mx = NULL;
        splitQS(l->prox,x,mx,&((*Mx)->prox));
    }
}

//9 -- perguntar ao gabri
LInt parteAmeio(LInt *l){
    LInt nova = malloc(sizeof(struct lligada));

    if(nova == NULL)
        return NULL;

    nova = *l;
    LInt atual = *l;

    int tamanho = 0;

    while(atual != NULL){
        tamanho++;
        atual = atual->prox;
    }
    if(tamanho == 1)
        return NULL;
    
    atual = *l;

    for(int i = 0;i < tamanho/2 -1; i++){
        atual = atual->prox;
    }
    *l = atual ->prox;
    atual->prox = NULL;

    return nova;

}

//10
int removeAll(LInt *l, int x){
    int contador = 0;
    LInt aux = *l;
    LInt ant = NULL;

    while(aux != NULL){
        if(aux->valor == x){
            contador ++;
        
            if(ant == NULL)
                *l = aux->prox;
            else
                ant->prox = aux->prox;
        }
        else
            ant = aux;

        aux = aux->prox;
    }


    return contador;
}

//11
int removeDups(LInt *l){
    int cont = 0;
    for(;*l;l = &((*l)->prox)){
        LInt ant = *l, aux = (*l)->prox;
        for(;aux;aux = ant->prox){
            if(aux->valor == (*l)->valor){
                ant-> prox = aux->prox;
                cont++;
                free(aux);
            }
            else ant = aux;
        }

    }
    return cont;
}

//12
int removeMaiorL(LInt *l){
    LInt ant = NULL;
    LInt antMax = NULL;
    LInt maxAux = (*l);
    LInt aux = (*l);

    int maior = aux->valor;

    while(aux != NULL){
        if(aux->valor > maior){
            antMax = ant;
            maxAux = aux;
            maior = aux->valor;
        }
        
        ant = aux;
        aux = aux->prox;
    }

    if(antMax == NULL)
        (*l) = (*l)->prox;
    else
        antMax->prox = maxAux->prox;

    return maior;
}

//13
void init(LInt *l){
    LInt ant = NULL;
    LInt aux = (*l);

    while(aux != NULL){

        ant = aux;
        aux = aux->prox;
    }
    if(ant != NULL)
        ant->prox = NULL;
    else 
        (*l) = NULL;    //só com 1 elemento

        free(aux);
}

//14
void appendL(LInt *l, int x){
    LInt aux = (*l);
    LInt new = malloc(sizeof(struct lligada));
    new->valor = x;
    new->prox = NULL;

    if(aux == NULL){
        aux = new;
        return;
    }

    while(aux->prox != NULL){
        aux = aux->prox;
    }
    aux->prox = new;
    
}

//15
void concatL(LInt *a, LInt b){
    if((*a) == NULL){
        (*a) = b;
        return;
    }
    LInt aux = (*a);

    while(aux->prox != NULL){
        aux = aux->prox;
    }
    aux->prox = b;
}

//16
LInt cloneL (LInt l){
    if(l == NULL){
        return NULL;
    }
    LInt clone = malloc(sizeof(struct lligada));
    clone->valor = l->valor;
    clone->prox = cloneL(l->prox);

    return clone;
}

//17
LInt cloneRev(LInt l){
    if(l == NULL) return NULL;
    int len = length(l);
    LInt array[len];
    for(int i = len -1; i>= 0; i--){
        array[i] = malloc(sizeof(struct lligada));
        array[i]->valor = l->valor;
        if(i<len-1) array[i] -> prox = array[i+1];
        else array[i]->prox = NULL;
        l = l->prox;
    }
    return array[0];
}

//18
int maximo(LInt l){
    int max = l->valor;
    while(l != NULL){
        if(l->valor > max){
            max = l->valor;
        }
        l = l->prox;
    }
    return max;
}

//19
int take(int n, LInt *l){
    int i = 0;
    LInt aux = (*l), ant  = NULL;
    while(aux != NULL && n>0){
        ant  = aux;
        aux = aux->prox;
        i++;
        n--;
    }

    if(aux == NULL) return i;

    LInt temp;
    ant->prox = NULL;
    while(aux != NULL){
        temp = aux;
        aux = aux->prox;
        free(temp);
    }
    return i;
}

//20
int drop(int n, LInt *l){
    int  i;
    for(i = 0; i<n && l != NULL;i++){
        LInt temp = (*l);
        (*l) = (*l) -> prox;
        free(temp);
    }
    return i;
}

int drop(int n, LInt *l){
    int i;
    if(l == NULL) return 0;
    LInt aux = *l;
    LInt ant = NULL;

        while(aux!= NULL && n<0){
            ant = aux;
            aux = aux->prox;
            free(ant);
            n--;
            i++;
        }
        return i;
}

//21
LInt Nforward(LInt l, int N){
    if(l == NULL) return NULL;

    while(N>0){
        N--;
        l = l->prox;
    }
    return l;
}

//22
int listToArray(LInt l,int v[], int N){
    int i;
    for(i = 0; i<N && l != NULL; l = l->prox && i++)
        v[i] = l-> valor;

    return i;
}

//23
LInt arrayToList(int v[], int N){
    if(N == 0) return NULL;
    LInt novo = malloc(sizeof(struct lligada));
    novo -> valor = (*v);
    novo -> prox = arrayToList(v+1, N-1);
    return novo;
}

//24
LInt somasAcl(LInt l){
    int sum = 0;
    LInt aux = NULL, temp = NULL;

    while( l!= NULL){
        sum += l->valor;

        LInt novo = malloc(sizeof(struct lligada));
        
        if(novo == NULL) return NULL;

        novo-> valor = sum;
        novo -> prox = NULL;

        if(aux == NULL) aux = temp = novo;
        else{
            temp -> prox = novo;
            temp = novo;
        }

    
        l = l->prox;
        
    }
    return aux;
}

//25
void remreps(LInt l){
    if(l != NULL){
        while(l->prox){
            if(l->prox->valor == l->valor){
                LInt temp = l->prox;
                l -> prox = temp ->prox;
                free(temp);
            }
            else l = l->prox;
        }
    }
}

//26
LInt rotateL(LInt l){
    if(l == NULL || l->prox == NULL) return l;

    LInt prim = l;
    l = l->prox;
    prim->prox = NULL;

    LInt aux = l;
    while(aux->prox != NULL)
        aux = aux->prox;
    
    aux ->prox = prim;

    return l;
}

//27
LInt parte(LInt l){
    if(l == NULL || l->prox == NULL ) return NULL;

    LInt newL = l->prox;
    l->prox = l->prox->prox;
    newL->prox = parte(l->prox);
    return newL;
}


//Árvores Binárias


typedef struct nodo{
    int valor;
    struct nodo *esq, *dir;
} *ABin;

//28
int altura (ABin a){
    int r;
    if( a == NULL) r = 0;
    else r = 1 + max(size(a->esq),size(a->dir));
    return r;
}

//29
ABin cloneAB (ABin a){
    if(a == NULL) return NULL;
    ABin new = malloc(sizeof(struct nodo));
    new->valor = a-> valor;
    new->esq = cloneAB(a->esq);
    new->dir = cloneAB(a->dir);
}

//30
void mirror(ABin *a){
   if( a != NULL){
    ABin temp = (*a)->esq;
    (*a)->esq = (*a) ->dir;
    (*a)->dir = temp;
    mirror(&((*a)->esq));
    mirror(&(*a)->dir);
   } 
}


//31 duvida?
void inorderaux(ABin a, LInt *l){
    LInt aux;
    if(a != NULL){
        inorderaux(a -> dir, l);

        aux = malloc(sizeof(struct lligada));
        aux -> valor = a-> valor;
        aux -> prox = *l;

        *l = aux;

        inorderaux(a->esq, l);
    }
}

void inorder(ABin a, LInt *l){
    *l = NULL;
    inorderaux(a,l);
}

//32
void preorderaux(ABin a, LInt *l) {
    LInt aux;
    if(a) {
        preorderaux(a->dir,l);
        preorderaux(a->esq,l);

        aux = malloc(sizeof(struct lligada));
        aux->valor = a->valor;
        aux->prox = *l;

        *l = aux;
    }
}
void preorder(ABin a, LInt *l ){
    *l = NULL;
    preorderaux(a,l);
}

//33
void posorderaux(ABin tree, LInt * list) {
    if(tree) {
        LInt new = malloc(sizeof(struct lligada));
        new->valor = tree->valor;
        new->prox = (*list);
        (*list) = new;
        posorderaux(tree->dir,list);
        posorderaux(tree->esq,list);
    }
}

void posorder(ABin tree, LInt * list) {
    *list = NULL;
    posorderaux(tree,list);
}

//34
int depth(ABin a, int x){
    if(a == NULL) return -1;

    if(a->valor == x) return 1;

    int esq = depth(a->esq,x);
    int dir = depth(a->dir,x);

    if(esq == -1 && dir == -1) return -1;
    if(esq == -1) return 1 + dir;
    if(dir == -1) return 1 + esq;

    return esq < dir? 1 + esq : 1 + dir;
}

//35
int freeAB(ABin a){
    if(a == NULL) return 0;
    int n = 1 + freeAB(a->esq) + freeAB(a->dir);
    free(a);
    return n;
}

//36
int pruneAB(ABin *a,int l){
    int n;

    if((*a) ==  NULL) return 0;

    if(l == 0){
        n = 1 + pruneAB(&((*a)->esq),0) + pruneAB(&((*a)->dir),0);
        free(*a);
        (*a) = NULL;
    }
    else n = pruneAB(&((*a)->esq),l-1) + pruneAB(&((*a)->dir),l-1);

    return n;
}

//37
int iguaisAB(ABin a, ABin b){
    if(a == NULL && b !=NULL || a != NULL && b == NULL) return 0;
    if(a == NULL && b == NULL || a == b) return 1;
    return a->valor == b-> valor && iguaisAB(a->esq,b->esq) && iguaisAB(a->dir,b->dir);

}

//38
LInt concat(LInt a, LInt b){
    if(a == NULL) return b;
    LInt temp = a;
    while(temp->prox != NULL)
        temp = temp->prox;
        temp->prox = b;
        return a;

}
LInt nivelL(ABin a,int n){
    if(a == NULL || n < 1) return NULL;

    if(n == 1){
        LInt new = malloc(sizeof(struct lligada));
        new -> valor = a->valor;
        new -> prox = NULL;
        return new;

    }
    else return concat(nivelL(a->esq,n-1),nivelL(a->dir,n-1));
}

//39
int nivelV(ABin a, int n, int v[]){
    if(a == NULL || n<1) return 0;
    if(n == 1){
        *v = a->valor;
        return 1;
    }
    else{
        int e  = nivelV(a->esq, n-1,v);
        int d = nivelV(a->dir, n-1,v+e);
        return e + d;
    }
}

//40
int dumpAbin(ABin a, int v[], int N){
    int e;
    if(a != NULL && N > 0){
        e = dumpAbin(a->esq,v,N);

        if(e<N){
            v[e] = a->valor;
            return 1 + e + dumpAbin(a->dir,v+e+1,N-e-1);

        }
        else return N;
    }
    else return 0;
}

//41
ABin somasAcA (ABin a){
    if(a == NULL) return NULL;
    ABin new = malloc(sizeof(struct nodo));
    new->esq = somasAcA(a->esq);
    new->dir = somasAcA(a->dir);
    new->valor = a->valor + (new->esq  ? new->esq->valor : 0) + (new->dir ? new->dir->valor : 0);

}

//50 otv


//1

int llength (LInt l){
    int comp = 0;
    if(l == NULL) return 0;
    else{
        while(l!=NULL){
            l = l->prox;
            comp++;
        }
    }
    return comp;
}

//2
void freeL(LInt l){
    LInt temp = NULL;
    while(l!=NULL){
        temp = l;
        l = l->prox;
        free(temp);
    }
}

//3
void imprimeL(LInt l){
    while(l!=NULL){
        printf("%d\n",l->valor);
        l = l->prox;
    }
}


//4
LInt reverseL (LInt l){
    LInt prox = l->prox;
    l->prox = NULL;
    while(prox != NULL){
        LInt temp = prox->prox;
        prox->prox = l;
        l = prox;
        prox = temp;
    }
}

//10
int removeAll(LInt *l, int x){
    int contador = 0;
    LInt aux = *l;
    LInt ant = NULL;

    while(aux != NULL){
        if(aux->valor == x){
            contador ++;
            if(ant == NULL){
                *l = aux->prox;
            }
            else{
                ant->prox = aux->prox;
            }
        }
        else{
            ant = aux;
            aux = aux->prox;
        }
    }
    return contador;
}

//11
int removeDups(LInt *l){
    int cont = 0;
    for(;*l;l = &((*l)->prox)){
        LInt ant = *l, aux = (*l)->prox;
        for(;aux;aux = ant->prox){
            if(aux->valor == (*l)->valor){
                ant-> prox = aux->prox;
                cont++;
                free(aux);
            }
            else ant = aux;
        }

    }
    return cont;
}

//12
int removeMaiorL(LInt *l){
    LInt max = NULL;
    LInt aux = *l;
    LInt ant = NULL;


}

//13
void init(LInt *l){
    LInt ant = NULL;
    LInt aux = *l;

    while(aux != NULL){
        ant = aux;
        aux = aux->prox;

    }
    if(ant != NULL)
        ant -> prox = NULL;
    else
    *l = NULL;

    free(aux);
}
//14
void appendL(LInt *l, int x){
    LInt aux = *l;
    LInt novo = malloc(sizeof(struct lligada));
    novo->valor = x;
    novo->prox = NULL;
    if(aux == NULL){
        aux = novo;
        return;
    }
    while(aux->prox != NULL){
        aux = aux->prox;
    }
    aux->prox = novo;
}

//15
void concatL(LInt *a,LInt b){
    LInt aux = *a;
    if(*a == NULL){
        *a = b;
    } 

    while(aux->prox != NULL){
        aux = aux->prox;
    }
    aux->prox = b;
}

//16
LInt cloneL(LInt l){
    if(l == NULL)
    return NULL;
    LInt novo = malloc(sizeof(struct lligada));
        novo->valor = l->valor;
    novo->prox = cloneL(l->prox);

}
//17

LInt cloneRev(LInt l){
    if(l==NULL) return NULL;
    int len = length(l);
    LInt array[len];
    for(int i = len-1; i>=0;i--){
        array[i] = malloc(sizeof(struct lligada));
        array[i]->valor = l->valor;
        if(i<len-1) array[i]->prox = array[i+1];
        else array[i]->prox = NULL;
        l=l->prox;
    }
    return array[0];
}


//19

int take(int n,LInt *l){
    int i = 0;
    LInt aux = *l, ant = NULL;
    while(aux != NULL && n >0){
        ant = aux;
        aux = aux->prox;
        i++;
        n--;

    }
    if(aux == NULL) return i;
    LInt temp;
    ant->prox = NULL;
    while(aux !=NULL){
        temp = aux;
        aux = aux->prox;
        free(temp);
    }
    return i;
}



//20
int drop(int n, LInt *l){
int i;
for(i = 0; i< n && l !=NULL;i++){
    LInt temp = (*l);
    (*l) = (*l)->prox;
    free(temp);
}
return i;
}



//26
LInt rotateL(LInt l){
    if(l==NULL || l->prox == NULL) return l;
    LInt primeiro = l;
    l = l->prox;
    primeiro->prox = NULL;

    LInt aux = l;
    while(aux->prox != NULL){
        aux = aux->prox;
    }
    aux->prox = primeiro;

    return l;

}

//27
LInt parte(LInt l){
    if(l == NULL || l->prox == NULL) return NULL;
    LInt newL = l->prox;
    l->prox = l->prox->prox;
    newL -> prox = parte(l->prox);
    return newL;
}

int drop(int n, LInt *l){
    if(l == NULL) return 0;
    LInt aux = *l;
    LInt ant = NULL;

        while(aux!= NULL && n<0){
            ant = aux;
            aux = aux->prox;
            free(ant);
            n--;
        }
}