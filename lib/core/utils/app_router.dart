// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:go_router/go_router.dart';
// import 'package:map/features/MeasureAreaPage/presentation/modelViews/measure_area_cubit.dart';
// import 'package:map/features/MeasureAreaPage/presentation/views/measure_area_view.dart';
// import 'package:map/features/AddProperty/presentation/view/widgets/addProperty.dart';
// import 'package:map/features/ShowRealEstata/Data/models/properties_model.dart';
// import 'package:map/features/home/view/home_view.dart';
// import 'package:map/features/loginAndSignup/Presentaion/View/login_signup.dart';
// import 'package:map/features/loginAndSignup/Presentaion/View/widget/login_signup_view_body.dart';
//
// import '../../features/DetailsProperty/Presentation/view/DetailsPropertyView.dart';
// import '../../features/MapPage/presentation/map page/views/test.dart';
// import '../../features/Studio3D/presentation/views/3d_studio_View.dart';
// import '../../tessty.dart';
//
// class AppRouter {
//   static String mapPage = '/m';
//   static String measureArea = '/measureArea';
//   static String studio3D = '/studio3d';
//   static String detailsProperty = '/detailsProperty';
//   static String loginAndSignup = '/';
//
//   static final GoRouter router = GoRouter(
//     routes: <RouteBase>[
//       GoRoute(
//         path: loginAndSignup,
//         builder: (BuildContext context, GoRouterState state) {
//           return const LoginAndSignupView();
//         },
//       ),
//       GoRoute(
//         path: mapPage,
//         builder: (BuildContext context, GoRouterState state) {
//           // return const BismAllah() ;
//           return const HomeView();
//           // return  DraggableMarkerMap();
//           // return const SaleView();
//           // return const BismAllah();
//         },
//       ),
//       GoRoute(
//         path: measureArea,
//         builder: (BuildContext context, GoRouterState state) {
//           return const MeasureAreaView();
//         },
//       ),
//       GoRoute(
//         path: detailsProperty,
//         builder: (BuildContext context, GoRouterState state) {
//           return DetailsPropertyView(
//             property: state.extra as Property,
//           );
//         },
//       ),
//       GoRoute(
//         path: studio3D,
//         builder: (BuildContext context, GoRouterState state) {
//           return const Studio3D();
//         },
//       ),
//     ],
//   );
// }
