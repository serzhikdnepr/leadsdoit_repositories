import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:getwidget/getwidget.dart';

import '../generated/assets.dart';

Color colorTitleText = const Color(0xff211814);
Color bgAppBar = const Color(0xffF9F9F9);
Color bgPage = const Color(0xffF9F9F9);
Color colorDivider = const Color(0xffF2F2F2);
Color bgField = const Color(0xffF2F2F2);
Color mainColor = const Color(0xff0CC509);
Color hintColor = const Color(0xffBFBFBF);
Color textColorWhite = const Color(0xffF2F2F2);

const TextStyle soraStyle = TextStyle(
    fontFamily: "Sora",
    height: 1.1875,
    fontSize: 14,
    fontWeight: FontWeight.w400);

final TextStyle titleStyle = soraStyle.copyWith(
    color: colorTitleText, fontSize: 16, fontWeight: FontWeight.w600);

final TextStyle searchStyle = soraStyle.copyWith(
    color: colorTitleText,
    fontSize: 14,
    height: 1.41,
    fontWeight: FontWeight.w400);

final TextStyle searchHintStyle = soraStyle.copyWith(
    color: hintColor, fontSize: 16, fontWeight: FontWeight.w400);

final TextStyle descriptionStyle = soraStyle.copyWith(
    color: colorTitleText,
    fontSize: 14,
    height: 1.41,
    fontWeight: FontWeight.w400);

final TextStyle descriptionRepository = soraStyle.copyWith(
    color: mainColor, fontSize: 16, fontWeight: FontWeight.w600);

final TextStyle emptyText = soraStyle.copyWith(
    color: hintColor, height: 1.41, fontSize: 14, fontWeight: FontWeight.w400);

InputDecoration inputDecoration(
        String searchHint, bool hasFocus, Function()? btnClear) =>
    InputDecoration(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(28)),
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: mainColor, width: 2),
            borderRadius: const BorderRadius.all(Radius.circular(28))),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent, width: 2),
          borderRadius: BorderRadius.all(
            Radius.circular(28),
          ),
        ),
        filled: true,
        fillColor: hasFocus ? const Color(0xffEEF7F0) : const Color(0xffF2F2F2),
        hintStyle: searchHintStyle,
        prefixIcon: Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: 24,
              height: 24,
              child: SvgPicture.asset(Assets.assetsIconSearch),
            )),
        suffixIcon: btnClear != null
            ? Padding(
                padding: const EdgeInsets.all(16),
                child: GFIconButton(
                  padding: EdgeInsets.zero,
                  icon: SvgPicture.asset(Assets.assetsIconClear),
                  onPressed: btnClear,
                  iconSize: 24,
                  color: Colors.transparent,
                ))
            : null,
        hintText: searchHint);
