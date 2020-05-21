import 'package:flutter/material.dart';
import 'package:movies/widgets/card_swiper_widget.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          children: <Widget>[_cardSwiper()],
        ),
      ),
    );
  }

  Widget _cardSwiper() {
    return CardSwiperWidget(
      list: [1, 2, 3, 4, 5],
    );
  }
}
