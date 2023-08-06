import 'package:crazy_fantasy/core/extension/MediaQueryValues.dart';
import 'package:crazy_fantasy/feauters/organizers/presentation/view%20Model/add_orgaizer_cubit.dart';
import 'package:crazy_fantasy/feauters/organizers/presentation/view/widget/list_organizer_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ShowOrganizer extends StatefulWidget {
  const ShowOrganizer({super.key});

  @override
  State<ShowOrganizer> createState() => _ShowOrganizerState();
}

class _ShowOrganizerState extends State<ShowOrganizer> {
  @override
  void initState() {
    BlocProvider.of<AddOrganizerCubit>(context).getOrganizers();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: context.height * 0.01,
        ),

        BlocBuilder<AddOrganizerCubit, AddOrganizerState>(
          builder: (context, state) {
            if (state is GetOrganizerLoadingState) {
              return const Padding(
                padding: EdgeInsets.only(bottom: 120),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
              return Expanded(
                child: ListOrganizerView(
                  organizers: BlocProvider.of<AddOrganizerCubit>(context).organizers,
                ),
              );

            }

        ),
      ],
    );
  }
}
