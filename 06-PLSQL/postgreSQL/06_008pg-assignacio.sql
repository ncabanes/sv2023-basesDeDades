/*
Mostra les dues últimes xifres de l'any de llançament del joc el codi 
del qual és "last1". Primer hauràs d'obtindre la dada de l'any de 
llançament i després hauràs de bolcar les seues dues últimes xifres a 
una variable auxiliar, que finalment mostraràs en pantalla.
*/

DO
$$
DECLARE
    anyLlanc jocs.anyLlancament % TYPE;
    ultimesCifres NUMERIC(2);
BEGIN
    SELECT anyLlancament
    INTO anyLlanc
    FROM jocs
    WHERE codi = 'last1';

    ultimesCifres := MOD(anyLlanc, 100);
    RAISE NOTICE '%', ultimesCifres;
END;
$$
