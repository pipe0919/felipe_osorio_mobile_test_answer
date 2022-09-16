import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../core/consts/const.dart';
import '../../../core/env/enviroment.dart';
import '../model/movie_model.dart';

class PopularMovieService {
  Future<PopularMovieListModel> getPopularMovies() async {
    String url = '${Env.tmdb}/movie/popular';

    final res = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json;charset=utf-8',
        'Authorization': 'Bearer ${Consts.token}',
      },
    );

    dynamic respuesta = json.decode(res.body);

    PopularMovieListModel popularMovieListModel =
        PopularMovieListModel.fromJson(
      respuesta,
    );

    return popularMovieListModel;
  }
}
