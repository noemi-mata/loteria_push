import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'dominio/controlador.dart';
import 'infra/almacen_prefs.dart';
import 'infra/api_http.dart';
import 'infra/puerto_sin_push.dart';
import 'presentacion/vms.dart';

// 10.0.2.2 es el "localhost" de tu computadora visto desde el emulador de Android.
// En un teléfono real usa la IP de tu computadora (misma red wifi), p. ej. http://192.168.1.50:8080
const String urlServidor = String.fromEnvironment('SERVIDOR', defaultValue: 'http://10.0.2.2:8080');

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final api = ApiHttp(urlServidor);
  final almacen = AlmacenPrefs(await SharedPreferences.getInstance());
  final controlador = ControladorPartida(api: api, push: PuertoSinPush(), almacen: almacen);

  // Un solo cantor para toda la app: si cierras su pantalla, sigue cantando
  // (así puedes ser cantor y jugador en el mismo emulador).
  final cantor = CantorVm(api);

  runApp(AppLoteria(vm: JuegoVm(controlador), crearCantor: () => cantor));
}
