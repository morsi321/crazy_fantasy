import 'package:crazy_fantasy/core/widget/line.dart';

import 'package:flutter/material.dart';

import '../../../../../../core/widget/drop_down_custom.dart';
import '../../../../../../core/widget/labelAndTextForm.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../view Model/add_orgaizer_cubit.dart';
import '../image_organizer.dart';
import 'championships.dart';

class AddOrganizerWidget extends StatelessWidget {
  const AddOrganizerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final addOrganizerCubit = context.read<AddOrganizerCubit>();
    return WillPopScope(
      onWillPop: () async {
        addOrganizerCubit.changeIndexPageOrganizer(true);
        return true;
      },
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: SingleChildScrollView(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                LabelAndTextForm(
                  label: 'اسم المنظم ',
                  controller: addOrganizerCubit.name,
                  enable: addOrganizerCubit.isView,
                ),
                const SizedBox(height: 20),
                LabelAndTextForm(
                  label: 'رقم هاتف ',
                  controller: addOrganizerCubit.phone,
                  enable: addOrganizerCubit.isView,
                ),
                const Line(),
                const Championships(),
                const Line(),
                const SizedBox(height: 20),
                BlocBuilder<AddOrganizerCubit, AddOrganizerState>(
                  builder: (context, state) {
                    return DroDownCustom(
                      onTap: (String? value) {
                        addOrganizerCubit.changeCountTeams(value!);
                      },
                      items: const ["512", "256", "128"],
                      labelDropDown: "عدد الفرق",
                      selectedValue: addOrganizerCubit.countTeams,
                      disable: false,
                    );
                  },
                ),
                const SizedBox(height: 20),
                LabelAndTextForm(
                  label: ' رقم واتس اب ',
                  controller: addOrganizerCubit.whatsApp,
                  enable: addOrganizerCubit.isView,
                ),
                const SizedBox(height: 20),
                LabelAndTextForm(
                  label: ' فيس بوك ',
                  controller: addOrganizerCubit.faceBook,
                  enable: addOrganizerCubit.isView,
                ),
                const SizedBox(height: 20),
                LabelAndTextForm(
                  label: ' تويتر ',
                  controller: addOrganizerCubit.twiter,
                  enable: addOrganizerCubit.isView,
                ),
                const SizedBox(height: 20),
                LabelAndTextForm(
                  label: ' انستجرام ',
                  controller: addOrganizerCubit.instagram,
                  enable: addOrganizerCubit.isView,
                ),
                const SizedBox(height: 20),
                LabelAndTextForm(
                  label: ' تيك توك ',
                  controller: addOrganizerCubit.tiktok,
                  enable: addOrganizerCubit.isView,
                ),
                const Center(child: ImageOrganizer()),
                const SizedBox(height: 20),
                LabelAndTextForm(
                  label: ' الوصف خاص بالمنظم ',
                  controller: addOrganizerCubit.description,
                  enable: addOrganizerCubit.isView,
                ),
                const SizedBox(height: 580),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
