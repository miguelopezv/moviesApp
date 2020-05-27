import 'package:flutter/material.dart';
import 'package:movies/models/actor_model.dart';
import 'package:movies/models/movie_model.dart';
import 'package:movies/providers/movies_providers.dart';

class DetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _appBar(movie),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(
                height: 10,
              ),
              _posterTitle(context, movie),
              _movieDescription(movie),
              _movieCast(movie.id)
            ]),
          )
        ],
      ),
    );
  }

  Widget _appBar(Movie movie) {
    return SliverAppBar(
      elevation: 2,
      backgroundColor: Colors.blueGrey[600],
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          movie.title,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        background: FadeInImage(
          image: NetworkImage(
            movie.getBGImg(),
          ),
          placeholder: AssetImage('assets/img/loading.gif'),
          fadeInDuration: Duration(milliseconds: 150),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _posterTitle(BuildContext context, Movie movie) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: <Widget>[
          Hero(
            tag: movie.id,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image(
                image: NetworkImage(movie.getPosterImg()),
                height: 159,
              ),
            ),
          ),
          SizedBox(width: 20),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  movie.title,
                  style: Theme.of(context).textTheme.headline6,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: <Widget>[
                    Icon(Icons.star_border),
                    Text(movie.voteAverage.toString(),
                        style: Theme.of(context).textTheme.subtitle1)
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _movieDescription(Movie movie) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Text(
        movie.overview,
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _movieCast(int id) {
    final _movieProvider = new MoviesProvider();
    return FutureBuilder(
      future: _movieProvider.getCast(id),
      builder: (BuildContext context, AsyncSnapshot<List<Actor>> snapshot) {
        if (snapshot.hasData) {
          return _createCarousel(snapshot.data);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _createCarousel(List<Actor> data) {
    return SizedBox(
      height: 220,
      child: PageView.builder(
        pageSnapping: false,
        itemCount: data.length,
        controller: PageController(
          viewportFraction: 0.3,
          initialPage: 1,
        ),
        itemBuilder: (context, i) => _actorCard(data[i]),
      ),
    );
  }

  Widget _actorCard(Actor actor) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: FadeInImage(
                image: NetworkImage(actor.getPhoto()),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                height: 180,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(
            actor.name,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
