import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showDailogValidtion(
    {required BuildContext context, required List<String> errorsValidation}) {
  showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('تنبيه',style: TextStyle(fontFamily: 'janna'),),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: errorsValidation
                .map((e) => Directionality(
                      textDirection: TextDirection.rtl,
                  child: Row(
                        children: [
                          const Icon(
                            Icons.error,
                            color: Colors.red,
                            size: 30,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              e,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: Colors.red, fontSize: 16,fontFamily: "Janna" ),
                            ),
                          ),
                        ],
                      ),
                ))
                .toList(),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('حسنا',style: TextStyle(fontFamily: 'janna'),))
          ],
        );
      });
}
