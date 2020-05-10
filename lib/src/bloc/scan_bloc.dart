import 'dart:async';

import 'package:qr_scanner/src/bloc/validators.dart';
import 'package:qr_scanner/src/providers/db_provider.dart';

class ScanBloc with Validators {
  static final ScanBloc _bloc = ScanBloc._internal();

  factory ScanBloc() {
    return _bloc;
  }

  ScanBloc._internal() {
    listar();
  }

  final _streamController = StreamController<List<ScanModel>>.broadcast();

  // Stream<List<ScanModel>> get getStream {
  //   listar();
  //   return _streamController.stream;
  // }

  Stream<List<ScanModel>> get getStreamGEO {
    listar();
    return _streamController.stream.transform(validarGEO);
  }

  Stream<List<ScanModel>> get getStreamHTTP {
    listar();
    return _streamController.stream.transform(validarHTTP);
  }

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
