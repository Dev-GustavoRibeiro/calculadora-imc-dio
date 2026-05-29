import 'dart:io';

import 'package:calculadora_imc_dio/calculadora_imc_dio.dart';

void main(List<String> arguments) {
  final registros = <RegistroIMC>[];

  print('========================================');
  print(' Calculadora de IMC - Desafio DIO');
  print('========================================');
  print('Cadastre uma ou mais pessoas para calcular o IMC.');

  while (true) {
    try {
      final registro = lerRegistroDoTerminal();
      registros.add(registro);

      print('');
      print('Resultado calculado com sucesso:');
      print(registro.resultadoFormatado());
      print('');
    } on FormatException catch (erro) {
      stderr.writeln('Erro: ${erro.message}');
    } on ArgumentError catch (erro) {
      stderr.writeln('Erro: ${erro.message}');
    }

    if (!desejaContinuar()) {
      break;
    }
  }

  print('');
  print(gerarListaResultados(registros));
}

RegistroIMC lerRegistroDoTerminal() {
  stdout.write('\nInforme o nome: ');
  final nome = stdin.readLineSync();

  stdout.write('Informe o peso em kg (ex: 70.5): ');
  final peso = converterEntradaNumerica(stdin.readLineSync(), 'peso');

  stdout.write('Informe a altura em metros (ex: 1.75): ');
  final altura = converterEntradaNumerica(stdin.readLineSync(), 'altura');

  return RegistroIMC(
    nome: validarTexto(nome, 'nome'),
    calculo: IMC(peso: peso, altura: altura),
  );
}

bool desejaContinuar() {
  while (true) {
    stdout.write('Deseja calcular outro IMC? (s/n): ');
    final resposta = stdin.readLineSync()?.trim().toLowerCase();

    if (resposta == 's' || resposta == 'sim') {
      return true;
    }

    if (resposta == 'n' || resposta == 'nao' || resposta == 'não') {
      return false;
    }

    print('Resposta inválida. Digite s para sim ou n para não.');
  }
}
