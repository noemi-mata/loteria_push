import 'package:flutter_test/flutter_test.dart';
import 'package:loteria_push/dominio/almacen.dart';
import 'package:loteria_push/dominio/controlador.dart';
import 'package:loteria_push/dominio/puerto_push.dart';
import 'package:loteria_push/infra/puerto_sin_push.dart';

import 'falsos.dart';

void main() {
  test('sin Firebase: nunca hay permiso, destino ni mensaje inicial', () async {
    final p = PuertoSinPush();
    expect(await p.estadoPermiso(), PermisoPush.denegado);
    expect(await p.pedirPermiso(), PermisoPush.denegado);
    expect(await p.obtenerDestino(), isNull);
    expect(await p.mensajeInicial(), isNull);
  });

  test('con PuertoSinPush se juega sin avisos, consultando al servidor', () async {
    final api = ApiFalsa();
    final c = ControladorPartida(api: api, push: PuertoSinPush(), almacen: AlmacenMemoria());
    await c.unirse(sala: 'ABCDE', nombre: 'Ana');
    expect(c.avisosActivos, isFalse);
    expect(api.destinoAlUnirse, isNull);

    api.cartasServidor.add(carta(1, 10));
    await c.sincronizar();
    expect(c.partida!.ultima, 1);
    await c.cerrar();
  });
}
