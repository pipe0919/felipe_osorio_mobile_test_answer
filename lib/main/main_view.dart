import 'package:flutter/material.dart';

import '../core/consts/const.dart';
import '../core/responsive/adapt.dart';
import '../../pages/genre_list/view/list_of_movie_genre_view.dart';
import '../pages/popular_movies/view/popular_movies_view.dart';
import '../widgets/surprice_animation_widget.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  bool _seeSurprice = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meridian Movie',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(secondary: const Color.fromARGB(110, 0, 0, 0)),
      ),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            leadingWidth: Adapt.wp(10),
            actions: [
              SizedBox(
                  width: Adapt.wp(10),
                  child: GestureDetector(
                    child: Icon(
                      Icons.circle,
                      color: Colors.black,
                      size: Adapt.px(40),
                    ),
                    onLongPress: () {
                      _seeSurprice = !_seeSurprice;
                      setState(() {});
                    },
                  ))
            ],
            backgroundColor: Colors.black,
            title: Center(
              child: Text(
                'Meridian Movie',
                style: TextStyle(
                  fontSize: Adapt.px(40),
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            bottom: const TabBar(
              indicatorColor: Colors.amber,
              labelColor: Colors.amber,
              unselectedLabelColor: Colors.white,
              tabs: [
                Tab(
                  text: 'Populares de la Semana',
                ),
                Tab(
                  text: 'Categorías',
                ),
              ],
            ),
          ),
          body: !_seeSurprice
              ? Stack(
                  children: [
                    Opacity(
                      opacity: 0.2,
                      child: Container(
                        height: Adapt.screenH(),
                        width: Adapt.screenW(),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(Consts.netwotkImageMainView),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    TabBarView(
                      children: [
                        PopularMoviesView(),
                        ListOfMovieGenresView(),
                      ],
                    ),
                  ],
                )
              : const Center(child: SurpriceAnimatedWidget()),
        ),
      ),
    );
  }
}
