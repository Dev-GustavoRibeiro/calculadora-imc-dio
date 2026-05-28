import 'package:calculadora_imc_dio/calculadora_imc_dio.dart';
import 'package:test/test.dart';

void main() {
  group('IMC', () {
    test('calcula e classifica o IMC a partir de peso e altura', () {
      final imc = IMC(peso: 65, altura: 1.70);

      expect(imc.valor, closeTo(22.49, 0.01));
      expect(imc.valorFormatado, equals('22.49'));
      expect(imc.classificacao, equals('Peso normal'));
    });

    test('lanca erro quando recebe peso ou altura invalidos', () {
      expect(() => IMC(peso: 0, altura: 1.80), throwsA(isA<ArgumentError>()));
      expect(() => IMC(peso: 80, altura: -1.80), throwsA(isA<ArgumentError>()));
    });
  });

  group('RegistroIMC', () {
    test('monta resultado formatado com nome, valor e classificacao', () {
      final registro = RegistroIMC(
        nome: 'Ana',
        calculo: IMC(peso: 65, altura: 1.70),
      );

      expect(registro.imc, closeTo(22.49, 0.01));
      expect(registro.classificacao, equals('Peso normal'));
      expect(
        registro.resultadoFormatado(),
        equals('Ana, seu IMC é 22.49 - Peso normal.'),
      );
    });

    test('remove espacos extras do nome', () {
      final registro = RegistroIMC(
        nome: '  Gustavo  ',
        calculo: IMC(peso: 80, altura: 1.80),
      );

      expect(registro.nome, equals('Gustavo'));
    });

    test('lanca erro quando recebe nome invalido', () {
      expect(
        () => RegistroIMC(nome: '', calculo: IMC(peso: 80, altura: 1.80)),
        throwsA(isA<FormatException>()),
      );
    });
  });

  group('Pessoa', () {
    test('mantem compatibilidade com a estrutura anterior', () {
      final pessoa = Pessoa(nome: 'Ana', peso: 65, altura: 1.70);

      expect(pessoa.imc, closeTo(22.49, 0.01));
      expect(pessoa.classificacaoImc, equals('Peso normal'));
      expect(
        pessoa.resultadoFormatado(),
        equals('Ana, seu IMC é 22.49 - Peso normal.'),
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

  group('gerarListaResultados', () {
    test('retorna mensagem quando lista esta vazia', () {
      expect(gerarListaResultados([]), equals('Nenhum IMC calculado ainda.'));
    });

    test('gera lista formatada com os resultados calculados', () {
      final registros = [
        RegistroIMC(nome: 'Ana', calculo: IMC(peso: 65, altura: 1.70)),
        RegistroIMC(nome: 'Carlos', calculo: IMC(peso: 92, altura: 1.75)),
      ];

      final lista = gerarListaResultados(registros);

      expect(lista, contains('Lista de resultados de IMC'));
      expect(lista, contains('Ana'));
      expect(lista, contains('Carlos'));
      expect(lista, contains('22.49'));
      expect(lista, contains('30.04'));
      expect(lista, contains('Obesidade grau I'));
    });
  });
}
