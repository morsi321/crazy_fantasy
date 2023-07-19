import 'package:crazy_fantasy/core/utils/app_router.dart';
import 'package:crazy_fantasy/core/widget/text_field_custom.dart';
import 'package:crazy_fantasy/feauters/teams/Data/repos/addTeam/add_team_repo_impl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../Teams Data update/Data/repos/update_teams_repo_impl.dart';
import '../../view model/add_team_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Search extends StatefulWidget implements PreferredSizeWidget {
  const Search({Key? key})
      : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(170),
      child: AppBar(
        title: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: TextFromCustom(
            onChanged: (value) {
              BlocProvider.of<AddTeamCubit>(context).search(value);
            },
            width: double.infinity,
            height: 55,
            hintText: "Search",
            disableBorder: true,
            suffixIcon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
            fillColor: Colors.white.withOpacity(.1),
            label: '',
            style: const TextStyle(color: Colors.white),
          ),
        ),
        actions: [
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              Scaffold.of(context).openEndDrawer();
            },
            icon: const Icon(
              Icons.menu,
              size: 30,
              color: Colors.white,
            ),
          ),
        ],
        backgroundColor: const Color.fromRGBO(28, 22, 54, .9),
      ),
    );
  }
}
