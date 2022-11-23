// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, implicit_dynamic_list_literal

import 'dart:io';

import 'package:dart_frog/dart_frog.dart';


import '../routes/timezones.dart' as timezones;
import '../routes/index.dart' as index;
import '../routes/currenttime/index.dart' as currenttime_index;
import '../routes/currenttime/[zone].dart' as currenttime_$zone;


void main() => createServer();

Future<HttpServer> createServer() async {
  final ip = InternetAddress.anyIPv4;
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final handler = Cascade().add(buildRootHandler()).handler;
  final server = await serve(handler, ip, port);
  print('\x1B[92m✓\x1B[0m Running on http://${server.address.host}:${server.port}');
  return server;
}

Handler buildRootHandler() {
  final pipeline = const Pipeline();
  final router = Router()
    ..mount('/currenttime', (context) => buildCurrenttimeHandler()(context))
    ..mount('/', (context) => buildHandler()(context));
  return pipeline.addHandler(router);
}

Handler buildCurrenttimeHandler() {
  final pipeline = const Pipeline();
  final router = Router()
    ..all('/', (context) => currenttime_index.onRequest(context,))..all('/<zone>', (context,zone,) => currenttime_$zone.onRequest(context,zone,));
  return pipeline.addHandler(router);
}

Handler buildHandler() {
  final pipeline = const Pipeline();
  final router = Router()
    ..all('/timezones', (context) => timezones.onRequest(context,))..all('/', (context) => index.onRequest(context,));
  return pipeline.addHandler(router);
}
