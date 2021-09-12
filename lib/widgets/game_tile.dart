import 'package:flutter/material.dart';

// ignore: must_be_immutable
class GameTile extends StatelessWidget {
  String imgUrl = '';
  String name = '';
  String gameName = '';
  GameTile(String name, String imgUrl, String gameName) {
    this.name = name;
    this.imgUrl = imgUrl;
    this.gameName = gameName;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      margin: EdgeInsets.symmetric(vertical: 12),
      width: MediaQuery.of(context).size.width * 0.92,
      height: MediaQuery.of(context).size.height * 0.24,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(3.0, 3.0),
            blurRadius: 30.0,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Stack(
          children: [
            Image.network(
              imgUrl,
              fit: BoxFit.fill,
              width: MediaQuery.of(context).size.width * 0.92,
              height: MediaQuery.of(context).size.height * 0.24,
            ),
            Positioned(
              bottom: 0,
              child: Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width * 0.92,
                height: MediaQuery.of(context).size.height * 0.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Text(
                              name,
                              softWrap: false,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 20),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Text(
                              gameName,
                              softWrap: false,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 15),
                      child: Icon(
                        Icons.keyboard_arrow_right_outlined,
                        size: 35,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
