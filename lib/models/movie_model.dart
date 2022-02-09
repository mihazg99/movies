// To parse this JSON data, do
//
//     final movieModel = movieModelFromJson(jsonString);

import 'dart:convert';

MovieModel movieModelFromJson(String str) => MovieModel.fromJson(json.decode(str));

String movieModelToJson(MovieModel data) => json.encode(data.toJson());

class MovieModel {
  MovieModel({
    this.data,
  });

  List<Datum>? data;

  factory MovieModel.fromJson(Map<String, dynamic> json) => MovieModel(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.attributes,
  });

  int? id;
  DatumAttributes? attributes;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    attributes: DatumAttributes.fromJson(json["attributes"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "attributes": attributes!.toJson(),
  };
}

class DatumAttributes {
  DatumAttributes({
    this.name,
    this.publicationYear,
    this.poster,
  });

  String? name;
  int? publicationYear;
  Poster? poster;

  factory DatumAttributes.fromJson(Map<String, dynamic> json) => DatumAttributes(
    name: json["name"],
    publicationYear: json["publicationYear"],
    poster: Poster.fromJson(json["poster"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "publicationYear": publicationYear,
    "poster": poster!.toJson(),
  };
}

class Poster {
  Poster({
    this.data,
  });

  Data? data;

  factory Poster.fromJson(Map<String, dynamic> json) => Poster(
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data!.toJson(),
  };
}

class Data {
  Data({
    this.id,
    this.attributes,
  });

  int? id;
  DataAttributes? attributes;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    attributes: DataAttributes.fromJson(json["attributes"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "attributes": attributes!.toJson(),
  };
}

class DataAttributes {
  DataAttributes({
    this.url,
  });

  String? url;

  factory DataAttributes.fromJson(Map<String, dynamic> json) => DataAttributes(
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
  };
}
