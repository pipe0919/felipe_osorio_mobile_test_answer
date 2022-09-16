import 'package:flutter/material.dart';

import '../../../core/env/enviroment.dart';
import '../../../core/responsive/adapt.dart';
import '../model/movie_detail_model.dart';

// ignore: must_be_immutable
class MovieDetailView extends StatelessWidget {
  MovieDetailView({super.key, required this.movieInfoModel});
  MovieInfoModel movieInfoModel;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.amber,
            ),
            color: const Color.fromARGB(255, 133, 133, 133),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            'Informacion de la pelicula',
            style: TextStyle(color: Colors.amber),
          ),
        ),
        body: Stack(
          children: [
            Opacity(
              opacity: 0.15,
              child: Container(
                height: Adapt.screenH(),
                width: Adapt.screenW(),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      '${Env.tmdbImage}${movieInfoModel.posterPath}',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            body(),
          ],
        ),
      ),
    );
  }

  Widget body() {
    return Center(
      child: SingleChildScrollView(
        child: SizedBox(
          width: Adapt.screenW(),
          child: Column(
            children: [
              Hero(
                tag: movieInfoModel.posterPath.toString(),
                child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    height: Adapt.hp(58),
                    width: Adapt.wp(100),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image.network(
                        '${Env.tmdbImage}${movieInfoModel.posterPath}',
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
                height: Adapt.hp(8),
                child: Text(
                  '${movieInfoModel.title.toString()} (${movieInfoModel.releaseDate.toString().split('-')[0]}) | ${movieInfoModel.voteAverage!.toStringAsFixed(1)}',
                  style: TextStyle(
                    fontSize: Adapt.px(35),
                    color: Colors.amber,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                height: Adapt.hp(5),
                alignment: Alignment.center,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: Adapt.px(20)),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Center(
                        child: Text(
                      movieInfoModel.genres![index].name.toString(),
                      style: TextStyle(
                        fontSize: Adapt.px(30),
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ));
                  },
                  itemCount: movieInfoModel.genres!.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(width: Adapt.px(30));
                  },
                ),
              ),
              SizedBox(
                height: Adapt.hp(3),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: Adapt.px(20)),
                child: Text(
                  movieInfoModel.overview.toString(),
                  style: TextStyle(
                    fontSize: Adapt.px(30),
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: Adapt.hp(3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
