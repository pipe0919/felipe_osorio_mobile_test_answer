import 'package:flutter/material.dart';

import '../../../core/env/enviroment.dart';
import '../../../core/responsive/adapt.dart';
import '../../movie_detail/model/movie_detail_model.dart';
import '../../movie_detail/service/movie_detail_service.dart';
import '../../movie_detail/view/movie_detail_view.dart';
import '../model/movie_model.dart';
import '../service/popular_movie_service.dart';

class PopularMoviesView extends StatelessWidget {
  PopularMoviesView({super.key});

  final popularMovieService = PopularMovieService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PopularMovieListModel>(
        future: popularMovieService.getPopularMovies(),
        builder: (BuildContext context,
            AsyncSnapshot<PopularMovieListModel> snapshot) {
          if (snapshot.hasData) {
            return SizedBox(
              height: Adapt.screenH(),
              width: Adapt.screenW(),
              child: GridView.builder(
                padding: const EdgeInsets.only(left: 10, right: 10),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: Adapt.hp(40),
                  crossAxisSpacing: Adapt.wp(3),
                ),
                itemCount: snapshot.data!.results!.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () async {
                      final movieDetailInstance = MovieDetailService();
                      MovieInfoModel movieInfoModelToSend =
                          await movieDetailInstance
                              .getMoviesInfo(snapshot.data!.results![index].id);

                      // ignore: use_build_context_synchronously
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MovieDetailView(
                                    movieInfoModel: movieInfoModelToSend,
                                  )));
                    },
                    child: Column(
                      children: [
                        SizedBox(
                          height: Adapt.hp(1),
                        ),
                        Hero(
                          tag: '${snapshot.data!.results![index].posterPath}',
                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              height: Adapt.hp(30),
                              width: Adapt.wp(45),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30.0),
                                child: Image.network(
                                  '${Env.tmdbImage}${snapshot.data!.results![index].posterPath}',
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) {
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: Image.network(
                                        'https://png.pngtree.com/png-vector/20210227/ourlarge/pngtree-error-404-glitch-effect-png-image_2943478.jpg',
                                        fit: BoxFit.cover,
                                      ),
                                    );
                                  },
                                ),
                              )),
                        ),
                        SizedBox(
                          height: Adapt.hp(2),
                        ),
                        SizedBox(
                          height: Adapt.hp(6),
                          child: Text(
                            snapshot.data!.results![index].title.toString(),
                            style: TextStyle(
                              fontSize: Adapt.px(25),
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
