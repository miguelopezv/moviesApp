import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movies/models/movie_model.dart';

class CardSwiperWidget extends StatelessWidget {
  final List<Movie> list;

  CardSwiperWidget({@required this.list});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 10),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          list[index].uniqueId = '${list[index].id}-swiper';

          return Hero(
            tag: list[index].uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, 'details',
                      arguments: list[index]);
                },
                child: FadeInImage(
                  image: NetworkImage(list[index].getPosterImg()),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
        itemCount: list.length,
        itemWidth: _screenSize.width * 0.7,
        itemHeight: _screenSize.height * 0.5,
        layout: SwiperLayout.STACK,
      ),
    );
  }
}
