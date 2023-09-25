import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return
        // color: Colors.black.withOpacity(0.5),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/images/loading.json'),
            const SizedBox(height: 20,),
            const Text("جاري تحميل البيانات",style: TextStyle(color: Colors.red,fontSize: 30),),

          ],
        );
  }
}
