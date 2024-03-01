import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movie_app/core/constants/constants.dart';
import 'package:movie_app/features/movies_info/presentation/pages/sign_in_screen/widgets/custom_icon_button.dart';
import 'package:movie_app/features/movies_info/presentation/pages/user_detail/text_input_profile.dart';
import 'package:movie_app/features/movies_info/presentation/widgets/center_circular_progress_indicator.dart';

class UserDetailScreen extends StatefulWidget {
  const UserDetailScreen({super.key});

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  late final TextEditingController _displayNameController;
  late final TextEditingController _phoneNumberController;
  bool _isUpdating = false;

  void _onBack() {
    Navigator.pop(context);
  }

  @override
  void initState() {
    _displayNameController = TextEditingController();
    _phoneNumberController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _displayNameController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  void _doUpdate() async {
    setState(() {
      _isUpdating = true;
    });
    FocusManager.instance.primaryFocus?.unfocus();
    await FirebaseAuth.instance.currentUser!
        .updateDisplayName(_displayNameController.text)
        .then((value) {
      setState(() {
        setState(() {
          _isUpdating = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _isUpdating ? Colors.grey.withOpacity(0.2) : Colors.white,
        leading: CustomIconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: _onBack,
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseAuth.instance.userChanges(),
        builder: (context, snapshot) {
          return Stack(
            children: [
              Visibility(
                visible: snapshot.hasData,
                child: SafeArea(
                  child: _buildContent(snapshot),
                ),
              ),
              Visibility(
                visible: _isUpdating,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                  ),
                  child: CenterCircularProgressIndicator(
                    color: secondaryColor,
                    backgroundColor: secondaryColor.withOpacity(0.5),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  Widget _buildContent(AsyncSnapshot<User?> snapshot) {
    if (snapshot.hasData == false) {
      return Container();
    }
    _displayNameController.text = snapshot.data!.displayName ?? "";
    _phoneNumberController.text = snapshot.data!.phoneNumber ?? "";
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding * 1.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _buildAvatar(snapshot.data!.photoURL),
          const SizedBox(height: defaultPadding),
          _buildDisplayNameInput(),
          const SizedBox(height: defaultPadding * 2),
          _buildPhoneNumberInput(),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: _buildSaveBtn(),
            ),
          ),
          const SizedBox(height: defaultPadding),
        ],
      ),
    );
  }

  Widget _buildPhoneNumberInput() {
    return TextInputCustom(
      cursorColor: secondaryColor,
      controller: _phoneNumberController,
      style: headerMedium.copyWith(
        fontSize: 20,
      ),
      labelText: "Phone Number",
      labelStyle: headerMedium.copyWith(
        fontSize: 24,
        color: Colors.grey,
      ),
      border: const Border(
        bottom: BorderSide(
          color: Colors.grey,
          width: 1.5,
        ),
      ),
    );
  }

  TextInputCustom _buildDisplayNameInput() {
    return TextInputCustom(
      controller: _displayNameController,
      style: headerMedium.copyWith(
        fontSize: 20,
      ),
      cursorColor: secondaryColor,
      labelText: "Name",
      labelStyle: headerMedium.copyWith(
        fontSize: 24,
        color: Colors.grey,
      ),
      border: const Border(
        bottom: BorderSide(
          color: Colors.grey,
          width: 1.5,
        ),
      ),
    );
  }

  Widget _buildSaveBtn() {
    return SizedBox(
      width: double.infinity,
      height: defaultPadding * 3,
      child: TextButton(
        onPressed: _doUpdate,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(secondaryColor),
        ),
        child: Text(
          "Save",
          style: headerLarge.copyWith(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildAvatar(String? photoURL) {
    return SizedBox(
      height: 150,
      width: 150,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(100),
            ),
            child: catchImageAvatar(photoURL),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              margin: const EdgeInsets.all(defaultPadding / 2 - defaultPadding / 3),
              child: CustomIconButton(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: 4,
                  ),
                  shape: BoxShape.circle,
                  color: const Color.fromARGB(255, 245, 246, 247),
                ),
                padding: EdgeInsets.zero,
                icon: const Icon(
                  Icons.camera_alt_rounded,
                ),
                onPressed: _changeImage,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _changeImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _isUpdating = true;
      });
      log(name: "image", pickedFile.path);
      final ref = FirebaseStorage.instance
          .ref("/avatar")
          .child(FirebaseAuth.instance.currentUser!.uid);
      await ref.putFile(File(pickedFile.path));
      final url = await ref.getDownloadURL();
      log(name: "url", url);
      await FirebaseAuth.instance.currentUser!.updatePhotoURL(url);
      setState(() {
        _isUpdating = false;
      });
    }
  }
}
