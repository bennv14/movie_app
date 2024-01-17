import 'package:flutter/material.dart';
import 'package:movie_app/core/constants/constants.dart';

class Carousel extends StatefulWidget {
  final List<Widget> widgets;
  final double height;
  final Function? onAddPage;
  const Carousel({super.key, required this.widgets, this.height = 560, this.onAddPage});

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  late PageController _pageController;
  int selectedPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.73);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      padding: const EdgeInsets.symmetric(vertical: defaultPadding * 2),
      child: PageView.builder(
        onPageChanged: (value) {
          if (value >= widget.widgets.length - 2) {
            widget.onAddPage!();
          }
          setState(() {
            selectedPage = value;
          });
        },
        controller: _pageController,
        itemCount: widget.widgets.length,
        itemBuilder: (context, index) => TweenAnimationBuilder(
          duration: const Duration(milliseconds: 150),
          tween: Tween(
              begin: selectedPage == index ? 1.0 : 0.8,
              end: selectedPage == index ? 1.0 : 0.8),
          curve: Curves.ease,
          child: widget.widgets[index],
          builder: (context, value, child) {
            return Transform.scale(
              scale: value,
              child: child,
            );
          },
        ),
      ),
    );
  }
}
