import 'dart:convert';

String timezoneToMap(Timezone data) => json.encode(data.toMap());

class Timezone {
  Timezone(
    this.abbrevation,
    this.zonename,
    this.location,
    this.offset,
  );

  String? abbrevation;
  String? zonename;
  String? location;
  Duration? offset;

  Map<String, dynamic> toMap() => {
        'abbrevation': abbrevation,
        'zonename': zonename,
        'location': location,
        'offset': offset.toString(),
      };
}
