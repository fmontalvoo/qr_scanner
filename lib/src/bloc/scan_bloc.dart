import 'dart:async';

import 'package:qr_scanner/src/providers/db_provider.dart';

class ScanBloc {
  static final ScanBloc _bloc = ScanBloc._internal();

  factory ScanBloc() {
    return _bloc;
  }

  ScanBloc._internal(){
    listar();
  }

  final _streamController = StreamController<List<ScanModel>>.broadcast();

  Stream<List<ScanModel>> get getStream => _streamController.stream;

  void dispose() {
    _streamController?.close();
  }

  void crear(ScanModel model) async {
    await DBProvider.db.crear(model);
    listar();
  }

  void listar() async {
    _streamController.sink.add(await DBProvider.db.listar());
  }

  void eliminar(int id) async {
    await DBProvider.db.eliminar(id);
    listar();
  }

  void eliminarRegistros() async {
    await DBProvider.db.eliminarRegistros();
    listar();
  }
}
