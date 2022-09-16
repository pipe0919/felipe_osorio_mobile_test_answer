import 'package:flutter/material.dart';

import '../../../core/env/enviroment.dart';
import '../../../core/responsive/adapt.dart';
import '../../movie_detail/model/movie_detail_model.dart';
import '../../movie_detail/service/movie_detail_service.dart';
import '../../movie_detail/view/movie_detail_view.dart';
import '../../popular_movies/model/movie_model.dart';
import '../service/movie_genre_detail_service.dart';

// ignore: must_be_immutable
class MovieGenreDetailView extends StatelessWidget {
  MovieGenreDetailView(
      {super.key, required this.idGenre, required this.tittle});
  int idGenre;
  String tittle;

  final popularMovieService = MovieGendeDetailService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(111, 19, 19, 19),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(Adapt.px(80)),
          child: Hero(
            tag: idGenre,
            child: AppBar(
              backgroundColor: Colors.black,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                color: const Color.fromARGB(255, 133, 133, 133),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text(
                tittle,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        body: body(),
      ),
    );
  }

  Widget body() {
    return FutureBuilder<PopularMovieListModel>(
        future: popularMovieService.getMovieGendeDetail(idGenre),
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
                  mainAxisExtent: Adapt.hp(45),
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
                          height: Adapt.hp(2),
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
                                borderRadius: BorderRadius.circular(20.0),
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
