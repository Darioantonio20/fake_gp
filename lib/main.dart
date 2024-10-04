import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GPS Checker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _gpsStatus = 'Desconocido';

  @override
  void initState() {
    super.initState();
    _checkGps();
  }

  Future<void> _checkGps() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    ConnectivityResult connectivityResult = await (Connectivity().checkConnectivity());

    // Aquí puedes agregar lógica adicional para comparar la ubicación GPS con la ubicación de la red
    // Por simplicidad, solo estamos mostrando la ubicación GPS
    setState(() {
      _gpsStatus = 'Latitud: ${position.latitude}, Longitud: ${position.longitude}, Conectividad: $connectivityResult';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GPS Checker'),
      ),
      body: Center(
        child: Text(
          'Estado del GPS: $_gpsStatus',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}