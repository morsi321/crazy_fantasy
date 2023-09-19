import 'package:crazy_fantasy/core/widget/background_image.dart';
import 'package:crazy_fantasy/feauters/organizers/presentation/view/widget/add%20org/appBarOrg.dart';

import 'package:flutter/material.dart';

import 'oragnizer_view_body.dart';
import 'widget/add org/navigation_button.dart';

class OrganizerView extends StatelessWidget {
  const OrganizerView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        appBar: AppBarOrg(),
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            BackgroundImage(child: OrganizerViewBody()),
            NavigationButton(),
          ],
        ));
  }
}
