import 'package:crazy_fantasy/core/widget/AppBar_custom.dart';
import 'package:flutter/material.dart';

import '../vip_view_body.dart';

class VipView extends StatelessWidget {
  const VipView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarCustom(title: 'vip اعدادت بطولة ' ,),
      body: VipViewBody(),
    );
  }
}
