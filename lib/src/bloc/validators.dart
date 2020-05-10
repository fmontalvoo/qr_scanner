import 'dart:async';

import 'package:qr_scanner/src/models/scan_model.dart';

class Validators {
  final validarGEO =
      StreamTransformer<List<ScanModel>, List<ScanModel>>.fromHandlers(
          handleData: (scans, sink) {
    final geo = scans.where((s) => s.tipo == 'geo').toList();
    sink.add(geo);
  });

  final validarHTTP =
      StreamTransformer<List<ScanModel>, List<ScanModel>>.fromHandlers(
          handleData: (scans, sink) {
    final http = scans.where((s) => s.tipo == 'http').toList();
    sink.add(http);
  });
}
