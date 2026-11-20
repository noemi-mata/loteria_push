import '../dominio/api_juego.dart';
import '../dominio/puerto_push.dart';

/// Versión SIN Firebase: no hay notificaciones push.
/// El controlador ve "permiso denegado" y la app juega consultando al
/// servidor cada 5 s (la degradación elegante del manual).
class PuertoSinPush implements PuertoPush {
  @override
  Future<PermisoPush> estadoPermiso() async => PermisoPush.denegado;

  @override
  Future<PermisoPush> pedirPermiso() async => PermisoPush.denegado;

  @override
  Future<DestinoPush?> obtenerDestino() async => null;

  @override
  Stream<DestinoPush> get destinoCambiado => const Stream.empty();

  @override
  Stream<MensajePush> get enPrimerPlano => const Stream.empty();

  @override
  Stream<MensajePush> get alAbrirDesdeNotificacion => const Stream.empty();

  @override
  Future<MensajePush?> mensajeInicial() async => null;

  @override
  Future<void> suscribirTema(String tema) async {}

  @override
  Future<void> desuscribirTema(String tema) async {}
}
