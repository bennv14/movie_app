import 'package:flutter/material.dart';
import 'package:movie_app/features/movies_info/presentation/pages/search/components/body.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Body(),
    );
  }
}
