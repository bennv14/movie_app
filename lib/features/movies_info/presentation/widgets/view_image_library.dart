import 'package:flutter/material.dart';
import 'package:movie_app/core/constants/constants.dart';
import 'package:movie_app/features/movies_info/domain/entities/image_entity.dart';

class ViewImageLibrary extends StatefulWidget {
  final List<ImageEntity> images;
  const ViewImageLibrary({super.key, required this.images});

  @override
  State<ViewImageLibrary> createState() => _ViewImageLibraryState();
}

class _ViewImageLibraryState extends State<ViewImageLibrary> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            itemCount: widget.images.length,
            itemBuilder: (context, index) {
              return createImage(widget.images[index].filePath, fit: BoxFit.contain);
            },
          ),
          Container(
            padding: const EdgeInsets.all(defaultPadding),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
