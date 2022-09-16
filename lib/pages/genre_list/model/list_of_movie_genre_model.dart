// To parse this JSON data, do
//
//     final ListOfMovieGenresModel = ListOfMovieGenresModelFromJson(jsonString);

import 'dart:convert';

ListOfMovieGenresModel listOfMovieGenresModelFromJson(String str) =>
    ListOfMovieGenresModel.fromJson(json.decode(str));

String listOfMovieGenresModelToJson(ListOfMovieGenresModel data) =>
    json.encode(data.toJson());

class ListOfMovieGenresModel {
  ListOfMovieGenresModel({
    required this.genres,
  });

  List<Genre>? genres;

  factory ListOfMovieGenresModel.fromJson(Map<String, dynamic> json) =>
      ListOfMovieGenresModel(
        genres: List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "genres": List<dynamic>.from(genres!.map((x) => x.toJson())),
      };
}

class Genre {
  Genre({
    required this.id,
    required this.name,
  });

  int id;
  String? name;

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
