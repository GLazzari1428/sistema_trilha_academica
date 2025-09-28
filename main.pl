% Consultar a base
:- consult('base_conhecimento.pl').

%Predicado que será enviado para o aluno 3, e o predicado chefe.
recomenda(ListaOrdenadaFinal, ListaJustificativaFinal) :-
    %Procura as trilhas, pontuação e justificativa, para montar uma lista não ordenada com esses dados
    findall(
        [Trilha, Pontuacao, Justificativa],
        (trilha(Trilha, _), calcula_pontuacao(Trilha, Pontuacao, Justificativa)),
        ListaCompleta
    ),
    %Ordenação da Lista
    predsort(comparar_pontuacoes, ListaCompleta, ListaCompletaOrdenada),
    %Entregar as listas finais separadas
    separar_resultados(ListaCompletaOrdenada, ListaOrdenadaFinal, ListaJustificativaFinal).

%Calcula a pontuação da trilha
calcula_pontuacao(Trilha, Pontuacao, Justificativa) :-
    findall(
        perfil(Trilha, Caracteristica, Peso), 
        perfil(Trilha, Caracteristica, Peso),
        ListaDePerfis
    ),
    soma_pontos_perfis(ListaDePerfis, Pontuacao, Justificativa).

%Recursão para somar os resultados dos perfis
soma_pontos_perfis([], 0, []).

soma_pontos_perfis([PrimeiroPerfil | RestoDosPerfis], SomaTotal, JustificativaFormada) :-
    pontos_por_perfil(PrimeiroPerfil, PontosGuardados, JustificativaGuardada),
    soma_pontos_perfis( RestoDosPerfis, PontosRestante, JustificativaRestante),
    SomaTotal is PontosGuardados + PontosRestante,
    append(JustificativaGuardada, JustificativaRestante, JustificativaFormada).

%Calcula o resultado de um único perfil a partir das respostas de s/n
pontos_por_perfil(perfil(Trilha, Caracteristica, Peso), Pontos, [Justificativa]) :-
    pergunta(ID, _, Caracteristica),
    resposta(ID, s), !,
    Pontos is Peso,
    swritef(Justificativa, 'Afinidade com %w (%w pts)', [Caracteristica, Peso]).

pontos_por_perfil(_, 0, []).

%Os dois predicados abaixo são para completar o recomenda, fazendo a ordenação e a separação das listas respectivamente
comparar_pontuacoes(Valor, [_Trilha1, Pontuacao1, _], [_Trilha2, Pontuacao2, _]) :-
    ( Pontuacao1 > Pontuacao2 -> Valor = '<'; 
    Pontuacao1 < Pontuacao2 -> Valor = '>';        
    Valor = '=').

separar_resultados([], [], []).
separar_resultados([[Trilha, Pontuacao, Justificativa] | RestoCompleto], [[Trilha, Pontuacao] | RestoPontuacoes], [[Trilha, Justificativa] | RestoJustificativas]) :-
    separar_resultados(RestoCompleto, RestoPontuacoes, RestoJustificativas).