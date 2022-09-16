import 'package:felipe_osorio_mobile_test_answer/pages/genre_list/service/list_of_movie_genre_service.dart';
import 'package:flutter/material.dart';

import '../../../core/responsive/adapt.dart';
import '../../movie_genre_detail/view/movie_genre_detail_view.dart';
import '../model/list_of_movie_genre_model.dart';

class ListOfMovieGenresView extends StatelessWidget {
  ListOfMovieGenresView({super.key});
  final listOfMovieGenresInstance = ListOfMovieGenresService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder<ListOfMovieGenresModel>(
          future: listOfMovieGenresInstance.getlistOfMovieGenres(),
          builder: (BuildContext context,
              AsyncSnapshot<ListOfMovieGenresModel> snapshot) {
            if (snapshot.hasData) {
              return ListView.custom(
                  childrenDelegate: SliverChildBuilderDelegate(
                childCount: snapshot.data!.genres!.length,
                (BuildContext context, int index) {
                  return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MovieGenreDetailView(
                                      idGenre: snapshot.data!.genres![index].id,
                                      tittle: snapshot.data!.genres![index].name
                                          .toString(),
                                    )));
                      },
                      child: Hero(
                        tag: snapshot.data!.genres![index].id,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          color: const Color.fromARGB(20, 0, 0, 0),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(left: Adapt.px(30)),
                            height: Adapt.hp(8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  snapshot.data!.genres![index].name.toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: Adapt.px(45)),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
                                  size: Adapt.px(45),
                                )
                              ],
                            ),
                          ),
                        ),
                      ));
                },
              ));
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
