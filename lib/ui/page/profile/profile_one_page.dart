import 'package:flutter/material.dart';
import 'package:bpulsa/ui/widgets/common_divider.dart';
import 'package:bpulsa/ui/widgets/common_scaffold.dart';
import 'package:bpulsa/ui/widgets/profile_tile.dart';

class ProfileOnePage extends StatelessWidget {
  var deviceSize;

  //Column1
  Widget profileColumn() => Container(
        height: deviceSize.height * 0.24,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ProfileTile(
              title: "VulnWalker",
              subtitle: "Developer",
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.chat),
                  color: Colors.black,
                  onPressed: () {},
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius:
                        new BorderRadius.all(new Radius.circular(50.0)),
                    border: new Border.all(
                      color: Colors.black,
                      width: 4.0,
                    ),
                  ),
                  child: CircleAvatar(
                    backgroundImage: AssetImage("assets/images/pk.jpg"),
                    foregroundColor: Colors.black,
                    radius: 40.0,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.call),
                  color: Colors.black,
                  onPressed: () {},
                ),
              ],
            )
          ],
        ),
      );

  //column2

  //column3
  Widget descColumn() => Container(
        height: deviceSize.height * 0.13,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: Text(
              "Serabutan Developer Expert for everysthing. Passionate #Flutter, #Android Developer. #Entrepreneur #YouTuber",
              style: TextStyle(fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
              maxLines: 3,
              softWrap: true,
            ),
          ),
        ),
      );
  //column4
  Widget accountColumn() => Container(
        height: deviceSize.height * 0.3,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ProfileTile(
                  title: "Website",
                  subtitle: "rm-rf.studio",
                ),
                ProfileTile(
                  title: "Phone",
                  subtitle: "+6281223744803",
                ),
                ProfileTile(
                  title: "YouTube",
                  subtitle: "youtube.com/vulnwalker",
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ProfileTile(
                  title: "Location",
                  subtitle: "Indonesia",
                ),
                ProfileTile(
                  title: "Email",
                  subtitle: "vulnwalker@tuyul.online",
                ),
                ProfileTile(
                  title: "Facebook",
                  subtitle: "fb.com/vulnwalker",
                ),
              ],
            ),
          ],
        ),
      );

  Widget bodyData() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          profileColumn(),
          CommonDivider(),
          followColumn(deviceSize),
          CommonDivider(),
          descColumn(),
          CommonDivider(),
          accountColumn()
        ],
      ),
    );
  }

  Widget _scaffold() => CommonScaffold(
        appTitle: "View Profile",
        bodyData: bodyData(),
        showFAB: true,
        // showDrawer: true,
        floatingIcon: Icons.edit,
      );

  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    return _scaffold();
  }
}

Widget followColumn(Size deviceSize) => Container(
      height: deviceSize.height * 0.13,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          ProfileTile(
            title: "1.5K",
            subtitle: "Posts",
          ),
          ProfileTile(
            title: "2.5K",
            subtitle: "Followers",
          ),
          ProfileTile(
            title: "10K",
            subtitle: "Comments",
          ),
          ProfileTile(
            title: "1.2K",
            subtitle: "Following",
          )
        ],
      ),
    );
