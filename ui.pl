:- module(ui,
    [ iniciar/0
    , faz_perguntas/0
    , exibe_resultado/1
    , modo_teste/1
    ]).

:- dynamic user:resposta/2.
:- dynamic justificativa_trilha/2.

% iniciar/0
iniciar :-
    banner,
    faz_perguntas,
    obter_ranking(Ranking),
    nl, exibe_resultado(Ranking),
    nl, rodape.

banner :-
    nl,
    writeln('Sistema Especialista: Trilha Academica'),
    writeln('Grupo 7: Gustavo Lazari, Mateus Roese Tucunduva, Matheus Yamomoto Dias, Victor Ryuki Tamezava'),
    writeln('-----------------------------------------------------').

rodape :-
    writeln('-----------------------------------------------------'),
    writeln('Concluido.'), nl.

% faz_perguntas/0
faz_perguntas :-
    findall(Id-Texto-Caracteristica, pergunta(Id, Texto, Caracteristica), L0),
    sort(L0, Pergs),
    length(Pergs, Total),
    perguntar_lista(Pergs, 1, Total).

perguntar_lista([], _, _).
perguntar_lista([Id-Texto-Caracteristica|R], N, Total) :-
    retractall(user:resposta(Id,_)),
    format('(~d/~d) ~w (s/n): ', [N, Total, Texto]),
    flush_output,
    ler_sn(RespSN),
    assertz(user:resposta(Id, RespSN)),
    _ = Caracteristica,
    N1 is N+1,
    perguntar_lista(R, N1, Total).

% Respostas
ler_sn(Resp) :-
    read_line_to_string(user_input, S0),
    (   S0 == end_of_file -> S = ""
    ;   normalize_space(string(S), S0)
    ),
    string_lower(S, L),
    (   L == ""                       -> invalido(Resp)
    ;   sub_string(L, 0, 1, _, "s")   -> Resp = s
    ;   sub_string(L, 0, 1, _, "y")   -> Resp = s
    ;   sub_string(L, 0, 1, _, "n")   -> Resp = n
    ;   member(L, ["sim","yes"])      -> Resp = s
    ;   member(L, ["nao","não","no"]) -> Resp = n
    ;   invalido(Resp)
    ).

invalido(Resp) :-
    writeln('Entrada invalida. Use s/n (ou sim/nao).'),
    ler_sn(Resp).

% calcula
obter_ranking(RankingOut) :-
    limpar_justificativas_,
    % Coleta [Trilha,Pontos,Justificativa]
    findall([T,P,J],
            ( trilha(T,_),
              calcula_pontuacao(T, P, J)
            ),
            Triples),
    % Armazena justificativas para exibição
    assert_justificativas_from_triples(Triples),
    % Extrai pares T-P e ordena desc
    pares_trilha_pontos(Triples, Pares),
    predsort(cmp_pontos_desc, Pares, RankingOut).

cmp_pontos_desc(Ord, _-P1, _-P2) :- compare(C, P2, P1), Ord = C.

pares_trilha_pontos([], []).
pares_trilha_pontos([[T,P,_J]|R], [T-P|RR]) :-
    pares_trilha_pontos(R, RR).

assert_justificativas_from_triples([]).
assert_justificativas_from_triples([[T,_P,J]|R]) :-
    retractall(justificativa_trilha(T,_)),
    assertz(justificativa_trilha(T, J)),
    assert_justificativas_from_triples(R).

% exibe_resultado/1

exibe_resultado([]) :-
    writeln('Nenhuma trilha pontuada. Verifique a base/motor.').
exibe_resultado(Ranking) :-
    writeln('=== Recomendacoes (ordem de compatibilidade) ==='),
    exibe_linhas(Ranking, 1),
    nl,
    (   tem_justificativas
    ->  writeln('--- Justificativas por trilha ---'),
        exibe_justificativas(Ranking)
    ;   true ).

exibe_linhas([], _).
exibe_linhas([Trilha-P|R], N) :-
    (   trilha(Trilha, Desc) -> true ; Desc = '' ),
    format('~d) ~w  | Pontos: ~w~n    ~w~n', [N, Trilha, P, Desc]),
    N1 is N+1, exibe_linhas(R, N1).

tem_justificativas :- current_predicate(justificativa_trilha/2).

exibe_justificativas([]).
exibe_justificativas([Trilha-_|R]) :-
    (   justificativa_trilha(Trilha, Motivos)
    ->  exibe_motivos(Trilha, Motivos)
    ;   true ),
    exibe_justificativas(R).

exibe_motivos(Trilha, Motivos) :-
    format('> ~w:~n', [Trilha]),
    (   is_list(Motivos)
    ->  forall(member(M, Motivos), format('   - ~w~n', [M]))
    ;   format('   - ~w~n', [Motivos]) ).

% modo_teste

modo_teste(ArquivoPerfil) :-
    banner,
    retractall(user:resposta(_,_)),
    (   exists_file(ArquivoPerfil)
    ->  writeln('% Executando em modo de teste com respostas pré-carregadas.'),
        user:consult(ArquivoPerfil)
    ;   format('Arquivo de perfil nao encontrado: ~w~n', [ArquivoPerfil]), fail
    ),
    findall(_, user:resposta(_,_), Rs), length(Rs, Qtd),
    (   Qtd =:= 0 -> writeln('% AVISO: nenhuma resposta/2 foi carregada do arquivo de teste.')
    ;   true
    ),
    obter_ranking(Ranking),
    nl, exibe_resultado(Ranking),
    nl, rodape.
limpar_justificativas_ :- retractall(justificativa_trilha(_,_)).
