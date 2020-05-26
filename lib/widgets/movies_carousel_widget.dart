import 'package:flutter/material.dart';
import 'package:movies/models/movie_model.dart';

class MovieCarousel extends StatelessWidget {
  final List<Movie> movies;

  MovieCarousel({@required this.movies});

  @override
  Widget build(BuildContext context) {
    final _screeSize = MediaQuery.of(context).size;
    return Container(
      height: _screeSize.height * 0.2,
      child: PageView(
        controller: PageController(
          initialPage: 1,
          viewportFraction: 0.3,
        ),
        pageSnapping: false,
        children: _cards(_screeSize, context),
      ),
    );
  }

  List<Widget> _cards(Size _screeSize, BuildContext context) {
    return movies.map((movie) {
      return Container(
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
    }).toList();
  }
}
