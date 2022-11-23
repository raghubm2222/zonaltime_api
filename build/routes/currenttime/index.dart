import 'package:dart_frog/dart_frog.dart';

Response onRequest(RequestContext context) {
  final dateTime = DateTime.now().toUtc();
  return Response.json(
    body: {
      'current_time': dateTime.toIso8601String(),
      'abbrevation': dateTime.timeZoneName,
    },
  );
}
