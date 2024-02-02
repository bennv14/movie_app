import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_app/core/constants/constants.dart';
import 'package:movie_app/features/movies_info/data/models/account.dart';
import 'package:movie_app/features/movies_info/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:movie_app/features/movies_info/presentation/pages/sign_up_screen/sign_up_screen.dart';
import 'package:movie_app/features/movies_info/presentation/widgets/center_circular_pogress_indicator.dart';
import 'package:movie_app/injection_container.dart';
import 'widgets/custom_icon_button.dart';
import 'widgets/custom_text_from_field.dart';

class SignInSceen extends StatefulWidget {
  const SignInSceen({super.key});

  @override
  State<SignInSceen> createState() => _SignInSceenState();
}

class _SignInSceenState extends State<SignInSceen> {
  bool _isPasswordVisible = false;
  bool _isLoggingIn = false;

  late String _email;
  late String _password;

  @override
  void initState() {
    super.initState();
    _email = '';
    _password = '';
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool _checkValidate() {
    if (RegExp(regExEmail).hasMatch(_email) && _password.length >= 6) {
      return true;
    } else {
      return false;
    }
  }

  bool _checkEnableLogin() {
    if (_isLoggingIn || _checkValidate() == false) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocListener<AuthBloc, AuthState>(
          bloc: getIt.get<AuthBloc>(),
          listener: (context, state) {
            if (state is AuthenticationLoading) {
              setState(() {
                _isLoggingIn = true;
              });
            } else {
              setState(() {
                _isLoggingIn = false;
              });
              if (state is AuthenticationFailure) {
                _buildDialog(context, state.message);
              }
            }
          },
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: _buildTitle(),
              ),
              _buildEmail(),
              _buildPassword(),
              _buildForgotPassword(),
              _buildLoginBtn(),
              const SizedBox(height: defaultPadding * 2),
              Text(
                "- OR Continue with -",
                style: textStyle.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: defaultPadding),
              _buildLoginSocial(),
              const SizedBox(height: defaultPadding + 5),
              _builSignUpRedirect(context),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> _buildDialog(BuildContext context, String msg) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Ok"),
          ),
        ],
        title: const Center(
          child: Text(
            "Login Failed",
            style: headerMedium,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(defaultPadding / 2),
        ),
        content: Text(msg),
      ),
    );
  }

  Row _builSignUpRedirect(BuildContext context) {
    return Row(
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
    );
  }

  Row _buildLoginSocial() {
    void loginByGoogle() {}
    void loginByFacebook() {}
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomIconButton(
          height: defaultPadding * 3,
          padding: const EdgeInsets.all(defaultPadding - 5),
          decoration: _buildBoxDecortation(),
          icon: SvgPicture.asset(
            iconLogoGoogle,
            fit: BoxFit.contain,
          ),
          onPressed: _isLoggingIn ? null : loginByGoogle,
        ),
        CustomIconButton(
          height: defaultPadding * 3,
          padding: const EdgeInsets.all(defaultPadding - 5),
          decoration: _buildBoxDecortation(),
          icon: SvgPicture.asset(
            iconLogoFacebook,
            fit: BoxFit.contain,
          ),
          onPressed: _isLoggingIn ? null : loginByFacebook,
        ),
      ],
    );
  }

  BoxDecoration _buildBoxDecortation() {
    return BoxDecoration(
      color: bgSocialLoginColor,
      border: Border.all(color: borderSocialLoginColor),
      shape: BoxShape.circle,
    );
  }

  Container _buildForgotPassword() {
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

  Container _buildLoginBtn() {
    var doLogin = _checkEnableLogin() ? _doLogin : null;

    var contentLoggingIn = _isLoggingIn
        ? const CenterCircularProgressIndicator(color: Colors.white)
        : Text(
            "Login",
            style: headerLarge.copyWith(color: Colors.white),
          );
    var backgroundColor = MaterialStateProperty.all(
      _checkEnableLogin() ? secondaryColor : secondaryColor.withOpacity(0.6),
    );
    return Container(
      width: double.infinity,
      height: defaultPadding * 3,
      margin: const EdgeInsets.only(
        left: defaultPadding,
        right: defaultPadding,
        top: defaultPadding * 2.5,
        bottom: defaultPadding,
      ),
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          backgroundColor: backgroundColor,
        ),
        onPressed: doLogin,
        child: contentLoggingIn,
      ),
    );
  }

  void _doLogin() {
    getIt.get<AuthBloc>().add(
          Login(
            Account(
              email: _email,
              password: _password,
            ),
          ),
        );
  }

  Container _buildEmail() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: defaultPadding,
        vertical: defaultPadding / 2,
      ),
      child: CustomTextFromField(
        onChanged: (value) {
          setState(() {
            _email = value;
          });
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value == null) {
            return "Vui lòng nhập email";
          }
          if (RegExp(regExEmail).hasMatch(value)) {
            return null;
          } else {
            return "Email không hợp lệ";
          }
        },
        enabled: !_isLoggingIn,
        hintText: "Email",
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

  Container _buildPassword() {
    void showPassword() {
      setState(() {
        _isPasswordVisible = true;
      });
      Future.delayed(
        const Duration(seconds: 3),
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
        onChanged: (value) {
          setState(() {
            _password = value;
          });
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value == null || value.length < 6) {
            return "Mật khẩu chứa tối thiểu 6 ký tự!";
          } else {
            return null;
          }
        },
        enabled: !_isLoggingIn,
        obscureText: !_isPasswordVisible,
        hintText: "Password",
        prefixIcon: const Icon(
          Icons.lock,
          color: iconTFFColor,
          size: 26,
        ),
        subfixIcon: IconButton(
          icon: Icon(
            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
            color: iconTFFColor,
            size: 26,
          ),
          onPressed: showPassword,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: defaultPadding),
        cursorColor: secondaryColor,
      ),
    );
  }

  Padding _buildTitle() {
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
