import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../core/consts/const.dart';
import '../../../core/env/enviroment.dart';
import '../model/movie_detail_model.dart';

class MovieDetailService {
  Future<MovieInfoModel> getMoviesInfo(idMovie) async {
    String url = '${Env.tmdb}/movie/$idMovie';

    final res = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json;charset=utf-8',
        'Authorization': 'Bearer ${Consts.token}',
      },
    );

    dynamic respuesta = json.decode(res.body);

    MovieInfoModel movieInfoModel = MovieInfoModel.fromJson(
      respuesta,
    );

    return movieInfoModel;
  }
}
