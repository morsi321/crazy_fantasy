
import 'package:crazy_fantasy/feauters/Teams%20Data%20update/Data/repos/update_teams_repo_impl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class AppBarCustom extends StatefulWidget implements PreferredSizeWidget {
  const AppBarCustom({Key? key, required this.title})
      : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  final String title;

  @override
  final Size preferredSize;

  @override
  _AppBarCustomState createState() => _AppBarCustomState();
}

class _AppBarCustomState extends State<AppBarCustom> {
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(170),
      child: AppBar(
        title: Text(widget.title,
            style: const TextStyle(
                fontSize: 22, fontFamily: 'janna', color: Colors.white)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: () async {
                await UpdateTeamsRepoImpl().championshipVip(1);
              },
              icon: const Icon(
                Icons.menu,
                size: 30,
                color: Colors.white,
              ),
            ),
          ),
        ],
        backgroundColor: const Color.fromRGBO(28, 22, 54, .9),
      ),
    );
  }
}
