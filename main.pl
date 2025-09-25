% Consultar a base
:- consult('base_conhecimento.pl').

%Predicado que será enviado para o aluno 3
recomenda(ListaFinalOrdenada) :-

    write('Lógica de recomendação a ser implementada'), nl.

calcula_pontuacao(Trilha, PontuacaoFinal) :-

    write('Logica de calculo de pontuacao a ser implementada para a trilha: '), write(Trilha), nl.

soma_pontos_perfis([], 0).

soma_pontos_perfis([PrimeiroPerfil | RestoDosPerfis], SomaTotal) :-

    pontos_por_perfil(PrimeiroPerfil, PontosGuardados),
    soma_pontos_perfis( RestoDosPerfis, PontosRestante),
    %debug: write('Sucesso, recursao deu certo'), nl,
    SomaTotal is PontosGuardados + PontosRestante.

pontos_por_perfil(perfil(Trilha, Caracteristica, Peso), Pontos) :-
    % debug: write('if rodou: '), write(Caracteristica), nl,
    pergunta(ID, _, Caracteristica),
    resposta(ID, s), !,
    Pontos is Peso.
    %debug: write('Sucesso, if concluido'), nl.

pontos_por_perfil(_, 0)