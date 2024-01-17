import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Row ratingVote({required String voteAverage}) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset("assets/icons/star_fill.svg"),
                Text(
                  voteAverage,
                  style: const TextStyle(
                    color: Colors.amber,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            );