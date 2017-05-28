
% -*- mode: Prolog  -*-
% (c) J. R. Fisher.
% http://www.csupomona.edu/~jrfisher/www/prolog_tutorial/2_17.html
% added on to by Evelyn Pirnia

% Animal identification rules
% To run, type      go.

go :- hypothesize(Animal),
       write('I guess that the animal is: '),
       write(Animal), nl, undo.

 /* hypotheses to be tested */
hypothesize(agileChromis) :- agileChromis, !.
hypothesize(blueEyeDamselfish) :- blueEyeDamselfish, !.
hypothesize(ovalChromis) :- ovalChromis, !.
hypothesize(dascyllus) :- dascyllus, !.
hypothesize(brighteyeDamselfish) :- brighteyeDamselfish, !.
hypothesize(pacificGregory) :- pacificGregory, !.
hypothesize(yellowAnthias) :- yellowAnthias, !.
hypothesize(greenLionfish) :- greenLionfish, !.
hypothesize(coralCroucher) :- coralCroucher, !.
hypothesize(hawaiianSergeant) :- hawaiianSergeant, !.

hypothesize(unknown). /* no diagnosis */

/* animal identification rules */
agileChromis :- planktivore,
                verify(color_multi),
                verify(habitat_tidepools).
blueEyeDamselfish :- omnivore,
                verify(color_yellowgreen),
                verify(habitat_coral).
ovalChromis :- carnivore,
                verify(color_multi),
                verify(habitat_reefs).
dascyllus :- planktivore,
                verify(color_multi),
                verify(habitat_coral).
brighteyeDamselfish :- carnivore,
                verify(color_yellowgreen),
                verify(habitat_rockycoasts).
pacificGregory :- omnivore,
                verify(color_gray),
                verify(habitat_shallows).
yellowAnthias :- carnivore,
                verify(color_multi),
                verify(habitat_darkholes).
greenLionfish :- carnivore,
                verify(color_multi),
                verify(habitat_reefs),
                verify(poisonous).
coralCroucher :- carnivore,
                verify(color_multi),
                verify(habitat_coral),
                verify(poisonous).
hawaiianSergeant :- omnivore,
                verify(color_multi),
                verify(habitat_tidepools).

/* classification rules */
carnivore :- verify(only_eats_meat), !.
planktivore :- verify(only_eats_plankton), !.
omnivore :- verify(only_eats_meat_and_plankton),  !.

/* how to ask questions */
ask(Question) :-
        write('Does the animal have the following attribute: '),
        write(Question), write('? '),
         read(Response), nl,
         ( (Response == yes ; Response == y)
         -> assert(yes(Question)) ;
         assert(no(Question)), fail).
:- dynamic yes/1,no/1.
/* How to verify something */
verify(S) :- (yes(S) -> true ; (no(S) -> fail ; ask(S))).
/* undo all yes/no assertions */
undo :- retract(yes(_)),fail.
undo :- retract(no(_)),fail.
undo.
