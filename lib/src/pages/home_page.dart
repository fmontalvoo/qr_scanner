import 'package:flutter/material.dart';

import 'package:qr_scanner/src/pages/address_page.dart';
import 'package:qr_scanner/src/pages/map_page.dart';

import 'package:barcode_scan/barcode_scan.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scanner'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.delete_forever), onPressed: () {})
        ],
      ),
      body: _loadPage(index),
      bottomNavigationBar: _bottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.filter_center_focus), onPressed: _scanQR),
    );
  }

  Widget _loadPage(int index) {
    switch (index) {
      case 0:
        return MapPage();
      case 1:
        return AddressPage();
      default:
        return null;
    }
  }

  Widget _bottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: index,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.map), title: Text('Mapas')),
        BottomNavigationBarItem(
            icon: Icon(Icons.directions), title: Text('Direcciones')),
      ],
      onTap: (i) {
        setState(() {
          index = i;
        });
      },
    );
  }

  _scanQR() async {
    // geo:-0.19243346655079838,-78.45815077265628
    dynamic scan = '';
    try {
      scan = await BarcodeScanner.scan();
    } catch (e) {
      scan = e.toString();
    }
    print('QR>${scan.rawContent}');
  }
}
