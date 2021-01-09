import 'dart:convert';

Past pastFromMap(String str) => Past.fromMap(json.decode(str));

String pastToMap(Past data) => json.encode(data.toMap());

class Past {
  Past({
    this.status,
    this.events,
  });

  bool status;
  List<Event> events;

  factory Past.fromMap(Map<String, dynamic> json) => Past(
    status: json["status"] == null ? null : json["status"],
    events: json["events"] == null ? null : List<Event>.from(json["events"].map((x) => Event.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "status": status == null ? null : status,
    "events": events == null ? null : List<dynamic>.from(events.map((x) => x.toMap())),
  };
}

class Event {
  Event({
    this.date,
    this.title,
    this.description,
    this.from,
    this.to,
    this.location,
    this.bannerImage,
    this.usersAttending,
  });

  DateTime date;
  String title;
  String description;
  String from;
  String to;
  String location;
  String bannerImage;
  List<String> usersAttending;

  factory Event.fromMap(Map<String, dynamic> json) => Event(
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    title: json["title"] == null ? null : json["title"],
    description: json["description"] == null ? null : json["description"],
    from: json["from"] == null ? null : json["from"],
    to: json["to"] == null ? null : json["to"],
    location: json["location"] == null ? null : json["location"],
    bannerImage: json["banner_image"] == null ? null : json["banner_image"],
    usersAttending: json["users_attending"] == null ? null : List<String>.from(json["users_attending"].map((x) => x)),
  );

  Map<String, dynamic> toMap() => {
    "date": date == null ? null : date.toIso8601String(),
    "title": title == null ? null : title,
    "description": description == null ? null : description,
    "from": from == null ? null : from,
    "to": to == null ? null : to,
    "location": location == null ? null : location,
    "banner_image": bannerImage == null ? null : bannerImage,
    "users_attending": usersAttending == null ? null : List<dynamic>.from(usersAttending.map((x) => x)),
  };
}
