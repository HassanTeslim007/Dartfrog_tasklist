import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:firedart/firedart.dart';

Future<Response> onRequest(RequestContext context, String id) async {
  return switch (context.request.method) {
    HttpMethod.patch => _updateList(context, id),
    HttpMethod.delete => _deleteList(context, id),
    _ => Future.value(Response(statusCode: HttpStatus.methodNotAllowed))
  };
}

Future<Response> _updateList(RequestContext context, String listId) async {
  final body = await context.request.json() as Map<String, dynamic>;
  final name = body['name'] as String?;
  await Firestore.instance
      .collection('tasklists')
      .document(listId)
      .update({'name': name});
  return Response(statusCode: HttpStatus.noContent, body: 'Updated list name');
}

Future<Response> _deleteList(RequestContext context, String listId) async {
  await Firestore.instance
      .collection('tasklists')
      .document(listId)
      .delete()
      .then(
        (value) =>
            Response(statusCode: HttpStatus.noContent, body: 'List deleted'),
        onError: (e) => Response(statusCode: HttpStatus.badRequest),
      );
  return Response(statusCode: HttpStatus.badRequest);
}
