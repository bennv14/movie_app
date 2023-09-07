import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/bloc/genres-bloc/genres_bloc.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/models/genre.dart';

class Genres extends StatelessWidget {
  final List<Genre> genres;
  const Genres({super.key, required this.genres});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: genres.length,
        itemBuilder: (context, index) => GenreCard(
          genre: genres[index],
        ),
      ),
    );
  }
}

class GenreCard extends StatefulWidget {
  final Genre genre;
  const GenreCard({super.key, required this.genre});

  @override
  State<GenreCard> createState() => _GenreCardState();
}

class _GenreCardState extends State<GenreCard> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GenresBloc, GenresState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            var genresBloc = context.read<GenresBloc>();
            if (isSelected) {
              genresBloc.add(
                RemoveGenresSelectedEvent(genresSelectedID: widget.genre.id!),
              );
            } else {
              genresBloc.add(
                AddGenresSelectedEvent(genresSelectedID: widget.genre.id!),
              );
            }
            setState(() {
              isSelected = !isSelected;
            });
          },
          child: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(
              left: defaultPadding,
            ),
            padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding, vertical: defaultPadding / 4),
            decoration: BoxDecoration(
                color: isSelected ? secondaryColor : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
                border:
                    Border.all(color: isSelected ? Colors.transparent : Colors.black26)),
            child: Text(
              widget.genre.name ?? "Null",
              style: TextStyle(
                  color: isSelected ? Colors.white : textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
          ),
        );
      },
    );
  }
}
