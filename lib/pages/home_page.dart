import 'package:flutter/material.dart';
import 'package:movies/providers/movies_providers.dart';
import 'package:movies/widgets/card_swiper_widget.dart';
import 'package:movies/widgets/movies_carousel_widget.dart';

class HomePage extends StatelessWidget {
  final _moviesProvider = new MoviesProvider();

  @override
  Widget build(BuildContext context) {
    _moviesProvider.getPopular();

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Movies'),
        backgroundColor: Colors.blueGrey,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[_cardSwiper(), _footer(context)],
        ),
      ),
    );
  }

  Widget _cardSwiper() {
    return FutureBuilder(
      future: _moviesProvider.getNowPlaying(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return CardSwiperWidget(
            list: snapshot.data,
          );
        } else {
          return Container(
              height: 400,
              child: Center(
                child: CircularProgressIndicator(),
              ));
        }
      },
    );
  }

  Widget _footer(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              'Most popular',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          SizedBox(height: 5),
          StreamBuilder(
            stream: _moviesProvider.popularsStream,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if (snapshot.hasData) {
                return MovieCarousel(
                  movies: snapshot.data,
                  nextPage: _moviesProvider.getPopular,
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }
}
