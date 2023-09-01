// import 'dart:ui';
//
// import 'package:crazy_fantasy/core/widget/BoxColor.dart';
// import 'package:crazy_fantasy/feauters/Teams%20Data%20update/presentation/view%20model/update_data_team_cubit.dart';
// import 'package:crazy_fantasy/feauters/teams/presentation/view%20model/add_team_cubit.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../../../../core/widget/dailog_error.dart';
//
// class ShowLastUpdate extends StatefulWidget {
//   const ShowLastUpdate({super.key});
//
//   @override
//   State<ShowLastUpdate> createState() => _ShowLastUpdateState();
// }
//
// class _ShowLastUpdateState extends State<ShowLastUpdate> {
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final UpdateDataTeamCubit updateDataTeamCubit =
//         context.read<UpdateDataTeamCubit>();
//
//     return BlocConsumer<UpdateDataTeamCubit, UpdateDataTeamState>(
//       listener: (context, state) {
//         if (state is FailureGetLastDateUpdate) {
//           dialogError(
//             context,
//             state.message,
//             () => BlocProvider.of<UpdateDataTeamCubit>(context)
//                 .getLastDateUpdate(),
//           // );
//         }
//       },
//       builder: (context, state) {
//         if (state is LoadingGetTeamsState) {
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         }
//         return Container(
//           decoration: BoxDecoration(
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.5),
//                 spreadRadius: 5,
//                 blurRadius: 7,
//                 offset: Offset(0, 3),
//               ),
//             ],
//           ),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(10.0),
//             child: BackdropFilter(
//               filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
//               child: Container(
//                 width: double.infinity,
//                 height: 200,
//                 color: Colors.white.withOpacity(0.1),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Text('اخر تحديث للبيانات',
//                         style: TextStyle(
//                             fontSize: 20,
//                             fontFamily: 'janna',
//                             color: Colors.red)),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     Text(updateDataTeamCubit.lastDateUpdate,
//                         style: const TextStyle(
//                             fontSize: 20,
//                             fontFamily: 'janna',
//                             color: Colors.red)),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
