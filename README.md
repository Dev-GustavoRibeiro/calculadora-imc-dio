# Calculadora de IMC - DIO

Projeto de console em Dart criado para o desafio de IMC do curso de Flutter da DIO.

## Checklist do desafio

- Classe `Pessoa` com nome, peso e altura
- Leitura de dados pelo terminal
- Tratamento de excecoes para entradas invalidas
- Calculo do IMC
- Impressao do resultado na tela
- Testes automatizados

## Como executar

```bash
dart pub get
dart run
```

Depois, informe:

- Nome
- Peso em kg, por exemplo `70.5`
- Altura em metros, por exemplo `1.75`

## Como testar

```bash
dart test
```

## Classificacao usada

- Abaixo de 18.5: abaixo do peso
- 18.5 ate 24.9: peso normal
- 25 ate 29.9: sobrepeso
- 30 ate 34.9: obesidade grau I
- 35 ate 39.9: obesidade grau II
- 40 ou mais: obesidade grau III
