import 'package:flutter/material.dart';
import 'package:movie_app/core/constants/constants.dart';
import 'package:movie_app/features/movies_info/domain/entities/movie_entity.dart';

class Information extends StatelessWidget {
  final MovieEntity movie;
  const Information({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(
              child: Text(
                "Tiêu đề gốc",
                style: textStyle,
              ),
            ),
            Expanded(
              child: Text(
                movie.originalTitle ?? "Null",
                style: textStyle,
              ),
            )
          ],
        ),
        const SizedBox(
          height: defaultPadding,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(
              child: Text(
                "Trạng thái",
                style: textStyle,
              ),
            ),
            Expanded(
              child: Text(
                movie.status ?? "Null",
                style: textStyle,
              ),
            )
          ],
        ),
        const SizedBox(
          height: defaultPadding,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(
              child: Text(
                "Độ dài",
                style: textStyle,
              ),
            ),
            Expanded(
              child: Text(
                "${movie.runtime} phút",
                style: textStyle,
              ),
            )
          ],
        ),
        const SizedBox(
          height: defaultPadding,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(
              child: Text(
                "Công ty sản xuất",
                style: textStyle,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: movie.productionCompanies!
                    .map((e) => Text(
                          "${e.name}",
                          style: textStyle,
                        ))
                    .toList(),
              ),
            )
          ],
        ),
        const SizedBox(
          height: defaultPadding,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(
              child: Text(
                "Chi phí sản xuất",
                style: textStyle,
              ),
            ),
            Expanded(
              child: Text(
                formatNumber(
                  number: movie.budget ?? 0,
                  lastSymbol: "US\$",
                ),
                style: textStyle,
              ),
            )
          ],
        ),
        const SizedBox(
          height: defaultPadding,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(
              child: Text(
                "Doanh thu",
                style: textStyle,
              ),
            ),
            Expanded(
              child: Text(
                formatNumber(
                  number: movie.revenue ?? 0,
                  lastSymbol: "US\$",
                ),
                style: textStyle,
              ),
            )
          ],
        ),
        const SizedBox(
          height: defaultPadding,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(
              child: Text(
                "Điểm đánh giá",
                style: textStyle,
              ),
            ),
            Expanded(
              child: Text(
                "${movie.voteAverage}",
                style: textStyle,
              ),
            )
          ],
        ),
        const SizedBox(
          height: defaultPadding,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(
              child: Text(
                "Số lượt đánh giá",
                style: textStyle,
              ),
            ),
            Expanded(
              child: Text(
                formatNumber(number: movie.voteCount ?? 0),
                style: textStyle,
              ),
            )
          ],
        ),
      ],
    );
  }

  String formatNumber({required int number, String lastSymbol = ''}) {
    String preFormatNumber = number.toString();
    String formattedNumber = '';
    int n = preFormatNumber.length;
    if (n > 3) {
      formattedNumber = preFormatNumber.substring(n - 3, n);
      n = n - 3;
    }
    while (n >= 3) {
      formattedNumber = "${preFormatNumber.substring(n - 3, n)} $formattedNumber";
      n = n - 3;
    }
    if (n > 0) {
      formattedNumber = "${preFormatNumber.substring(0, n)} $formattedNumber";
    }
    return '$formattedNumber $lastSymbol';
  }
}
