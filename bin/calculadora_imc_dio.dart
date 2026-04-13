import 'dart:io';

import 'package:calculadora_imc_dio/calculadora_imc_dio.dart';

void main(List<String> arguments) {
  try {
    final pessoa = lerPessoaDoTerminal();

    print('');
    print('Resultado do calculo');
    print(pessoa.resultadoFormatado());
  } on FormatException catch (erro) {
    stderr.writeln('Erro: ${erro.message}');
    exitCode = 1;
  } on ArgumentError catch (erro) {
    stderr.writeln('Erro: ${erro.message}');
    exitCode = 1;
  }
}

Pessoa lerPessoaDoTerminal() {
  stdout.write('Informe o nome: ');
  final nome = stdin.readLineSync();

  stdout.write('Informe o peso em kg (ex: 70.5): ');
  final peso = converterEntradaNumerica(stdin.readLineSync(), 'peso');

  stdout.write('Informe a altura em metros (ex: 1.75): ');
  final altura = converterEntradaNumerica(stdin.readLineSync(), 'altura');

  return Pessoa(nome: validarTexto(nome, 'nome'), peso: peso, altura: altura);
}
