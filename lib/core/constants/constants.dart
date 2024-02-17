import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/features/movies_info/presentation/widgets/center_circular_progress_indicator.dart';

const secondaryColor = Color(0xFFFE6D8E);
const textColor = Color(0xFF12153D);
const textLightColor = Color(0xFF9A9BB2);
const fillStarColor = Color(0xFFFCC419);
const borderTFFColor = Color.fromRGBO(168, 168, 169, 100);
const backgroundTFFColor = Color.fromRGBO(243, 243, 243, 100);
const iconTFFColor = Color.fromRGBO(103, 103, 103, 100);
const bgSocialLoginColor = Color.fromRGBO(253, 243, 246, 100);
const borderSocialLoginColor = Color.fromRGBO(248, 55, 88, 100);

const iconsPath = 'assets/icons';
const iconLogoGoogle = '$iconsPath/Google.svg';
const iconLogoFacebook = '$iconsPath/Facebook.svg';
const regExEmail =
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$";
const regExPassword = r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$";

const defaultPadding = 20.0;

const titleMovie = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.w600,
  color: Colors.black87,
);

const title = TextStyle(
  fontSize: 40,
  fontWeight: FontWeight.w700,
  color: Colors.black,
);

const headerLarge = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w600,
  color: Colors.black87,
);

const headerMedium = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w500,
  color: Colors.black87,
);

const headerSmall = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w500,
  color: Colors.black87,
);

const textStyle = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w500,
  color: Colors.black87,
);

const textMedium = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w400,
  color: Colors.black87,
);

const defaultShadow = BoxShadow(
  offset: Offset(0, 4),
  blurRadius: 15,
  color: secondaryColor,
  spreadRadius: 40,
  blurStyle: BlurStyle.inner,
);

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

Image createImage(String? url, {BoxFit fit = BoxFit.fill}) {
  if (url == null) {
    return Image.asset(
      "assets/images/no-image.png",
      fit: BoxFit.fill,
    );
  } else {
    return Image.network(
      urlImage(url),
      fit: fit,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        } else {
          return const CenterCircularProgressIndicator();
        }
      },
      errorBuilder: (context, error, stackTrace) {
        return Center(child: Text(error.toString()));
      },
    );
  }
}

cachedImage(String? url, {BoxFit fit = BoxFit.fill}) {
  if (url == null) {
    return Image.asset(
      "assets/images/no-image.png",
      fit: BoxFit.fill,
    );
  } else {
    return CachedNetworkImage(
      imageUrl: urlImage(url),
      progressIndicatorBuilder: (context, url, progress) =>
          const CenterCircularProgressIndicator(),
      errorWidget: (context, url, error) => Text(
        error.toString(),
        style: textStyle,
      ),
      imageBuilder: (context, imageProvider) {
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: fit,
            ),
          ),
        );
      },
    );
  }
}

const String movieBaseURL = "https://api.themoviedb.org/3";

const String uriNowPlaying = "/movie/now_playing";
const String uriPopular = "/movie/popular";
const String uriTopRate = "/movie/top_rated";
const String uriUpcoming = "/movie/upcoming";
const String uriGenres = "/genre/movie/list";
const String uriDetailMovie = "/movie";
const String uriSearchMovie = "/search/movie";

const String assetTokenAuth =
    "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4N2JiMWU3NGMyNDQ5ZWY4MWVmOTBiMTNhZjMyOTllOSIsInN1YiI6IjY0ZTk5MzllZWE4OWY1MDEzYjE4MmZlNSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.GwJ4LoIFhtrzZA83LgoiYPux_Mky3pSoG0T0HmcohJM";

const Map<String, String> headers = <String, String>{
  'Accept': 'application/json',
  'Authorization': 'Bearer $assetTokenAuth',
};

const String userCollections = "users";
const String favouriteMovieCollections = "favourite_movies";

const backdropRatio = 16 / 9;
const posterRatio = 2 / 3;

const googleSignInscopes = [
  'email',
  'https://www.googleapis.com/auth/contacts.readonly',
];
