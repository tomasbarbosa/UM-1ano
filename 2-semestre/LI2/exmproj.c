// 40% do mapa gerado inicialmente
#include <ncurses.h>
//código exemplo

//gerar a caverna

void do_generate_map(STATE *s){
    FOR_GRID_BORDER(R,C, 2, s)
        s->map[R][C].is_wall = drand48() < s->prob_wall; // % de ser parede

        for(int i = 0; i< s->first_pass; i++){
            char mapa[s->num_rows][s->num_cols];
            FOR_GRID_BORDER(R, C, 1, s)
                    mapa[R][C] = (radius_count(s, R, C, 1) >= 5) || (radius_count(s, R, C, 2) <= 2);
            FOR_GRID_BORDER(R, C, 1, s)
                    s -> map[R][C].is_wall = mapa[R][C];
        }

        for(int i = 0; i<s->second_pass;i++){
            char mapa[s -> num_rows][s->num_cols];
            FOR_GRID_BORDER(R, C, 1, s)
                mapa[R][C] = (radius_Count(s, R , C, 1) >= 5);
            FOR_GRID_BORDER(R, C, 1 , s)
                s->map[R][C].is_wall = mapa[R][C];
        }
}

//iluminação

/*
temos um  angulo em radianos
se for um espaço vazio significa que a celula foi vista
se encontrar uma parede deixa de continuar a propagar e a só a parede fica vista

*/

//numeração na movimentação

/* 
os numeros à volta dos personagens devem ser feitos de 0-9 e depois de 10-19 ( sendo que estes aparecem também de 0-9)
*/

void do_dist_pass(int R, int C, int value, STATE *s){
    if(value > MAX_DIST) return;

    if(s-> map[R][C].is_wall) return;

    if(s->map[R][C].dist <= value) return;

    s->map[R][C].dist = value;

    FOR_DELTA(DR, DC, 1)
        do_dist_pass(R+ DR, C+DC, value + 1, s);
        
}