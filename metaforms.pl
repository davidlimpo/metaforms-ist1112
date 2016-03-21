 /*

************************************

	ISTITUTO SUPERIOR TECNICO
	LOGICA PROGRAMACAO

	David Limpo
	Jose Andrade

************************************

*/

/* Pistas basicas */

coloca(P, top, left, [P,_,_,_,_,_,_,_,_]).
coloca(P, top, middle, [_,P,_,_,_,_,_,_,_]).
coloca(P, top, right, [_,_,P,_,_,_,_,_,_]).
coloca(P, center, left, [_,_,_,P,_,_,_,_,_]).
coloca(P, center, middle, [_,_,_,_,P,_,_,_,_]).
coloca(P, center, right, [_,_,_,_,_,P,_,_,_]).
coloca(P, bottom, left, [_,_,_,_,_,_,P,_,_]).
coloca(P, bottom, middle, [_,_,_,_,_,_,_,P,_]).
coloca(P, bottom, right, [_,_,_,_,_,_,_,_,P]).



/* Pistas Intermedias */

linhaTriplaHorizontal(P, Col, T):- coloca(P,_,Col, T).
linhaTriplaVertical(P, Line, T):- coloca(P,Line,_, T).

quadrado(P, top, left, T):- coloca(P,top,left,T); coloca(P,top,middle,T);  coloca(P,center,left,T); coloca(P,center,middle,T).

quadrado(P, top, right, T):- coloca(P,top,right,T); coloca(P,top,middle,T);  coloca(P,center,right,T); coloca(P,center,middle,T).

quadrado(P, bottom, left, T):- coloca(P,bottom,left,T); coloca(P,bottom,middle,T);  coloca(P,center,left,T); coloca(P,center,middle,T).

quadrado(P, bottom, right, T):- coloca(P,bottom,right,T); coloca(P,bottom,middle,T);  coloca(P,center,right,T); coloca(P,center,middle,T).


linhaDuplaVertical(P, top, T):- coloca(P,top,_,T);coloca(P,center,_,T).
linhaDuplaVertical(P, bottom, T):- coloca(P,bottom,_,T);coloca(P,center,_,T).


linhaDuplaHorizontal(P, left, T):- coloca(P,_,left,T); coloca(P,_,middle,T).
linhaDuplaHorizontal(P, right, T):- coloca(P,_,right,T); coloca(P,_,middle,T).


rectanguloHorizontal(P,top, left,T) :- coloca(P,top,left,T); coloca(P,center,left,T).
rectanguloHorizontal(P,top, right,T) :- coloca(P,top,right,T); coloca(P,center,right,T).
rectanguloHorizontal(P,top, middle,T) :- coloca(P,top,middle,T); coloca(P,center,middle,T).

rectanguloHorizontal(P,bottom, left,T) :- coloca(P,bottom,left,T); coloca(P,center,left,T).
rectanguloHorizontal(P,bottom, right,T) :- coloca(P,bottom,right,T); coloca(P,center,right,T).
rectanguloHorizontal(P,bottom, middle,T) :- coloca(P,bottom,middle,T); coloca(P,center,middle,T).


rectanguloVertical(P,top, left,T) :- coloca(P,top,left,T); coloca(P,top,middle,T).
rectanguloVertical(P,top, right,T) :- coloca(P,top,right,T); coloca(P,top,middle,T).

rectanguloVertical(P,center, left,T) :- coloca(P,center,left,T); coloca(P,center,middle,T).
rectanguloVertical(P,center, right,T) :- coloca(P,center,middle,T); coloca(P,center,right,T).

rectanguloVertical(P,bottom, left,T) :- coloca(P,bottom,left,T); coloca(P,bottom,middle,T).
rectanguloVertical(P,bottom, right,T) :- coloca(P,bottom,right,T); coloca(P,bottom,middle,T).


/* Pistas Avançadas */


/* Operações com listas
delete list recebe 2 listas, remove todos os elementos da primeira lista que estão na segunda. E devolve a lista com os elementos removidos.
Com esta função pretendemos transformar a lista onde não podemos colocar as peças na lista onde podemos colocar as peças */

deletelist([], _, []).
deletelist([X|Xs], Y, Z) :- member(X, Y), deletelist(Xs, Y, Z), !.
deletelist([X|Xs], Y, [X|Zs]) :- deletelist(Xs, Y, Zs).


/* Matriz Negada */
todas_pos_possivel([(top, left),(top, middle),(top, right), (center, left), (center, middle), (center, right), (bottom, left), (bottom, middle), (bottom, right)]).

/* Esta função vai colocar a peça numa posição possível. Ou seja, percorre a lista das posições possiveis,
vai a uma posição (ex:. (top, left), que é uma tupla) e chama o coloca */

colocaLinhaColuna([], _, []).
colocaLinhaColuna(P, [(Line, Column)|Resto], T) :- coloca(P, Line, Column, T) ; colocaLinhaColuna(P, Resto, T).

matrizNeg(P, L1, T):- todas_pos_possivel(L), deletelist(L, L1 , Pos), colocaLinhaColuna(P, Pos, T).



/* Linha Tripla Vertical negada */
lTV_pos_possivel([top, center, bottom]).


colocaLTV([], _, []).
colocaLTV(P, [Line|Resto], T) :- linhaTriplaVertical(P, Line, T) ; colocaLTV(P, Resto, T).

linhaTriplaVerticalNeg(P, L1, T):- lTV_pos_possivel(L), deletelist(L, L1, Pos), colocaLTV(P, Pos, T).




/* Linha Tripla Horizontal negada */
lTH_pos_possivel([left, middle, right]).


colocaLTH([], _, []).
colocaLTH(P, [Column|Resto], T) :- linhaTriplaHorizontal(P, Column, T) ; colocaLTH(P, Resto, T).

linhaTriplaHorizontalNeg(P, L1, T):- lTH_pos_possivel(L), deletelist(L, L1, Pos), colocaLTH(P, Pos, T).





/* Linha Dupla Vertical Negada */

lDV_pos_possivel([top, bottom]).

colocaLDV([], _, []).
colocaLDV(P, [Line|Resto], T) :- coloca(P, Line, _, T) ; colocaLDV(P, Resto, T).

linhaDuplaVerticalNeg(P, L1, T):- lDV_pos_possivel(L), deletelist(L, L1, Pos), colocaLDV(P, Pos, T).




/* Linha Dupla Horizontal Negada */

lDH_pos_possivel([left, right]).

colocaLDH([], _, []).
colocaLDH(P, [Column|Resto], T) :- coloca(P, _, Column, T) ; colocaLDH(P, Resto, T).

linhaDuplaHorizontalNeg(P, L1, T):- lDH_pos_possivel(L), deletelist(L, L1, Pos), colocaLDH(P, Pos, T).


/* quadrado negado */

pos_q_possivel(P,[],P).
pos_q_possivel(Pec_inic, [(X1,X2)|Resto], Pec_final) :- deletelist(Pec_inic,[(X1,X2), (center,X2), (X1,middle),(center, middle)], Pec_actualizada),
	pos_q_possivel(Pec_actualizada, Resto, Pec_final).

quadradoNeg(P, L1, T):- todas_pos_possivel(M), pos_q_possivel(M, L1, Pec_final), colocaLinhaColuna(P, Pec_final, T).


/* Rectangulo Vertical Negado */

pos_rv_possivel(P,[],P).
pos_rv_possivel(Pec_inic, [(X1,X2)|Resto], Pec_final) :- deletelist(Pec_inic,[(X1,X2), (X1,middle)], Pec_actualizada),
	pos_rv_possivel(Pec_actualizada, Resto, Pec_final).

rectanguloVerticalNeg(P, L1, T):- todas_pos_possivel(M), pos_rv_possivel(M, L1, Pec_final), colocaLinhaColuna(P, Pec_final, T).


/* Rectangulo Horizontal Negado */

pos_rh_possivel(P,[],P).
pos_rh_possivel(Pec_inic, [(X1,X2)|Resto], Pec_final) :- deletelist(Pec_inic,[(X1,X2), (center,X2)],Pec_actualizada),
	pos_rh_possivel(Pec_actualizada, Resto, Pec_final).

rectanguloHorizontalNeg(P, L1, T):- todas_pos_possivel(M), pos_rh_possivel(M, L1, Pec_final), colocaLinhaColuna(P, Pec_final, T).

































