class Pessoa {
  Pessoa({required String nome, required this.peso, required this.altura})
    : nome = validarTexto(nome, 'nome') {
    validarNumeroPositivo(peso, 'peso');
    validarNumeroPositivo(altura, 'altura');
  }

  final String nome;
  final double peso;
  final double altura;

  double get imc => calcularImc(peso: peso, altura: altura);

  String get classificacaoImc => classificarImc(imc);

  String resultadoFormatado() {
    final imcCalculado = imc;

    return '$nome, seu IMC é ${imcCalculado.toStringAsFixed(2)} '
        '- ${classificarImc(imcCalculado)}.';
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

String validarTexto(String? valor, String campo) {
  final texto = valor?.trim();

  if (texto == null || texto.isEmpty) {
    throw FormatException('O campo $campo nao pode ficar vazio.');
  }

  return texto;
}

double converterEntradaNumerica(String? valor, String campo) {
  final texto = validarTexto(valor, campo).replaceAll(',', '.');
  final numero = double.tryParse(texto);

  if (numero == null) {
    throw FormatException('Informe um numero valido para $campo.');
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
