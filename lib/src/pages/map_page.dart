import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:qr_scanner/src/models/scan_model.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final MapController mapController = MapController();

  final List<String> mapID = <String>[
    'streets',
    'dark',
    'light',
    'outdoors',
    'satellite'
  ];

  int index = 0;

  @override
  Widget build(BuildContext context) {
    final ScanModel scan = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Mapa: ${mapID[index]}'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.my_location),
              onPressed: () => mapController.move(scan.getLatLng(), 15))
        ],
      ),
      body: Container(child: _showMap(scan)),
      floatingActionButton: _floatingActionButton(),
    );
  }

  Widget _showMap(ScanModel model) {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(center: model.getLatLng(), zoom: 15),
      layers: [_layers(), _marker(model)],
    );
  }

  TileLayerOptions _layers() {
    return TileLayerOptions(
        urlTemplate: 'https://api.mapbox.com/v4/'
            '{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}',
        additionalOptions: {
          'accessToken':
              '',
          'id': 'mapbox.${mapID[index]}'
        });
  }

  MarkerLayerOptions _marker(ScanModel model) {
    return MarkerLayerOptions(markers: <Marker>[
      Marker(
          width: 100.0,
          height: 10.0,
          point: model.getLatLng(),
          builder: (context) => Container(
                child: Icon(
                  Icons.location_on,
                  size: 70.0,
                  color: Theme.of(context).primaryColor,
                ),
              ))
    ]);
  }

  Widget _floatingActionButton() {
    return FloatingActionButton(
        child: Icon(Icons.repeat),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          setState(() {
            if (index <= mapID.length) index++;
            if (index >= mapID.length) index = 0;
          });
        });
  }
}
