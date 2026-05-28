class IMC {
  IMC({required this.peso, required this.altura}) {
    validarNumeroPositivo(peso, 'peso');
    validarNumeroPositivo(altura, 'altura');
  }

  final double peso;
  final double altura;

  double get valor => calcularImc(peso: peso, altura: altura);

  String get classificacao => classificarImc(valor);

  String get valorFormatado => valor.toStringAsFixed(2);
}

class RegistroIMC {
  RegistroIMC({required String nome, required this.calculo, DateTime? criadoEm})
    : nome = validarTexto(nome, 'nome'),
      criadoEm = criadoEm ?? DateTime.now();

  final String nome;
  final IMC calculo;
  final DateTime criadoEm;

  double get peso => calculo.peso;

  double get altura => calculo.altura;

  double get imc => calculo.valor;

  String get imcFormatado => calculo.valorFormatado;

  String get classificacao => calculo.classificacao;

  String resultadoFormatado() {
    return '$nome, seu IMC é $imcFormatado - $classificacao.';
  }
}

class Pessoa {
  Pessoa({required String nome, required double peso, required double altura})
    : nome = validarTexto(nome, 'nome'),
      _calculo = IMC(peso: peso, altura: altura);

  final String nome;
  final IMC _calculo;

  double get peso => _calculo.peso;

  double get altura => _calculo.altura;

  double get imc => _calculo.valor;

  String get classificacaoImc => _calculo.classificacao;

  String resultadoFormatado() {
    return '$nome, seu IMC é ${_calculo.valorFormatado} - $classificacaoImc.';
  }

  RegistroIMC toRegistro() {
    return RegistroIMC(nome: nome, calculo: _calculo);
  }
}

double calcularImc({required double peso, required double altura}) {
  validarNumeroPositivo(peso, 'peso');
  validarNumeroPositivo(altura, 'altura');

  return peso / (altura * altura);
}

String classificarImc(double imc) {
  validarNumeroPositivo(imc, 'imc');

  if (imc < 18.5) {
    return 'Abaixo do peso';
  }

  if (imc < 25) {
    return 'Peso normal';
  }

  if (imc < 30) {
    return 'Sobrepeso';
  }

  if (imc < 35) {
    return 'Obesidade grau I';
  }

  if (imc < 40) {
    return 'Obesidade grau II';
  }

  return 'Obesidade grau III';
}

String gerarListaResultados(List<RegistroIMC> registros) {
  if (registros.isEmpty) {
    return 'Nenhum IMC calculado ainda.';
  }

  const separador = '------------------------------------------------------------------------';
  final buffer = StringBuffer()
    ..writeln(separador)
    ..writeln('Lista de resultados de IMC')
    ..writeln(separador)
    ..writeln(' # | Nome                 | Peso    | Altura | IMC   | Classificação')
    ..writeln(separador);

  for (var index = 0; index < registros.length; index++) {
    buffer.writeln(formatarLinhaResultado(index + 1, registros[index]));
  }

  buffer.write(separador);
  return buffer.toString();
}

String formatarLinhaResultado(int numero, RegistroIMC registro) {
  final nome = limitarTexto(registro.nome, 20).padRight(20);
  final peso = '${registro.peso.toStringAsFixed(1)} kg'.padLeft(7);
  final altura = '${registro.altura.toStringAsFixed(2)} m'.padLeft(6);
  final imc = registro.imcFormatado.padLeft(5);

  return '${numero.toString().padLeft(2)} | $nome | $peso | $altura | $imc | '
      '${registro.classificacao}';
}

String limitarTexto(String texto, int limite) {
  if (texto.length <= limite) {
    return texto;
  }

  if (limite <= 3) {
    return texto.substring(0, limite);
  }

  return '${texto.substring(0, limite - 3)}...';
}

String validarTexto(String? valor, String campo) {
  final texto = valor?.trim();

  if (texto == null || texto.isEmpty) {
    throw FormatException('O campo $campo não pode ficar vazio.');
  }

  return texto;
}

double converterEntradaNumerica(String? valor, String campo) {
  final texto = validarTexto(valor, campo).replaceAll(',', '.');
  final numero = double.tryParse(texto);

  if (numero == null) {
    throw FormatException('Informe um número válido para $campo.');
  }

  validarNumeroPositivo(numero, campo);

  return numero;
}

void validarNumeroPositivo(num valor, String campo) {
  if (valor <= 0) {
    throw ArgumentError.value(
      valor,
      campo,
      'O campo $campo deve ser maior que zero.',
    );
  }
}
