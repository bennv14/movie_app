import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/core/constants/constants.dart';

class UserCard extends StatelessWidget {
  const UserCard({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.userChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.data == null) {
          return const Center(
            child: Icon(
              Icons.person,
              size: 100,
              color: secondaryColor,
            ),
          );
        }
        return Column(
          children: [
            SizedBox(
              height: 100,
              width: 100,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(100)),
                child: catchImageAvatar(snapshot.data!.photoURL),
              ),
            ),
            const SizedBox(height: defaultPadding),
            Text(
              snapshot.data!.displayName ?? "No name",
              style: headerMedium,
            ),
          ],
        );
      },
    );
  }
}
