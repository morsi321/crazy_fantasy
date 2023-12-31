import 'package:crazy_fantasy/core/widget/text_field_custom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../view model/add_team_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Search extends StatefulWidget implements PreferredSizeWidget {
  const Search({Key? key})
      : preferredSize = const Size.fromHeight(80),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 30,
                  color: Colors.white,
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: TextFromCustom(
                  // onFieldSubmitted: (value) {
                  //
                  // },
                  onChanged: (value) {
                    BlocProvider.of<AddTeamCubit>(context).search(value);
                    if (value.isEmpty) {
                      BlocProvider.of<AddTeamCubit>(context).teamsSearch.clear();
                    }
                  },
                  width: 300,
                  height: 60,
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
            ],
          ),
        ),
      ),
      automaticallyImplyLeading: false,

      backgroundColor: const Color.fromRGBO(28, 22, 54, .9),
    );
  }
}
