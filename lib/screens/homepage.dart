import 'dart:convert';
import 'package:bluestacks/widgets/language_picker.dart';
import 'package:http/http.dart' as http;
import 'package:bluestacks/models/game.dart';
import 'package:bluestacks/widgets/game_tile.dart';
import 'package:bluestacks/widgets/stats.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  //user api
  List<Game> allGames = [];
  final db = FirebaseFirestore.instance;
  List<Map> userData = [];
  bool gotData = false;

  void getData() async {
    await db.collection("User").doc("User1").get().then((value) {
      userData.add({
        'name': value.get('name'),
        'percentage': value.get('percentage'),
        'played': value.get('played'),
        'won': value.get('won'),
        'rating': value.get('rating'),
        'imgUrl': value.get('imgUrl'),
        'username': value.get('username'),
      });
    });
    setState(() {
      gotData = true;
    });
  }

  List<Game> gameList = [];
  bool gameLoaded = false;

  void fetchAndSetGameData() async {
    Map data;
    try {
      String url =
          'http://tournaments-dot-game-tv-prod.uc.r.appspot.com/tournament/api/tournaments_list_v2?limit=10&status=all';
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        data = json.decode(response.body);
        data['data']['tournaments'].forEach(
          (e) {
            gameList.add(Game(e['name'], e['game_name'], e['cover_url']));
          },
        );
      } else {
        throw Exception('Not able to download json data');
      }
      setState(() {
        gameLoaded = true;
      });
    } catch (e) {
      print('Data Provider error');
    }
  }

  @override
  void initState() {
    getData();
    fetchAndSetGameData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth(BuildContext context) =>
        MediaQuery.of(context).size.width;
    return Scaffold(
      body: !gotData && !gameLoaded
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset(
                          'assets/drawer.svg',
                        ),
                        // SizedBox(
                        //   width: deviceWidth(context) * 0.225,
                        // ),
                        Text(
                          userData[0]['username'],

                          // 'Flyingwolf',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        LanguagePicker(),
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.18,
                    padding: EdgeInsets.only(
                        right: 15, left: 20, top: 0, bottom: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(
                              right: deviceWidth(context) * 0.025),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.network(
                              userData[0]['imgUrl'],
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userData[0]['name'],
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: deviceWidth(context) * 0.01,
                                  horizontal: deviceWidth(context) * 0.03),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(
                                  width: 1,
                                  color: Colors.blue.shade700,
                                ),
                              ),
                              height: MediaQuery.of(context).size.height * 0.07,
                              width: MediaQuery.of(context).size.width * 0.45,
                              child: Row(
                                children: [
                                  Text(
                                    userData[0]['rating'] + "  ",
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.blue.shade700,
                                    ),
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!.elo_rating,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Stats(userData[0]['played'], userData[0]['won'],
                      userData[0]['percentage']),
                  SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Text(
                        AppLocalizations.of(context)!.recommended_for_you,
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  Center(
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, i) => GameTile(
                        gameList[i].name,
                        gameList[i].coverUrl,
                        gameList[i].gameName,
                      ),
                      itemCount: gameList.length,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
