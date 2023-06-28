import 'package:crazy_fantasy/core/extension/MediaQueryValues.dart';
import 'package:flutter/material.dart';

import 'BoxColor.dart';
import 'blurBody.dart';

void dialogError(context, String? message, Future<void> Function() retryFun,
    {Future<void> Function()? okFun}) {
  showDialog(
      barrierColor: Colors.black.withOpacity(0.2),
      // barrierDismissible: false,
      context: context,
      builder: (
        context,
      ) =>
          Center(
            child: BlurBody(
                borderRadius: BorderRadius.circular(10),
                height: 220,
                width: context.width * 0.85,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Container(
                        width: 120,
                        height: 50,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(10)),
                        child: const Center(
                          child: Text("Error",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(message ?? "Please try again later",
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500)),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // IconButton(onPressed: (){}, icon: const Icon(Icons.sync,color: Colors.white,)),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .popUntil((route) => route.isFirst);
                                retryFun();
                              },
                              child: const BoxColor(
                                width: 100,
                                height: 50,
                                child: Icon(
                                  Icons.sync,
                                  color: Colors.white,
                                ),
                              )),
                          GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .popUntil((route) => route.isFirst);
                              },
                              child: const BoxColor(
                                width: 100,
                                height: 50,
                                child: Icon(
                                  Icons.thumb_up,
                                  color: Colors.white,
                                ),
                              )),
                        ],
                      ),
                    )
                  ],
                )),
          ));
}
