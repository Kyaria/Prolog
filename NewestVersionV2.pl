% No. 1, a/

vorfahre(abraham, homer).
vorfahre(abraham, herb).

vorfahre(mona, homer).

vorfahre(clancy, marge).
vorfahre(clancy, petty).
vorfahre(clancy, selma).

vorfahre(jackie, marge).
vorfahre(jackie, petty).
vorfahre(jackie, selma).

vorfahre(homer, bart).
vorfahre(homer, lisa).
vorfahre(homer, maggie).

vorfahre(marge, bart).
vorfahre(marge, lisa).
vorfahre(marge, maggie).

vorfahre(selma, ling).

istVorfahre(X, Y) :- vorfahre(X, Y).
istVorfahre(X, Y) :- vorfahre(WER, Y), vorfahre(X, WER).

sindGeschwister(X, Y) :- vorfahre(Wer, X), vorfahre(Wer, Y).

male(abraham).
male(homer).
male(herb).
male(bart).

female(mona).
female(marge).
female(petty).
female(selma).
female(jackie).
female(lisa).
female(maggie).
female(ling).

istSchwesterVon(X, Y) :- sindGeschwister(X, Y), female(X).
istBruderVon(X, Y) :- sindGeschwister(X, Y), male(X).


% No. 1, b/
% Normalrekursiv, mit Stack.

count([], 0).
count([_H | T], Groesse) :- count(T, TailGroesse), Groesse is TailGroesse + 1.

sum([], 0).
sum([ H | T], Summe) :- sum(T, Tmp), Summe is Tmp + H.

average(List, Durchschnitt) :- count(List, Groesse), sum(List, Summe),
    Durchschnitt is Summe / Groesse.

% Endrekursion, Kompiler optimiert den Stack weg.
endCount(Liste, Groesse) :- endCount(Liste, 0, Groesse).
endCount([], SoWeit, SoWeit).
endCount([_H | T], SoWeit, Groesse) :- Temp is SoWeit + 1, endCount(T, Temp, Groesse).

endSum(Liste, Summe) :- endSum(Liste, 0, Summe).
endSum([], SoWeit, SoWeit).
endSum([H | T], SoWeit, Summe) :- Temp is SoWeit + H, endSum(T, Temp, Summe).

endAverage(List, Durchschnitt) :- endCount(List, Groesse), endSum(List, Summe),
    Durchschnitt is Summe / Groesse.

% myAppend(L1, L2, L3).
myAppend([], L2, L2).
myAppend([ H_L1 | T_L1 ], L2, [H_L1 | CF]) :-
    myAppend(T_L1, L2, CF).

% allMembers(L1, L2).
allMembers([], _ ).
allMembers([H | T] , L2) :- member(H, L2), allMembers(T, L2).

% allMembers(L, [m, o, i, n]).
% allMembers(L, [2, 0, 2, 0]).
%
% Es wird in beiden Fällen L = [] ausgegeben, und mit jeder weiteren
% Ausgabe wird das erste Element der Liste angehängt.

% numberOfMatches(L1, L2, N).
numberOfMatches([], _, 0).
numberOfMatches([H | T], L2, N) :- numberOfMatches(T, L2, Tmp), (member(H, L2) ->
                                    N is Tmp + 1
                                    ;   N is Tmp).

% Fridolin = [sport, abnehmen, mehrRuhe].
% Lars = [wenigerRuhe, zunehmen].
% Hanna = [sport, mehrFreunde].
% Susi = [abnehmen, sport, mehrRuhe].

fridolin(["sport", "abnehmen", "mehrRuhe"]).
lars(["wenigerRuhe", "zunehmen"]).
hanna(["sport", "mehrFreunde"]).
susi(["abnehmen", "sport", "mehrRuhe"]).

% Abfragen:
%
% Eine Gemeinsamkeit: name1(L1), name2(L2), numberOfMatches(L1, L2, N),N >= 1.
% Drei Gemeinsamkeiten: name1(L1), name2(L2), numberOfMatches(L1, L2, N), N >= 3.
% Nur Gemeinsamkeiten name1(L1), name2(L2), allMembers(L1, L2),allMembers(L2, L1).

% No. 1, c/ Baumstrukturen
defTree(string, n("HALLO", n("Bonjourno", nil, n("BENIS", nil, nil)), n("Dickbutt", nil, nil))).
defTree(integer, n(42, n(69, nil, n(420, nil, nil)), n(666, nil, nil))).
defTree(stringFUCK, n("THIS", n("AIN'T", nil, n("WORKIN'", nil, nil)), n("DAMNIT", nil, nil))).

tree(nil).                              % Leerer Baum.
tree(n(_X, L, R)) :- tree(L), tree(R).   % Node mit Element, linkem und rechtem Baum.

countTree(_, nil, 0).
countTree(X, n(X0, L, R), Res) :- countTree(X, L, LeftCount), countTree(X, R, RightCount),
                                  ( X == X0 -> N is 1 ; N is 0), Res is N + LeftCount + RightCount.
replaceTree(_, _, nil, nil).
replaceTree(X, Y, n(X0, L, R), TreeOut) :-  replaceTree(X, Y, L, LeftTreeOut), replaceTree(X, Y, R, RightTreeOut),
                                            ( X == X0 -> TreeOut = n(Y, LeftTreeOut, RightTreeOut) ; TreeOut = n(X0, LeftTreeOut, RightTreeOut)).

sumTree(nil, 0).
sumTree(n(X0, L ,R), Sum) :- sumTree(L, LeftSum), sumTree(R, RightSum),
                             Sum is X0 + LeftSum + RightSum.
