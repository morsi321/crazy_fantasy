import 'package:flutter/material.dart';

import '../../../../../../core/widget/show_teams.dart';

class SelectTeams extends StatelessWidget {
  const SelectTeams({super.key});

  @override
  Widget build(BuildContext context) {
    return const ShowTeams (forOrg: true,);
  }
}
