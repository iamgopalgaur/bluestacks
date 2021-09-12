import 'package:bluestacks/utilities/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: must_be_immutable
class Stats extends StatelessWidget {
  String played = '';
  String won = '';
  String percentage = '';
  Stats(String played, String won, String percentage) {
    this.played = played;
    this.percentage = percentage;
    this.won = won;
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Container(
        width: size.width * 0.9,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppText.heading(text: played),
                  AppText.subHeading(
                      text: AppLocalizations.of(context)!.tournaments),
                  AppText.subHeading(
                    text: AppLocalizations.of(context)!.played,
                  ),
                ],
              ),
              height: size.height * 0.13,
              width: size.width * 0.297,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.orange.shade800,
                    Colors.orange.shade400,
                  ],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                ),
              ),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: AppText.heading(text: won),
                    padding: EdgeInsets.all(
                      3,
                    ),
                  ),
                  AppText.subHeading(
                    text: AppLocalizations.of(context)!.tournaments,
                  ),
                  AppText.subHeading(text: AppLocalizations.of(context)!.won),
                ],
              ),
              width: size.width * 0.297,
              height: size.height * 0.13,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Colors.purple.shade700,
                Colors.purple.shade500,
                Colors.purple.shade300,
              ], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppText.heading(text: percentage),
                  AppText.subHeading(
                      text: AppLocalizations.of(context)!.winning),
                  AppText.subHeading(
                      text: AppLocalizations.of(context)!.percentage),
                ],
              ),
              width: size.width * 0.297,
              height: size.height * 0.13,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color(0xffeb5a46),
                  Color(0xffed6f4b),
                  Color(0xfff08e65),
                ], begin: Alignment.centerLeft, end: Alignment.centerRight),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
