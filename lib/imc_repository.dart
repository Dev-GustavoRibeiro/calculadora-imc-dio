import 'package:hive/hive.dart';

import 'calculadora_imc_dio.dart';

class ImcRepository {
  ImcRepository({String? path}) : _path = path ?? '.imc_data';

  static const String _configBoxName = 'configuracoes_imc';
  static const String _historicoBoxName = 'historico_imc';
  static const String _alturaKey = 'altura';

  final String _path;
  late final Box<dynamic> _configuracoesBox;
  late final Box<dynamic> _historicoBox;

  Future<void> inicializar() async {
    Hive.init(_path);
    _configuracoesBox = await Hive.openBox<dynamic>(_configBoxName);
    _historicoBox = await Hive.openBox<dynamic>(_historicoBoxName);
  }

  double? buscarAlturaConfigurada() {
    final altura = _configuracoesBox.get(_alturaKey);

    if (altura == null) {
      return null;
    }

    if (altura is num) {
      return altura.toDouble();
    }

    return double.tryParse(altura.toString());
  }

  Future<void> salvarAltura(double altura) async {
    validarNumeroPositivo(altura, 'altura');
    await _configuracoesBox.put(_alturaKey, altura);
  }

  Future<void> salvarRegistro(RegistroIMC registro) async {
    await _historicoBox.add(registro.toMap());
  }

  List<RegistroIMC> listarRegistros() {
    return _historicoBox.values
        .whereType<Map<dynamic, dynamic>>()
        .map(RegistroIMC.fromMap)
        .toList();
  }

  Future<void> limparHistorico() async {
    await _historicoBox.clear();
  }

  Future<void> fechar() async {
    await _configuracoesBox.close();
    await _historicoBox.close();
  }
}
