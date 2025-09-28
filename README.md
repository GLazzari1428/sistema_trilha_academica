# Sistema Especialista para Recomendação de Trilha Acadêmica

## Informações Institucionais
- **Disciplina:** Programação Lógica e Funcional
- **Intituição:** Pontifícia Universidade Católica do Paraná    
- **Professor:** Frank Coelho de Alcantara
- **Turma:** U
- **Equipe:** 7

### Membros da equipe

| Nome Completo | Usuário GitHub |
| :--- | :--- |
| `Gustavo Tasca Lazzari` | `@GLazzari1428` |
| `Mateus Roese Tucunduva`| `@Matizuuu`     |
| `Matheus Yamamoto Dias` | `@MatheusYamas` |
| `Victor Ryuki Tamezava` | `@VicRuk`       |


---

## 1. Objetivo do Projeto

Este projeto consiste no desenvolvimento de um Sistema Especialista em Prolog, projetado para auxiliar estudantes de tecnologia na escolha de uma trilha de especialização acadêmica. Utilizando uma base de conhecimento com regras e fatos predefinidos, o sistema aplica um motor de inferência para analisar o perfil do usuário, calcular a compatibilidade com as trilhas disponíveis e, ao final, apresentar um ranking de recomendações com as respectivas justificativas. Além disso o sistema conta com um modo de teste, que permite realizar um teste rápido da funcionalidade lógica do sistema.

---

## 2. Funcionalidades
O sistema foi implementado com as seguintes funcionalidades:
- **Interação com o usuário:** O sistema interage com o usuário por meio de um questionário dinâmico para coletar suas preferências, habilidades e afinidades.
- **Motor de Inferência:** Utiliza regras para processar as respostas e calcular a compatibilidade do perfil do aluno com cada trilha de especialização.
- **Ranking de Recomendações:** Apresenta uma lista ordenada das trilhas mais compatíveis.
- **Justificativas por trilha**: Apresenta quais respostas do usuário levaram a cada sugestão de trilha.
- **Modo de Teste:** Permite a execução automatizada com perfis de teste pré-definidos para validar a lógica do sistema.


---

## 3. Estrutura do Repositório

O projeto está organizado da seguinte forma para facilitar a navegação e o entendimento:

```bash
.
├── base_conhecimento.pl # Fatos e regras que definem a lógica do sistema.
├── main.pl              # Contém o motor de inferência principal do sistema.
├── ui.pl                # Responsável pela interface de usuário e fluxo de execução.
├── perfis-de-teste/     # Contém os arquivos de perfil para o modo de teste.
│   ├── perfil_1.pl
│   ├── perfil_2.pl
│   └── perfil_3.pl
└── README.md            # Descrição completa do projeto.
```

---

## 4. Como Executar

Para executar o projeto é necessário ter instalado localmente um ambiente de Prolog. Abaixo um link para um tutorial de instalação:
>[Tutorial de instalação para Windows, Linux e MacOS.](https://wwu-pi.github.io/tutorials/lectures/lsp/010_install_swi_prolog.html)

Após instalado, utilize o comando abaixo para acessar o ambiente de prolog:

```prolog
[user@machine ~]$ swipl
Welcome to SWI-Prolog (threaded, 64 bits, version 9.2.9)
SWI-Prolog comes with ABSOLUTELY NO WARRANTY. This is free software.
Please run ?- license. for legal details.

For online help and background, visit https://www.swi-prolog.org
For built-in help, use ?- help(Topic). or ?- apropos(Word).

?- 
```
### 4.1. Modo Interativo
O primeiro passo para iniciar o programa no modo interativo é inicializar as funções `ui.pl` e `main.pl` dentro do ambiente prolog, utilizando o seguinte comando:

```prolog
?- [main, ui].
true. %se tiver este output, o programa foi inicializado corretamente
```
Após isso é só executar o comando "`iniciar.`" no ambiente prolog, e responder as perguntas com `s` (sim) ou `n` (não). E após isso será mostrado um relatório com as recomendações de acordo com as respostas do usuário. Abaixo um exemplo prático do funcionamento do modo interativo:

```prolog
?- iniciar.

Sistema Especialista: Trilha Academica
Grupo 7: Gustavo Lazari, Mateus Roese Tucunduva, Matheus Yamomoto Dias, Victor Ryuki Tamezava
-----------------------------------------------------
(1/20) Voce tem afinidade com matematica? (s/n): s
(2/20) Voce gosta de logica e raciocinio? (s/n): s
(3/20) Voce tem interesse em programacao? (s/n): s
(4/20) Voce aprecia design e criatividade visual? (s/n): n
(5/20) Voce tem atencao a detalhes? (s/n): n
(6/20) Voce gosta de trabalhar com redes e infraestrutura? (s/n): s
(7/20) Voce gosta de analisar e interpretar dados? (s/n): n
(8/20) Voce tem facilidade com estatistica? (s/n): n
(9/20) Voce gosta de resolver problemas tecnicos? (s/n): s
(10/20) Voce entende de hardware? (s/n): s
(11/20) Voce se interessa por automacao de processos? (s/n): s
(12/20) Voce tem conhecimentos em computacao em nuvem? (s/n): s
(13/20) Voce tem criatividade para design e desenvolvimento de jogos? (s/n): n
(14/20) Voce tem interesse e conhecimento em aprendizado de maquina? (s/n): n
(15/20) Voce se interessa por usabilidade e experiencia do usuario? (s/n): n
(16/20) Voce gosta de trabalhar pensando na seguranca com criptografia? (s/n): n
(17/20) Voce tem facilidade para criar visualizacoes de dados claras e uteis? (s/n): n
(18/20) Voce sabe configurar servidores e gerenciar servicos? (s/n): s
(19/20) Voce tem experiencia com gerenciamento de configuracoes em sistemas? (s/n): s
(20/20) Voce gosta de trabalhar com design de som e efeitos para jogos? (s/n): n

=== Recomendacoes (ordem de compatibilidade) ===
1) redes_e_infraestrutura  | Pontos: 18
    Gerenciamento de redes, servidores e infraestrutura de TI.
2) devops  | Pontos: 16
    Automatizacao de processos de desenvolvimento e operacoes de software.
3) inteligencia_artificial  | Pontos: 13
    Desenvolvimento de sistemas inteligentes e aprendizado de maquina.
4) seguranca_da_informacao  | Pontos: 8
    Protecao de dados e sistemas contra ameacas digitais.
5) desenvolvimento_web  | Pontos: 3
    Criacao e manutencao de sites e aplicacoes web.

--- Justificativas por trilha ---
> redes_e_infraestrutura:
   - Afinidade com redes (5 pts)
   - Afinidade com hardware (4 pts)
   - Afinidade com resolucao_problemas (4 pts)
   - Afinidade com configuracao_servidores (5 pts)
> devops:
   - Afinidade com automatizacao (5 pts)
   - Afinidade com conhecimento_cloud (4 pts)
   - Afinidade com programacao (3 pts)
   - Afinidade com gerenciamento_de_configuracoes (4 pts)
> inteligencia_artificial:
   - Afinidade com matematica (5 pts)
   - Afinidade com logica (4 pts)
   - Afinidade com programacao (4 pts)
> seguranca_da_informacao:
   - Afinidade com logica (4 pts)
   - Afinidade com redes (4 pts)
> desenvolvimento_web:
   - Afinidade com programacao (3 pts)

-----------------------------------------------------
Concluido.

true.

```

### 4.2. Modo de Teste
Assim como no modo interativo, o primeiro passo para iniciar o programa em modo de teste é inicializar as funções `ui.pl` e `main.pl` dentro do ambiente prolog, utilizando o comando "`[main, ui].`". Após isso pode-se utilizar um dos comandos abaixo para realizar uma rotina de testes para um dos 3 perfis:

```prolog
?- modo_teste('perfis-de-teste/perfil_1.pl'). %perfil 1
?- modo_teste('perfis-de-teste/perfil_2.pl'). %perfil 2
?- modo_teste('perfis-de-teste/perfil_3.pl'). %perfil 3
```
Abaixo um exemplo da execução do modo de teste, utilizando o `perfil_1`:

```prolog
?- modo_teste('perfis-de-teste/perfil_1.pl'). %perfil 1

Sistema Especialista: Trilha Academica
Grupo 7: Gustavo Lazari, Mateus Roese Tucunduva, Matheus Yamomoto Dias, Victor Ryuki Tamezava
-----------------------------------------------------
% Executando em modo de teste com respostas pré-carregadas.

=== Recomendacoes (ordem de compatibilidade) ===
1) inteligencia_artificial  | Pontos: 18
    Desenvolvimento de sistemas inteligentes e aprendizado de maquina.
2) seguranca_da_informacao  | Pontos: 9
    Protecao de dados e sistemas contra ameacas digitais.
3) devops  | Pontos: 8
    Automatizacao de processos de desenvolvimento e operacoes de software.
4) desenvolvimento_web  | Pontos: 7
    Criacao e manutencao de sites e aplicacoes web.
5) redes_e_infraestrutura  | Pontos: 4
    Gerenciamento de redes, servidores e infraestrutura de TI.
6) jogos_digitais  | Pontos: 3
    Desenvolvimento e design de jogos eletronicos para diversas plataformas.

--- Justificativas por trilha ---
> inteligencia_artificial:
   - Afinidade com matematica (5 pts)
   - Afinidade com logica (4 pts)
   - Afinidade com programacao (4 pts)
   - Afinidade com aprendizado_maquina (5 pts)
> seguranca_da_informacao:
   - Afinidade com logica (4 pts)
   - Afinidade com atencao_a_detalhes (5 pts)
> devops:
   - Afinidade com automatizacao (5 pts)
   - Afinidade com programacao (3 pts)
> desenvolvimento_web:
   - Afinidade com programacao (3 pts)
   - Afinidade com usabilidade (4 pts)
> redes_e_infraestrutura:
   - Afinidade com resolucao_problemas (4 pts)
> jogos_digitais:
   - Afinidade com programacao (3 pts)

-----------------------------------------------------
Concluido.

true.
```

---

## 5. Base de Conhecimento

### 5.1 Trilhas de Especialização

A base contém estas 7 trilhas de especialização:

- *Inteligência Artificial*
- *Desinvolvimento Web*
- *Segurança da Informação*
- *Ciência de Dados*
- *Redes e Infraestrutura*
- *DevOps*
- *Jogos Digitais*

### 5.2 Características de Perfil e Pesos

Cada trilha está associada a um conjunto de habilidades e interesses, cada um com um peso de relevância (1 a 5) que indica sua importância para aquela trilha específica.

* **Exemplo em Prolog:**
    ```prolog
    % Características de perfil (trilha, habilidade/interesse, peso)
    perfil(inteligencia_artificial, matematica, 5).
    perfil(desenvolvimento_web, design_visual, 4).
    ```

### 5.3 Perguntas

As perguntas são utilizadas para mapear os interesses do usuário às características de perfil definidas.

* **Exemplo em Prolog:**
    ```prolog
    % Perguntas para o usuário (id, texto da pergunta, característica associada)
    pergunta(1, 'Voce tem afinidade com matematica?', matematica).
    pergunta(4, 'Voce aprecia design e criatividade visual?', design_visual).
    ```