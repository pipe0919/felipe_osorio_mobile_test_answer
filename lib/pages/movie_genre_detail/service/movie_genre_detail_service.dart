import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../core/consts/const.dart';
import '../../../core/env/enviroment.dart';
import '../../popular_movies/model/movie_model.dart';

class MovieGendeDetailService {
  Future<PopularMovieListModel> getMovieGendeDetail(idGenre) async {
    String url = '${Env.tmdb}/discover/movie?with_genres=$idGenre';

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
