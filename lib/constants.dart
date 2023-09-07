import 'package:flutter/material.dart';

const secondaryColor = Color(0xFFFE6D8E);
const textColor = Color(0xFF12153D);
const textLightColor = Color(0xFF9A9BB2);
const fillStarColor = Color(0xFFFCC419);

const defaultPadding = 20.0;

const titleMovie =  TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.w600,
  color: Colors.black87,
);

const headerLarge = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w600,
  color: Colors.black87,
);

const headerMedium = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w600,
  color: Colors.black87,
);

const headerSmall = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w600,
  color: Colors.black87,
);

const textStyle = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w500,
  color: Colors.black87,
);

const defaultShadow = BoxShadow(
  offset: Offset(0, 4),
  blurRadius: 15,
  color:secondaryColor,
  spreadRadius: 40,
  blurStyle: BlurStyle.inner
);

const List<String> tabBarMovie = ["Thông tin", "Diễn viên","Đánh giá","Gợi ý","Tương tự"];
const List <String> categories = ["Đang chiếu", "Phổ biến", "BXH", "Sắp chiếu"];
