import 'package:flutter/material.dart';
import 'package:movie_app/constants.dart';

class ReleasedateRuntime extends StatelessWidget {
  final String release;
  final int runtime;
  final FontWeight fontWeight; 
  const ReleasedateRuntime(
      {super.key, required this.release, required this.runtime, this.fontWeight = FontWeight.w500});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(Icons.calendar_today_outlined),
        const SizedBox(
          width: defaultPadding / 4,
        ),
        Text(
          release,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          width: 2,
          height: 14,
          color: Colors.black,
        ),
        const Icon(
          Icons.timer_outlined,
        ),
        const SizedBox(
          width: defaultPadding / 4,
        ),
        Text(
          "$runtime Phút",
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
