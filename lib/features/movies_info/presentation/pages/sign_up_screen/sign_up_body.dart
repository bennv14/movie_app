import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_app/core/constants/constants.dart';
import 'package:movie_app/features/movies_info/data/models/account.dart';
import 'package:movie_app/features/movies_info/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:movie_app/features/movies_info/presentation/bloc/register_bloc/register_bloc.dart';
import 'package:movie_app/features/movies_info/presentation/pages/sign_in_screen/sign_in_screen.dart';
import 'package:movie_app/features/movies_info/presentation/pages/sign_in_screen/widgets/custom_icon_button.dart';
import 'package:movie_app/features/movies_info/presentation/pages/sign_in_screen/widgets/custom_text_from_field.dart';
import 'package:movie_app/features/movies_info/presentation/widgets/center_circular_progress_indicator.dart';
import 'package:movie_app/injection_container.dart';

class SignUpBody extends StatefulWidget {
  const SignUpBody({super.key});

  @override
  State<SignUpBody> createState() => _SignUpBodyState();
}

class _SignUpBodyState extends State<SignUpBody> {
  bool _isRegistering = false;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  late String _email;
  late String _password;
  late String _confirmPassword;

  @override
  void initState() {
    super.initState();
    _email = '';
    _password = '';
    _confirmPassword = '';
  }

  @override
  void dispose() {
    super.dispose();
  }

  String? _validateEmail(value) {
    if (value == null) {
      return "Vui lòng nhập email";
    } else {
      if (RegExp(regExEmail).hasMatch(value)) {
        return null;
      }
      return "Email không hợp lệ";
    }
  }

  bool _checkValidate() {
    if (_validateEmail(_email) == null &&
        _password.length >= 6 &&
        _password == _confirmPassword) {
      return true;
    } else {
      return false;
    }
  }

  bool _checkEnableRegister(RegisterState state) {
    if (_checkValidate() && !_isRegistering) {
      return true;
    } else {
      return false;
    }
  }

  void _doRegister() async {
    context.read<RegisterBloc>().add(
          Register(
            Account(email: _email, password: _password),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      bloc: context.read<RegisterBloc>(),
      listener: (context, state) {
        if (state is RegisterLoading) {
          setState(() {
            _isRegistering = true;
          });
        } else {
          setState(() {
            _isRegistering = false;
          });
          if (state is RegisterSuccess) {
            getIt.get<AuthBloc>().add(LoggedIn(state.user));
            Navigator.pop(context);
          } else if (state is RegisterFailure) {
            _buildDialog(context, state.message);
          }
        }
      },
      child: Builder(builder: (context) {
        final state = context.read<RegisterBloc>().state;
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: _buildTitle(),
                ),
                _buildEmail(state),
                _buildPassword(state),
                _buildConfirmPassword(state),
                _buildForgotPassword(),
                _buildRegisterBtn(state),
                const SizedBox(height: defaultPadding * 2),
                Text(
                  "- OR Continue with -",
                  style: textStyle.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: defaultPadding),
                _buildLoginSocial(state),
                const SizedBox(height: defaultPadding + 5),
                _buildSignInRedirect(context),
              ],
            ),
          ),
        );
      }),
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

  Row _buildSignInRedirect(BuildContext context) {
    var redirectLogin = _isRegistering
        ? null
        : () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SignInScreen()),
            );
          };

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "I Already Have An Account ",
          style: textStyle.copyWith(
            fontWeight: FontWeight.w400,
            color: Colors.black87,
          ),
        ),
        TextButton(
          onPressed: redirectLogin,
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            "Login",
            style: headerSmall.copyWith(color: secondaryColor),
          ),
        )
      ],
    );
  }

  Row _buildLoginSocial(RegisterState state) {
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
          onPressed: state is RegisterLoading ? null : () {},
        ),
        CustomIconButton(
          height: defaultPadding * 3,
          padding: const EdgeInsets.all(defaultPadding - 5),
          decoration: buildBoxDecortation(),
          icon: SvgPicture.asset(
            iconLogoFacebook,
            fit: BoxFit.contain,
          ),
          onPressed: state is RegisterLoading ? null : () {},
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

  Container _buildForgotPassword() {
    return Container(
      alignment: Alignment.topLeft,
      margin: const EdgeInsets.only(
          right: defaultPadding, left: defaultPadding, top: defaultPadding / 4),
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Text(
          "By clicking on the ${"Create Account"} button below, you understand and agree that the use of Terms of Use",
          style: textStyle.copyWith(color: Colors.black54, fontWeight: FontWeight.normal),
        ),
      ),
    );
  }

  Container _buildRegisterBtn(RegisterState state) {
    return Container(
      height: defaultPadding * 3,
      width: double.infinity,
      margin: const EdgeInsets.only(
        left: defaultPadding,
        right: defaultPadding,
        top: defaultPadding * 1.7,
        bottom: defaultPadding,
      ),
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(_checkEnableRegister(state)
              ? secondaryColor
              : secondaryColor.withOpacity(0.6)),
        ),
        onPressed: _checkEnableRegister(state) ? _doRegister : null,
        child: state is RegisterLoading
            ? const CenterCircularProgressIndicator(color: Colors.white)
            : Text(
                "Create Account",
                style: headerLarge.copyWith(color: Colors.white),
              ),
      ),
    );
  }

  Container _buildEmail(RegisterState state) {
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
        validator: _validateEmail,
        enabled: !_isRegistering,
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

  Container _buildPassword(RegisterState state) {
    show() {
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
        bottom: defaultPadding / 2,
      ),
      child: CustomTextFromField(
        onChanged: (value) {
          setState(() {
            _password = value;
          });
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value == null) {
            return "Vui lòng nhập mật khẩu";
          } else if (value.length < 6) {
            return "Mật khẩu phải có ít nhất 6 ký tự";
          }
          return null;
        },
        enabled: !_isRegistering,
        obscureText: !_isPasswordVisible,
        hintText: "Password",
        prefixIcon: const Icon(
          Icons.lock,
          color: iconTFFColor,
          size: 26,
        ),
        subfixIcon: IconButton(
          icon: Icon(
            !_isPasswordVisible ? Icons.visibility_off : Icons.visibility,
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

  Container _buildConfirmPassword(RegisterState state) {
    void show() {
      setState(() {
        _isConfirmPasswordVisible = true;
      });
      Future.delayed(
        const Duration(seconds: 3),
        () {
          setState(() {
            _isConfirmPasswordVisible = false;
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
            _confirmPassword = value;
          });
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          return _confirmPassword != _password ? "Mật khẩu không khớp." : null;
        },
        enabled: !_isRegistering,
        obscureText: !_isConfirmPasswordVisible,
        hintText: "Confirm Password",
        prefixIcon: const Icon(
          Icons.lock,
          color: iconTFFColor,
          size: 26,
        ),
        subfixIcon: IconButton(
          icon: Icon(
            !_isConfirmPasswordVisible ? Icons.visibility_off : Icons.visibility,
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

  Padding _buildTitle() {
    return const Padding(
      padding: EdgeInsets.only(
        left: defaultPadding,
        right: defaultPadding,
        top: defaultPadding * 2,
        bottom: defaultPadding,
      ),
      child: Text(
        "Create an\nAccount",
        style: title,
      ),
    );
  }
}
