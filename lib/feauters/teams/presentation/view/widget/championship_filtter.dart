// import 'package:crazy_fantasy/core/constance/constance.dart';
// import 'package:flutter/material.dart';
//
// import '../../view model/add_team_cubit.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// class ChampionshipFilter extends StatelessWidget {
//   const ChampionshipFilter({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         width: double.infinity,
//         height: 60,
//         color: Colors.white.withOpacity(.05),
//         child: ListView.builder(
//             itemCount: championShip.length + 1,
//             scrollDirection: Axis.horizontal,
//             itemBuilder: (context, index) {
//               if (index == 0) {
//                 return const ItemChampionship(
//                   championShip: "جميع البطولات",
//                 );
//               }
//               return ItemChampionship(
//                 championShip: championShip[index - 1],
//               );
//             }));
//   }
// }
//
// class ItemChampionship extends StatelessWidget {
//   const ItemChampionship({super.key, required this.championShip});
//
//   final String championShip;
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () =>
//         BlocProvider.of<AddTeamCubit>(context)
//             .changeChampionshipSelected(championShip),
//       child: BlocBuilder<AddTeamCubit, AddTeamState>(
//         builder: (context, state) {
//           return Container(
//             width: 125,
//             height: 45,
//             margin: const EdgeInsets.all(5),
//             decoration: BoxDecoration(
//               color: championShip ==
//                       BlocProvider.of<AddTeamCubit>(context)
//                           .championshipSelected
//                   ? Colors.white.withOpacity(.1)
//                   : Colors.transparent,
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Center(
//               child: Text(
//                 championShip,
//                 style:
//                     const TextStyle(color: Colors.white, fontFamily: 'janna'),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
