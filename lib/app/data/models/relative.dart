import 'dart:convert';

class Relative {
  Relative({
    required this.uuid,
    required this.relation,
    required this.relationId,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.fullName,
    required this.gender,
    required this.dateAndTimeOfBirth,
    required this.birthDetails,
    required this.birthPlace,
  });

  final String uuid;
  final String relation;
  final int relationId;
  final String firstName;
  final dynamic middleName;
  final String lastName;
  final String fullName;
  final String gender;
  final DateTime dateAndTimeOfBirth;
  final BirthDetails birthDetails;
  final BirthPlace birthPlace;

  factory Relative.fromJson(String str) => Relative.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Relative.fromMap(Map<String, dynamic> json) => Relative(
        uuid: json["uuid"],
        relation: json["relation"],
        relationId: json["relationId"],
        firstName: json["firstName"],
        middleName: json["middleName"],
        lastName: json["lastName"],
        fullName: json["fullName"],
        gender: json["gender"],
        dateAndTimeOfBirth: DateTime.parse(json["dateAndTimeOfBirth"]),
        birthDetails: BirthDetails.fromMap(json["birthDetails"]),
        birthPlace: BirthPlace.fromMap(json["birthPlace"]),
      );

  Map<String, dynamic> toMap() => {
        "uuid": uuid,
        "relation": relation,
        "relationId": relationId,
        "firstName": firstName,
        "middleName": middleName,
        "lastName": lastName,
        "fullName": fullName,
        "gender": gender,
        "dateAndTimeOfBirth": dateAndTimeOfBirth.toIso8601String(),
        "birthDetails": birthDetails.toMap(),
        "birthPlace": birthPlace.toMap(),
      };
}

class BirthDetails {
  BirthDetails({
    required this.dobYear,
    required this.dobMonth,
    required this.dobDay,
    required this.tobHour,
    required this.tobMin,
    required this.meridiem,
  });

  final int dobYear;
  final int dobMonth;
  final int dobDay;
  final int tobHour;
  final int tobMin;
  final String meridiem;

  factory BirthDetails.fromJson(String str) => BirthDetails.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BirthDetails.fromMap(Map<String, dynamic> json) => BirthDetails(
        dobYear: json["dobYear"],
        dobMonth: json["dobMonth"],
        dobDay: json["dobDay"],
        tobHour: json["tobHour"],
        tobMin: json["tobMin"],
        meridiem: json["meridiem"],
      );

  Map<String, dynamic> toMap() => {
        "dobYear": dobYear,
        "dobMonth": dobMonth,
        "dobDay": dobDay,
        "tobHour": tobHour,
        "tobMin": tobMin,
        "meridiem": meridiem,
      };
}

class BirthPlace {
  BirthPlace({
    required this.placeName,
    required this.placeId,
  });

  final String placeName;
  final String placeId;

  factory BirthPlace.fromJson(String str) => BirthPlace.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BirthPlace.fromMap(Map<String, dynamic> json) => BirthPlace(
        placeName: json["placeName"],
        placeId: json["placeId"],
      );

  Map<String, dynamic> toMap() => {
        "placeName": placeName,
        "placeId": placeId,
      };
}
