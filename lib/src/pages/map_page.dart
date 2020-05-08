import 'package:flutter/material.dart';
import 'package:qr_scanner/src/providers/db_provider.dart';

class MapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: DBProvider.db.listar(),
        builder:
            (BuildContext context, AsyncSnapshot<List<ScanModel>> snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());

          final lista = snapshot.data;

          return ListView.builder(
            itemCount: lista.length,
            itemBuilder: (context, index) {
              return Dismissible(
                key: UniqueKey(),
                background: Container(color: Colors.red),
                onDismissed: (direction) =>
                    DBProvider.db.eliminar(lista[index].id),
                child: ListTile(
                  title: Text(lista[index].valor),
                ),
              );
            },
          );
        });
  }
}
