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
  bool _isRealLocation = false;

  @override
  void initState() {
    super.initState();
    _checkGps();
  }

  Future<void> _checkGps() async {
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      ConnectivityResult connectivityResult = await (Connectivity().checkConnectivity());

      double accuracy = position.accuracy;

      // Verificar si la precisión del GPS es buena (menor a 50 metros)
      if (accuracy <= 50) {
        _isRealLocation = true;
      } else {
        _isRealLocation = false;
      }

      setState(() {
        _gpsStatus = _isRealLocation
            ? 'Ubicación verdadera. Latitud: ${position.latitude}, Longitud: ${position.longitude}, Precisión: ${position.accuracy} metros, Conectividad: $connectivityResult'
            : 'Ubicación falsa o inexacta. Latitud: ${position.latitude}, Longitud: ${position.longitude}, Precisión: ${position.accuracy} metros, Conectividad: $connectivityResult';
      });
    } catch (e) {
      setState(() {
        _gpsStatus = 'Error al obtener la ubicación: $e';
      });
    }
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
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
