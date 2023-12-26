// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, implicit_dynamic_list_literal

import 'dart:io';

import 'package:dart_frog/dart_frog.dart';


import '../routes/index.dart' as index;
import '../routes/websocket/index.dart' as websocket_index;
import '../routes/list/index.dart' as list_index;
import '../routes/items/index.dart' as items_index;
import '../routes/db/firebase/index.dart' as db_firebase_index;
import '../routes/db/firebase/[id].dart' as db_firebase_$id;
import '../routes/cache/redis/index.dart' as cache_redis_index;

import '../routes/_middleware.dart' as middleware;
import '../routes/db/firebase/_middleware.dart' as db_firebase_middleware;
import '../routes/cache/redis/_middleware.dart' as cache_redis_middleware;

void main() async {
  final address = InternetAddress.anyIPv6;
  final port = int.tryParse(Platform.environment['PORT'] ?? '8080') ?? 8080;
  createServer(address, port);
}

Future<HttpServer> createServer(InternetAddress address, int port) async {
  final handler = Cascade().add(buildRootHandler()).handler;
  final server = await serve(handler, address, port);
  print('\x1B[92m✓\x1B[0m Running on http://${server.address.host}:${server.port}');
  return server;
}

Handler buildRootHandler() {
  final pipeline = const Pipeline().addMiddleware(middleware.middleware);
  final router = Router()
    ..mount('/cache/redis', (context) => buildCacheRedisHandler()(context))
    ..mount('/db/firebase', (context) => buildDbFirebaseHandler()(context))
    ..mount('/items', (context) => buildItemsHandler()(context))
    ..mount('/list', (context) => buildListHandler()(context))
    ..mount('/websocket', (context) => buildWebsocketHandler()(context))
    ..mount('/', (context) => buildHandler()(context));
  return pipeline.addHandler(router);
}

Handler buildCacheRedisHandler() {
  final pipeline = const Pipeline().addMiddleware(cache_redis_middleware.middleware);
  final router = Router()
    ..all('/', (context) => cache_redis_index.onRequest(context,));
  return pipeline.addHandler(router);
}

Handler buildDbFirebaseHandler() {
  final pipeline = const Pipeline().addMiddleware(db_firebase_middleware.middleware);
  final router = Router()
    ..all('/', (context) => db_firebase_index.onRequest(context,))..all('/<id>', (context,id,) => db_firebase_$id.onRequest(context,id,));
  return pipeline.addHandler(router);
}

Handler buildItemsHandler() {
  final pipeline = const Pipeline();
  final router = Router()
    ..all('/', (context) => items_index.onRequest(context,));
  return pipeline.addHandler(router);
}

Handler buildListHandler() {
  final pipeline = const Pipeline();
  final router = Router()
    ..all('/', (context) => list_index.onRequest(context,));
  return pipeline.addHandler(router);
}

Handler buildWebsocketHandler() {
  final pipeline = const Pipeline();
  final router = Router()
    ..all('/', (context) => websocket_index.onRequest(context,));
  return pipeline.addHandler(router);
}

Handler buildHandler() {
  final pipeline = const Pipeline();
  final router = Router()
    ..all('/', (context) => index.onRequest(context,));
  return pipeline.addHandler(router);
}

