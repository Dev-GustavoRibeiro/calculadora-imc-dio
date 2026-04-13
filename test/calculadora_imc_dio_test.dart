import 'package:calculadora_imc_dio/calculadora_imc_dio.dart';
import 'package:test/test.dart';

void main() {
  group('Pessoa', () {
    test('calcula e classifica o IMC', () {
      final pessoa = Pessoa(nome: 'Ana', peso: 65, altura: 1.70);

      expect(pessoa.imc, closeTo(22.49, 0.01));
      expect(pessoa.classificacaoImc, equals('Peso normal'));
      expect(
        pessoa.resultadoFormatado(),
        equals('Ana, seu IMC é 22.49 - Peso normal.'),
      );
    });

    test('remove espacos extras do nome', () {
      final pessoa = Pessoa(nome: '  Gustavo  ', peso: 80, altura: 1.80);

      expect(pessoa.nome, equals('Gustavo'));
    });

    test('lanca erro quando recebe dados invalidos', () {
      expect(
        () => Pessoa(nome: '', peso: 80, altura: 1.80),
        throwsA(isA<FormatException>()),
      );
      expect(
        () => Pessoa(nome: 'Gustavo', peso: 0, altura: 1.80),
        throwsA(isA<ArgumentError>()),
      );
      expect(
        () => Pessoa(nome: 'Gustavo', peso: 80, altura: -1.80),
        throwsA(isA<ArgumentError>()),
      );
    });
  });

  group('converterEntradaNumerica', () {
    test('aceita ponto e virgula como separador decimal', () {
      expect(converterEntradaNumerica('70.5', 'peso'), equals(70.5));
      expect(converterEntradaNumerica('1,75', 'altura'), equals(1.75));
    });

    test('lanca erro para texto vazio ou nao numerico', () {
      expect(
        () => converterEntradaNumerica('', 'peso'),
        throwsA(isA<FormatException>()),
      );
      expect(
        () => converterEntradaNumerica('abc', 'peso'),
        throwsA(isA<FormatException>()),
      );
      expect(
        () => converterEntradaNumerica('-10', 'peso'),
        throwsA(isA<ArgumentError>()),
      );
    });
  });

  group('classificarImc', () {
    final casos = <({double imc, String esperado})>[
      (imc: 18.49, esperado: 'Abaixo do peso'),
      (imc: 18.5, esperado: 'Peso normal'),
      (imc: 24.99, esperado: 'Peso normal'),
      (imc: 25, esperado: 'Sobrepeso'),
      (imc: 29.99, esperado: 'Sobrepeso'),
      (imc: 30, esperado: 'Obesidade grau I'),
      (imc: 34.99, esperado: 'Obesidade grau I'),
      (imc: 35, esperado: 'Obesidade grau II'),
      (imc: 39.99, esperado: 'Obesidade grau II'),
      (imc: 40, esperado: 'Obesidade grau III'),
    ];

    for (final caso in casos) {
      test('retorna ${caso.esperado} para IMC ${caso.imc}', () {
        expect(classificarImc(caso.imc), equals(caso.esperado));
      });
    }
  });
}
