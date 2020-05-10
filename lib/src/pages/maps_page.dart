import 'package:flutter/material.dart';

import 'package:qr_scanner/src/bloc/scan_bloc.dart';

import 'package:qr_scanner/src/models/scan_model.dart';

import 'package:qr_scanner/src/utils/utils.dart' as utils;

class MapsPage extends StatelessWidget {
  final bloc = ScanBloc();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: bloc.getStream,
        builder:
            (BuildContext context, AsyncSnapshot<List<ScanModel>> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final lista = snapshot.data;

          return ListView.builder(
            itemCount: lista.length,
            itemBuilder: (context, index) {
              return Dismissible(
                key: UniqueKey(),
                background: Container(color: Colors.red),
                onDismissed: (direction) => bloc.eliminar(lista[index].id),
                child: ListTile(
                  leading: Icon(Icons.open_in_browser),
                  title: Text(lista[index].valor),
                  subtitle: Text(
                      'ID: ${lista[index].id} | TYPE: ${lista[index].tipo}'),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    if (lista[index].tipo == 'http')
                      utils.launchURL(lista[index].valor);
                    else
                      Navigator.pushNamed(context, 'map',
                          arguments: lista[index]);
                  },
                ),
              );
            },
          );
        });
  }
}
