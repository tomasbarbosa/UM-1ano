char* strstr(char s1[], char s2[]){
    int Nh, NN, found;

    for(Nh = 0; s1[Nh]; Nh++){
        found = 1;
        for(Nn = 0; s2[Nn];Nn++){
            if(s2[Nn] != s1[Nh + Nn]) found = 0;

        }
        if(found == 1) break;
    }
    if (found == 1) return s1 + Nh;
    return NULL;
}

