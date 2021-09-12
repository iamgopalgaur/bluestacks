import 'package:flutter/material.dart';

import 'colors.dart';

class AppText {
  static Widget heading({@required text}) {
    return Text(
      text,
      style: TextStyle(
        color: ThemeColors.whiteColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  static Widget subHeading({@required text}) {
    return Text(
      text,
      style: TextStyle(
        color: ThemeColors.whiteColor,
      ),
    );
  }
}
