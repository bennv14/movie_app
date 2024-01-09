import 'package:flutter/material.dart';

const secondaryColor = Color(0xFFFE6D8E);
const textColor = Color(0xFF12153D);
const textLightColor = Color(0xFF9A9BB2);
const fillStarColor = Color(0xFFFCC419);

const defaultPadding = 20.0;

const titleMovie = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.w600,
  color: Colors.black87,
);

const headerLarge = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w600,
  color: Colors.black87,
);

const headerMedium = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w600,
  color: Colors.black87,
);

const headerSmall = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w600,
  color: Colors.black87,
);

const textStyle = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w500,
  color: Colors.black87,
);

const defaultShadow = BoxShadow(
    offset: Offset(0, 4),
    blurRadius: 15,
    color: secondaryColor,
    spreadRadius: 40,
    blurStyle: BlurStyle.inner);

const List<String> tabBarMovie = [
  "Thông tin",
  "Diễn viên",
  "Đánh giá",
  "Gợi ý",
  "Tương tự"
];
const List<String> categories = ["Đang chiếu", "Phổ biến", "BXH", "Sắp chiếu"];

String urlImage(String path) {
  return "https://image.tmdb.org/t/p/w500$path";
}

Image createImage(String? url) {
  if (url == null) {
    return Image.asset(
      "assets/images/no-image.png",
      fit: BoxFit.contain,
    );
  } else {
    return Image.network(
      urlImage(url),
      fit: BoxFit.cover,
    );
  }
}

const String movieBaseURL = "https://api.themoviedb.org/3";

const String uriNowPlaying = "/movie/now_playing";
const String uriPopular = "/movie/popular";
const String uriTopRate = "/movie/top_rated";
const String uriUpcomming = "/movie/upcoming";

const String assetTokenAuth =
    "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4N2JiMWU3NGMyNDQ5ZWY4MWVmOTBiMTNhZjMyOTllOSIsInN1YiI6IjY0ZTk5MzllZWE4OWY1MDEzYjE4MmZlNSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.GwJ4LoIFhtrzZA83LgoiYPux_Mky3pSoG0T0HmcohJM";

const Map<String, String> headers = <String, String>{
  'Accept': 'application/json',
  'Authorization': 'Bearer $assetTokenAuth',
};
