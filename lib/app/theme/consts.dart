import 'package:flutter/cupertino.dart';

class AppPadding {

  AppPadding._();
  static const top18 = EdgeInsets.only(top: 18);

  static const top8 = EdgeInsets.only(top: 8);

  static const horizontal16 = EdgeInsets.symmetric(horizontal: 16);

  static const horizontal8 = EdgeInsets.symmetric(horizontal: 8);

  static const horizontal4 = EdgeInsets.symmetric(horizontal: 4);

  static const all16 = EdgeInsets.all(16);

  static const all8 = EdgeInsets.all(8);

  static const v8h40 = EdgeInsets.fromLTRB(40, 8, 40, 8);

  static const v8h20 = EdgeInsets.fromLTRB(20, 8, 20, 8);
}

class AppBorder {

  AppBorder._();
  static const top20 = BorderRadius.vertical(
    top: Radius.circular(20),
  );
  static const top2 = BorderRadius.vertical(
    top: Radius.circular(2),
  );

  static const topRight12 = BorderRadius.only(topRight: Radius.circular(12));

  static const bottomRight12 = BorderRadius.only(bottomRight: Radius.circular(12));

  static const right12 = BorderRadius.only(bottomRight: Radius.circular(12), topRight: Radius.circular(12));

  static const left12 = BorderRadius.only(bottomLeft: Radius.circular(12), topLeft: Radius.circular(12));

  static final all20 = BorderRadius.circular(20);

  static final all24 = BorderRadius.circular(24);

  static final all16 = BorderRadius.circular(16);

  static final all12 = BorderRadius.circular(12);

  static final all10 = BorderRadius.circular(10);

  static final all8 = BorderRadius.circular(8);

  static final all6 = BorderRadius.circular(6);
}

