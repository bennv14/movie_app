import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_app/core/constants/constants.dart';
import 'package:movie_app/features/movies_info/presentation/pages/sign_up_screen/sign_up_screen.dart';

import 'widgets/custom_icon_button.dart';
import 'widgets/custom_text_from_field.dart';

class SignInSceen extends StatefulWidget {
  const SignInSceen({super.key});

  @override
  State<SignInSceen> createState() => _SignInSceenState();
}

class _SignInSceenState extends State<SignInSceen> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: buildTitle(),
            ),
            buildUsername(),
            buildPassword(),
            buildForgotPassword(),
            buildLoginBtn(),
            const SizedBox(height: defaultPadding * 2),
            Text(
              "- OR Continue with -",
              style: textStyle.copyWith(
                fontWeight: FontWeight.w400,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: defaultPadding),
            buildLoginSocial(),
            const SizedBox(height: defaultPadding + 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Create An Account ",
                  style: textStyle.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Colors.black87,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignUpScreen(),
                      ),
                    );
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    "Sign Up",
                    style: headerSmall.copyWith(color: secondaryColor),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Row buildLoginSocial() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomIconButton(
          height: defaultPadding * 3,
          padding: const EdgeInsets.all(defaultPadding - 5),
          decoration: buildBoxDecortation(),
          icon: SvgPicture.asset(
            iconLogoGoogle,
            fit: BoxFit.contain,
          ),
          onPressed: () {},
        ),
        CustomIconButton(
          height: defaultPadding * 3,
          padding: const EdgeInsets.all(defaultPadding - 5),
          decoration: buildBoxDecortation(),
          icon: SvgPicture.asset(
            iconLogoFacebook,
            fit: BoxFit.contain,
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  BoxDecoration buildBoxDecortation() {
    return BoxDecoration(
      color: bgSocialLoginColor,
      border: Border.all(color: borderSocialLoginColor),
      shape: BoxShape.circle,
    );
  }

  Container buildForgotPassword() {
    return Container(
      alignment: Alignment.topRight,
      margin: const EdgeInsets.only(
        right: defaultPadding * 1.5,
        top: defaultPadding / 2,
      ),
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Text(
          "Forgot Password?",
          style: textStyle.copyWith(color: secondaryColor),
        ),
      ),
    );
  }

  Container buildLoginBtn() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(
        left: defaultPadding * 1.5,
        right: defaultPadding * 1.5,
        top: defaultPadding * 2.5,
        bottom: defaultPadding,
      ),
      child: ElevatedButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(vertical: defaultPadding - 1),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(secondaryColor),
        ),
        onPressed: () {},
        child: Text(
          "Login",
          style: headerLarge.copyWith(color: Colors.white),
        ),
      ),
    );
  }

  Container buildUsername() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: defaultPadding,
        vertical: defaultPadding / 2,
      ),
      child: CustomTextFromField(
        border: buildBorder(),
        focusedBorder: buildBorder().copyWith(
          borderSide: const BorderSide(color: secondaryColor),
        ),
        hintText: "Username or Email",
        prefixIcon: const Icon(
          Icons.person_2_rounded,
          size: 26,
          color: iconTFFColor,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: defaultPadding),
        cursorColor: secondaryColor,
      ),
    );
  }

  Container buildPassword() {
    show() {
      setState(() {
        _isPasswordVisible = true;
      });
      Future.delayed(
        const Duration(seconds: 5),
        () {
          setState(() {
            _isPasswordVisible = false;
          });
        },
      );
    }

    return Container(
      margin: const EdgeInsets.only(
        top: defaultPadding / 2,
        left: defaultPadding,
        right: defaultPadding,
        bottom: 0,
      ),
      child: CustomTextFromField(
        obscureText: !_isPasswordVisible,
        border: buildBorder(),
        focusedBorder: buildBorder().copyWith(
          borderSide: const BorderSide(color: secondaryColor),
        ),
        hintText: "Password",
        prefixIcon: const Icon(
          Icons.lock,
          color: iconTFFColor,
          size: 26,
        ),
        subfixIcon: IconButton(
          icon: Icon(
            !_isPasswordVisible ? Icons.visibility : Icons.visibility_off,
            color: iconTFFColor,
            size: 26,
          ),
          onPressed: show,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: defaultPadding),
        cursorColor: secondaryColor,
      ),
    );
  }

  OutlineInputBorder buildBorder() {
    return const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(defaultPadding / 2),
      ),
      borderSide: BorderSide(color: borderTFFColor),
    );
  }

  Padding buildTitle() {
    return const Padding(
      padding: EdgeInsets.only(
        left: defaultPadding,
        right: defaultPadding,
        top: defaultPadding * 2,
        bottom: defaultPadding * 2,
      ),
      child: Text(
        "Welcome\nBack!",
        style: title,
      ),
    );
  }
}
