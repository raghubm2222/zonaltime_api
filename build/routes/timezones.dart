import 'package:dart_frog/dart_frog.dart';

import '../db/timezones.dart';

Response onRequest(RequestContext context) {
  final query = context.request.uri.queryParameters;
  final location = query['location'];
  final country = query['country'];

  return Response.json(
    body: Timezones.getZones(location: location, country: country)
        .map((e) => e.toMap())
        .toList(),
  );
}
