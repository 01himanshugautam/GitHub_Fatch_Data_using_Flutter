import 'package:flutter/material.dart';
import 'package:github/notifier/user_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userNameController = TextEditingController();

    final model = context.watch<UserProvider>();

    Future<void> fetchUserInfo() async {
      await context
          .read<UserProvider>()
          .getUser(username: userNameController.text, ctx: context);
      print(userNameController);
      await context
          .read<UserProvider>()
          .getUserRepos(username: userNameController.text, ctx: context);
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/github.png',
            color: Colors.white,
            height: 100,
            width: 100,
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: userNameController,
              cursorColor: Colors.white,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Username . . .",
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.white, width: 3.0)),
                enabledBorder: const OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 2.0),
                ),
                hintStyle: TextStyle(
                  color: Colors.grey.withOpacity(.5),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60),
            child: ElevatedButton(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Get my Github Profile'),
                      const SizedBox(
                        width: 10,
                      ),
                      model.isLoading
                          ? CircularProgressIndicator(
                              backgroundColor: Colors.white,
                            )
                          : const SizedBox.shrink()
                    ],
                  ),
                ),
                onPressed: () {
                  print(userNameController);
                  fetchUserInfo();
                }),
          )
        ],
      ),
    );
  }
}
