import 'package:flutter/material.dart';
import 'package:github/app/data/models/repos.dart';
import 'package:github/app/routes/app_routes.dart';
import 'package:github/notifier/user_provider.dart';
import 'package:provider/provider.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({Key key}) : super(key: key);

  @override
  _UserDetailsScreenState createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final userInfo = context.watch<UserProvider>().user;
    final List<Repos> reposInfo = context.watch<UserProvider>().repos;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 50),
          Container(
            height: 125,
            decoration: BoxDecoration(
                border: Border(
              bottom: BorderSide(
                color: Colors.white,
              ),
            )),
            child: Column(
              children: [
                ListTile(
                  isThreeLine: true,
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(userInfo.avatar_url),
                  ),
                  title: Text(
                    userInfo.name ?? 'Default Name',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    userInfo.bio ?? 'Bio',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, bottom: 10.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 20),
                      Text(
                        '${userInfo.followers} Followers',
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(width: 20),
                      Text(
                        '${userInfo.following} following',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              'Repositories',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: reposInfo.map((item) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(AppRoutes.webview, arguments: item.html_url);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 6),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(12.0),
                        ),
                      ),
                      child: Card(
                        color: Colors.black,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              item.name,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.only(top: 8.0),
                            //   child: Text(
                            //     "time" ?? '',
                            //     style: TextStyle(
                            //       color: Colors.grey,
                            //       fontSize: 10,
                            //     ),
                            //     overflow: TextOverflow.ellipsis,
                            //     maxLines: 1,
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}
