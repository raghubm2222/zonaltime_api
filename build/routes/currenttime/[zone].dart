import 'package:dart_frog/dart_frog.dart';

import '../../db/timezones.dart';

Response onRequest(RequestContext context, String? zone) {
  final dateTime = DateTime.now().toUtc();
  final to = context.request.uri.queryParameters['to'];

  if (zone == null && to == null) {
    return Response.json(
      body: {
        'current_time': dateTime.toIso8601String(),
        'abbrevation': dateTime.timeZoneName,
      },
    );
  }

  if (zone != null && to == null) {
    final zonename = zone.toUpperCase();
    final zones = Timezones.getTimezonesByAbbreviation(zonename);
    return Response.json(
      body: zones
          .map(
            (zone) => {
              ...zone.toMap(),
              'current_time': dateTime.add(zone.offset!).toIso8601String(),
            },
          )
          .toList(),
    );
  }

  if (zone != null && to != null) {
    final zonename = zone.toUpperCase();
    final fromZones = Timezones.getTimezonesByAbbreviation(zonename);
    final toZones = Timezones.getTimezonesByAbbreviation(to.toUpperCase());

    if (fromZones.isEmpty || toZones.isEmpty) {
      return Response(body: 'Invalid timezone abbreviation', statusCode: 400);
    }

    final results = fromZones
        .map(
          (fromZone) => toZones
              .map(
                (toZone) => {
                  'from': {
                    'abbrevation': fromZone.abbrevation,
                    'zonename': fromZone.zonename,
                  },
                  'to': {
                    'abbrevation': toZone.abbrevation,
                    'zonename': toZone.zonename,
                  },
                  'current_time': dateTime
                      .subtract(fromZone.offset! - toZone.offset!)
                      .toIso8601String(),
                },
              )
              .toList()
            ..removeWhere(
              (element) {
                final from = element['from']! as Map;
                final to = element['to']! as Map;
                return from['abbrevation'] == to['abbrevation'] &&
                    from['zonename'] == to['zonename'];
              },
            ),
        )
        .toList();
    return Response.json(body: results.expand((x) => x).toList());
  }

  return Response(
    statusCode: 400,
    body: 'Bad Request',
  );
}
