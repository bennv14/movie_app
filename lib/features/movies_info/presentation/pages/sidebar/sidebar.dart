import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:movie_app/core/constants/constants.dart';
import 'package:movie_app/features/movies_info/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:movie_app/features/movies_info/presentation/pages/sidebar/widgets/user_card.dart';
import 'package:movie_app/injection_container.dart';

class SideBar extends StatelessWidget {
  final Function changePage;
  const SideBar({super.key, required this.changePage});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      elevation: 0,
      width: MediaQuery.of(context).size.width * 0.8,
      shape: shapeSideBar(),
      child: Column(
        children: [
          const SizedBox(height: defaultPadding),
          SafeArea(
            child: TextButton(
                onPressed: () {
                  Scaffold.of(context).closeDrawer();
                  changePage(2);
                },
                child: const UserCard()),
          ),
          const SizedBox(
            height: defaultPadding,
          ),
          const Divider(color: secondaryColor),
          const SizedBox(height: defaultPadding * 2),
          buildListBtn(context),
        ],
      ),
    );
  }

  Column buildListBtn(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButton(
            onPressed: () {
              Scaffold.of(context).closeDrawer();
              changePage(0);
            },
            child: Text(
              'Home Screen',
              style: headerMedium.copyWith(fontWeight: FontWeight.w400),
            ),
          ),
          TextButton(
            onPressed: () {
              Scaffold.of(context).closeDrawer();
              changePage(1);
            },
            child: Text(
              'Favourite Movies',
              style: headerMedium.copyWith(fontWeight: FontWeight.w400),
            ),
          ),
          TextButton(
            onPressed: () {
              log(name: 'SideBar', 'click language');
            },
            child: Text(
              'Language',
              style: headerMedium.copyWith(fontWeight: FontWeight.w400),
            ),
          ),
          TextButton(
            onPressed: () {
              log(name: 'SideBar', 'click region');
            },
            child: Text(
              'Region',
              style: headerMedium.copyWith(fontWeight: FontWeight.w400),
            ),
          ),
          TextButton(
            onPressed: () {
              getIt.get<AuthBloc>().add(Logout());
            },
            child: Text(
              'Logout',
              style: headerMedium.copyWith(fontWeight: FontWeight.w400),
            ),
          ),
        ],
      );

  RoundedRectangleBorder shapeSideBar() => const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(defaultPadding),
          bottomRight: Radius.circular(defaultPadding),
        ),
      );
}
