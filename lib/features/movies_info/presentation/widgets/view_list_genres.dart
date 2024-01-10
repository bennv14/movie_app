import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/constants/constants.dart';
import 'package:movie_app/features/movies_info/domain/entities/genre_entity.dart';
import 'package:movie_app/features/movies_info/presentation/bloc/genres_bloc/genres_bloc.dart';
import 'package:movie_app/injection_container.dart';

class ViewListGenres extends StatelessWidget {
  final List<GenreEntity> genres;
  const ViewListGenres({super.key, required this.genres});

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
  final GenreEntity genre;
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
            if (isSelected) {
              getIt.get<GenresBloc>().add(
                    RemoveGenresSelectedEvent(genreSelectedID: widget.genre.id!),
                  );
            } else {
              getIt.get<GenresBloc>().add(
                    AddGenresSelectedEvent(genreSelectedID: widget.genre.id!),
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
              border: Border.all(color: isSelected ? Colors.transparent : Colors.black26),
            ),
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
