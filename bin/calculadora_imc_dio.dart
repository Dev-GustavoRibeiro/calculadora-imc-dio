import 'dart:io';

import 'package:calculadora_imc_dio/calculadora_imc_dio.dart';
import 'package:calculadora_imc_dio/imc_repository.dart';

Future<void> main(List<String> arguments) async {
  final repository = ImcRepository();
  await repository.inicializar();

  print('========================================');
  print(' Calculadora de IMC - Desafio DIO');
  print(' Persistência local com Hive');
  print('========================================');

  try {
    while (true) {
      mostrarMenu();
      final opcao = stdin.readLineSync()?.trim();

      switch (opcao) {
        case '1':
          await configurarAltura(repository);
        case '2':
          await calcularESalvarImc(repository);
        case '3':
          listarHistorico(repository);
        case '4':
          await limparHistorico(repository);
        case '0':
          print('Aplicação encerrada. Bons estudos!');
          return;
        default:
          print('Opção inválida. Tente novamente.');
      }
    }
  } finally {
    await repository.fechar();
  }
}

void mostrarMenu() {
  print('');
  print('Escolha uma opção:');
  print('1 - Configurar altura');
  print('2 - Calcular IMC');
  print('3 - Exibir histórico salvo');
  print('4 - Limpar histórico');
  print('0 - Sair');
  stdout.write('Opção: ');
}

Future<void> configurarAltura(ImcRepository repository) async {
  try {
    stdout.write('\nInforme sua altura em metros (ex: 1.75): ');
    final altura = converterEntradaNumerica(stdin.readLineSync(), 'altura');

    await repository.salvarAltura(altura);
    print('Altura configurada com sucesso: ${altura.toStringAsFixed(2)} m');
  } on FormatException catch (erro) {
    stderr.writeln('Erro: ${erro.message}');
  } on ArgumentError catch (erro) {
    stderr.writeln('Erro: ${erro.message}');
  }
}

Future<void> calcularESalvarImc(ImcRepository repository) async {
  try {
    final alturaConfigurada = repository.buscarAlturaConfigurada();

    if (alturaConfigurada == null) {
      print('Nenhuma altura configurada. Configure sua altura antes de calcular o IMC.');
      await configurarAltura(repository);
    }

    final altura = repository.buscarAlturaConfigurada();

    if (altura == null) {
      print('Não foi possível calcular o IMC sem uma altura configurada.');
      return;
    }

    stdout.write('\nInforme o nome: ');
    final nome = validarTexto(stdin.readLineSync(), 'nome');

    stdout.write('Informe o peso em kg (ex: 70.5): ');
    final peso = converterEntradaNumerica(stdin.readLineSync(), 'peso');

    final registro = RegistroIMC(
      nome: nome,
      calculo: IMC(peso: peso, altura: altura),
    );

    await repository.salvarRegistro(registro);

    print('');
    print('Resultado calculado e salvo com sucesso:');
    print(registro.resultadoFormatado());
  } on FormatException catch (erro) {
    stderr.writeln('Erro: ${erro.message}');
  } on ArgumentError catch (erro) {
    stderr.writeln('Erro: ${erro.message}');
  }
}

void listarHistorico(ImcRepository repository) {
  final registros = repository.listarRegistros();

  print('');
  print(gerarListaResultados(registros));
}

Future<void> limparHistorico(ImcRepository repository) async {
  stdout.write('\nTem certeza que deseja limpar o histórico? (s/n): ');
  final resposta = stdin.readLineSync()?.trim().toLowerCase();

  if (resposta == 's' || resposta == 'sim') {
    await repository.limparHistorico();
    print('Histórico removido com sucesso.');
    return;
  }

  print('Operação cancelada.');
}
