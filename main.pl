% Consultar a base
:- consult('base_conhecimento.pl').

%Predicado que será enviado para o aluno 3
recomenda(ListaOrdenada, Justificativa) :-

    write('Lógica de recomendação a ser implementada'), nl.

calcula_pontuacao(Trilha, Pontuacao, Justificativa) :-

    write('Logica de calculo de pontuacao a ser implementada para a trilha: '), write(Trilha), nl.

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