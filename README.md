# Calculadora de IMC - DIO

Projeto de console em Dart criado para os desafios de IMC do curso de Flutter da DIO.

Nesta versão, a aplicação foi incrementada com persistência local usando **Hive**. O usuário configura a altura uma única vez em uma área de configurações, informa o peso durante o cálculo e o sistema salva o histórico de IMCs calculados localmente.

## Checklist do desafio

- Classe `IMC` com peso e altura
- Altura lida em tela/menu de configurações
- Leitura de dados pelo app
- Cálculo do IMC
- Gravação dos dados no Hive
- Exibição dos resultados em formato de lista
- Validação de entradas inválidas
- Histórico persistido localmente
- Testes automatizados

## Estrutura principal

```text
bin/
  calculadora_imc_dio.dart        # Entrada da aplicação, menu, leitura dos dados e fluxo do app
lib/
  calculadora_imc_dio.dart        # Classes, regras de negócio, validações e serialização
  imc_repository.dart             # Repositório local usando Hive
test/
  calculadora_imc_dio_test.dart   # Testes automatizados
```

## Tecnologias utilizadas

- Dart
- Hive
- Test
- Lints

## Como executar

```bash
dart pub get
dart run
```

Ao executar, o app exibirá um menu com as seguintes opções:

```text
1 - Configurar altura
2 - Calcular IMC
3 - Exibir histórico salvo
4 - Limpar histórico
0 - Sair
```

## Fluxo de uso

1. Acesse a opção `1 - Configurar altura`.
2. Informe sua altura em metros, por exemplo `1.75`.
3. Acesse a opção `2 - Calcular IMC`.
4. Informe o nome e o peso.
5. O app calcula o IMC e salva o registro no Hive.
6. Acesse a opção `3 - Exibir histórico salvo` para visualizar a lista de resultados persistidos.

## Exemplo de uso

```text
========================================
 Calculadora de IMC - Desafio DIO
 Persistência local com Hive
========================================

Escolha uma opção:
1 - Configurar altura
2 - Calcular IMC
3 - Exibir histórico salvo
4 - Limpar histórico
0 - Sair
Opção: 1

Informe sua altura em metros (ex: 1.75): 1.75
Altura configurada com sucesso: 1.75 m

Escolha uma opção:
1 - Configurar altura
2 - Calcular IMC
3 - Exibir histórico salvo
4 - Limpar histórico
0 - Sair
Opção: 2

Informe o nome: Gustavo
Informe o peso em kg (ex: 70.5): 70

Resultado calculado e salvo com sucesso:
Gustavo, seu IMC é 22.86 - Peso normal.

Escolha uma opção:
1 - Configurar altura
2 - Calcular IMC
3 - Exibir histórico salvo
4 - Limpar histórico
0 - Sair
Opção: 3

------------------------------------------------------------------------
Lista de resultados de IMC
------------------------------------------------------------------------
 # | Nome                 | Peso    | Altura | IMC   | Classificação
------------------------------------------------------------------------
 1 | Gustavo              | 70.0 kg | 1.75 m | 22.86 | Peso normal
------------------------------------------------------------------------
```

## Persistência local

A persistência foi implementada com Hive por meio do arquivo `lib/imc_repository.dart`.

O projeto utiliza duas caixas locais:

- `configuracoes_imc`: armazena a altura configurada pelo usuário.
- `historico_imc`: armazena os registros de IMC calculados.

Os dados são gravados localmente na pasta `.imc_data`, criada automaticamente durante a execução da aplicação.

## Como testar

```bash
dart test
```

## Classificação usada

- Abaixo de 18.5: abaixo do peso
- 18.5 até 24.9: peso normal
- 25 até 29.9: sobrepeso
- 30 até 34.9: obesidade grau I
- 35 até 39.9: obesidade grau II
- 40 ou mais: obesidade grau III
