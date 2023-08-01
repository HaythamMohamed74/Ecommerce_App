import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';

import '../layoutCubit/layout_cubit.dart';

class CarsolSliderBuilder extends StatelessWidget {
  const CarsolSliderBuilder({
    super.key,
    required this.bannerLength,
    required this.cubit,
  });

  final int bannerLength;
  final LayoutCubit cubit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 180,
      child: CarouselSlider.builder(
        // carouselController: _controller,
        itemCount: bannerLength,
        options: CarouselOptions(
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          aspectRatio: 16 / 9,
          viewportFraction: 0.8,
          enlargeCenterPage: true,
        ),
        itemBuilder: (BuildContext context, int index, int realIndex) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 1),
            child: Image.network(
              cubit.bannerslist[index].img,
              fit: BoxFit.fill,
              errorBuilder: (BuildContext, Object, StackTrace) {
                return CupertinoActivityIndicator();
              },
            ),
          );
        },
      ),
    );
  }
}
