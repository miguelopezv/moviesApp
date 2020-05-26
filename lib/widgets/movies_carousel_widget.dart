import 'package:flutter/material.dart';
import 'package:movies/models/movie_model.dart';

class MovieCarousel extends StatelessWidget {
  final List<Movie> movies;
  final Function nextPage;
  final _pageController = PageController(
    initialPage: 1,
    viewportFraction: 0.3,
  );

  MovieCarousel({@required this.movies, @required this.nextPage});

  @override
  Widget build(BuildContext context) {
    final _screeSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) {
        nextPage();
      }
    });

    return Container(
      height: _screeSize.height * 0.2,
      child: PageView.builder(
          controller: _pageController,
          pageSnapping: false,
          itemCount: movies.length,
          itemBuilder: (context, i) => _card(_screeSize, context, movies[i])),
    );
  }

  Widget _card(Size _screeSize, BuildContext context, Movie movie) {
    final _movieCard = Container(
      margin: EdgeInsets.only(right: 15),
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: FadeInImage(
              image: NetworkImage(movie.getPosterImg()),
              placeholder: AssetImage('assets/img/no-image.jpg'),
              fit: BoxFit.cover,
              height: _screeSize.height * 0.17,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            movie.title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          )
        ],
      ),
    );

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'details', arguments: movie);
      },
      child: _movieCard,
    );
  }
}
