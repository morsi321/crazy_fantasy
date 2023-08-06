import 'package:crazy_fantasy/core/extension/MediaQueryValues.dart';
import 'package:crazy_fantasy/core/utils/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DrawerCustom extends StatelessWidget {
  const DrawerCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromRGBO(28, 22, 54, 1),
      child: Padding(
        padding: const EdgeInsets.only(right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              height: context.height * .10,
            ),
            const Center(
                child: Text(
              "الاعدادت البطولات",
              style: TextStyle(
                  color: Colors.red, fontSize: 26, fontWeight: FontWeight.bold),
            )),
            const SizedBox(
              height: 20,
            ),
            MoveToNewScreen(
                label: "تحديث البيانات", pathNewScreen: AppRouter.updateTeam),
            MoveToNewScreen(
                label: "اضافه منظم", pathNewScreen: AppRouter.addOrganizer),
            MoveToNewScreen(
                label: "الكاس", pathNewScreen: AppRouter.updateTeam),
            MoveToNewScreen(
                label: "الدوري الكلاسيكي", pathNewScreen: AppRouter.updateTeam),
            MoveToNewScreen(
                label: "VIP", pathNewScreen: AppRouter.vipChampionship),

          ],
        ),
      ),
    );
  }
}

class MoveToNewScreen extends StatelessWidget {
  const MoveToNewScreen(
      {super.key, required this.label, required this.pathNewScreen});

  final String label;
  final String pathNewScreen;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go(pathNewScreen),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 22),
        ),
      ),
    );
  }
}
