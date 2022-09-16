import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../core/consts/const.dart';
import '../../../core/env/enviroment.dart';
import '../model/list_of_movie_genre_model.dart';

class ListOfMovieGenresService {
  Future<ListOfMovieGenresModel> getlistOfMovieGenres() async {
    String url = '${Env.tmdb}/genre/movie/list';

    final res = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json;charset=utf-8',
        'Authorization': 'Bearer ${Consts.token}',
      },
    );

    dynamic respuesta = json.decode(res.body);

    ListOfMovieGenresModel listOfMovieGenres = ListOfMovieGenresModel.fromJson(
      respuesta,
    );

    return listOfMovieGenres;
  }
}
