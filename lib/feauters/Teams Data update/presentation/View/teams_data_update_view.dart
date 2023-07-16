import 'package:crazy_fantasy/core/widget/AppBar_custom.dart';
import 'package:crazy_fantasy/feauters/Teams%20Data%20update/presentation/View/teams_data_update_view_body.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TeamsDataUpdateView extends StatelessWidget {
  const TeamsDataUpdateView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarCustom(
        title: "تحديث بيانات الفرق",
      ),
      body: TeamsDataUpdateViewBody(),

    );
  }
}
