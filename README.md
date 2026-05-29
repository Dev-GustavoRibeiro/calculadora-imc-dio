# Calculadora de IMC - DIO

Projeto de console em Dart criado para o desafio de IMC do curso de Flutter da DIO.

A aplicação lê os dados pelo terminal, calcula o IMC e exibe todos os resultados cadastrados em formato de lista, deixando o projeto mais completo para o portfólio no GitHub.

## Checklist do desafio

- Classe `IMC` com peso e altura
- Leitura de dados pelo terminal
- Cálculo do IMC
- Classificação automática do resultado
- Exibição dos resultados em formato de lista
- Validação de entradas inválidas
- Suporte para cadastrar várias pessoas na mesma execução
- Testes automatizados

## Estrutura principal

```text
bin/
  calculadora_imc_dio.dart        # Entrada da aplicação e leitura dos dados
lib/
  calculadora_imc_dio.dart        # Classes, regras de negócio e validações
test/
  calculadora_imc_dio_test.dart   # Testes automatizados
```

## Como executar

```bash
dart pub get
dart run
```

Depois, informe:

- Nome
- Peso em kg, por exemplo `70.5`
- Altura em metros, por exemplo `1.75`

Ao final de cada cálculo, o app pergunta se você deseja cadastrar outro IMC. Quando a resposta for `n`, todos os resultados são exibidos em lista.

## Exemplo de uso

```text
========================================
 Calculadora de IMC - Desafio DIO
========================================
Cadastre uma ou mais pessoas para calcular o IMC.

Informe o nome: Gustavo
Informe o peso em kg (ex: 70.5): 70
Informe a altura em metros (ex: 1.75): 1.75

Resultado calculado com sucesso:
Gustavo, seu IMC é 22.86 - Peso normal.

Deseja calcular outro IMC? (s/n): n

------------------------------------------------------------------------
Lista de resultados de IMC
------------------------------------------------------------------------
 # | Nome                 | Peso    | Altura | IMC   | Classificação
------------------------------------------------------------------------
 1 | Gustavo              | 70.0 kg | 1.75 m | 22.86 | Peso normal
------------------------------------------------------------------------
```

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
