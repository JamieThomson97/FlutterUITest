import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NowPlayingScreen extends StatelessWidget {
  const NowPlayingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
      color: Colors.pink[900],
      child: Column(
        children: [
          SizedBox(
            child: Container(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Kaytranada",
                    style: Theme.of(context).textTheme.headline6,
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    "Pitchfork 2018 - Paris",
                    style: Theme.of(context).textTheme.headline5,
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            height: 300,
          ),
          SizedBox(
            height: 300,
          ),
          Container(
            height: 50,
            child: CustomScrollView(
              scrollDirection: Axis.horizontal,
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      if (index < 42) {
                        return Container(
                          width: 5,
                          // child: Text('Item: $index'),
                        );
                      }
                      bool isBar = index % 2 == 0;
                      return Container(
                        alignment: Alignment.center,
                        color: isBar ? Colors.blue : Colors.transparent,
                        height: 30,
                        width: isBar ? 4 : 2,
                        // child: Text('Item: $index'),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
