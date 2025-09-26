% Consultar a base
:- consult('base_conhecimento.pl').

%Predicado que será enviado para o aluno 3
recomenda(ListaOrdenada, Justificativa) :-
    findall(Trilha, Trilha, ListaDeTrilhas),
    findall(Trilha, calcula_pontuacao(Trilha, Pontuacao, _), ListaPontuacao),
    findall(Trilha, calcula_pontuacao(Trilha, _, Justificativa), ListaJustificativa)
    %arrumar a logica do recomenda(faltar ordenar e arrumar as logicas do findall)

calcula_pontuacao(Trilha, Pontuacao, Justificativa) :-
    findall(perfil(Trilha, Caracteristica, Peso), 
        perfil(Trilha, Caracteristica, Peso),
        ListaDePerfis),
    soma_pontos_perfis(ListaDePerfis, Pontuacao, Justificativa).

soma_pontos_perfis([], 0, []).

soma_pontos_perfis([PrimeiroPerfil | RestoDosPerfis], SomaTotal, JustificativaFormada) :-
    pontos_por_perfil(PrimeiroPerfil, PontosGuardados, JustificativaGuardada),
    soma_pontos_perfis( RestoDosPerfis, PontosRestante, JustificativaRestante),
    %debug: write('Sucesso, recursao deu certo'), nl,
    SomaTotal is PontosGuardados + PontosRestante,
    append(JustificativaGuardada, JustificativaRestante, JustificativaFormada).

pontos_por_perfil(perfil(Trilha, Caracteristica, Peso), Pontos, [Justificativa]) :-
    % debug: write('if rodou: '), write(Caracteristica), nl,
    pergunta(ID, _, Caracteristica),
    resposta(ID, s), !,
    Pontos is Peso,
    swritef(Justificativa, 'Afinidade com %w (%w pts)', [Caracteristica, Peso]).
    %debug: write('Sucesso, if concluido'), nl.

pontos_por_perfil(_, 0, [])