import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_app/core/constants/constants.dart';

class UserCard extends StatelessWidget {
  const UserCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          "assets/icons/user.svg",
          height: defaultPadding * 7,
        ),
        const Text(
          "Name user",
          style: headerMedium,
        ),
      ],
    );
  }
}
