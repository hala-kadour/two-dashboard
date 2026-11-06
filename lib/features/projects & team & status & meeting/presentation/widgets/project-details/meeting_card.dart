import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_dashboard/config/constants/padding_config.dart';
import 'package:two_dashboard/config/theme/color.dart';
import 'package:two_dashboard/config/theme/text_style.dart';
import 'package:two_dashboard/core/functions/bloc-state-handling/meeting_bloc_state_handling.dart';
import 'package:two_dashboard/core/helper/helper_functions.dart';
import 'package:two_dashboard/core/widgets/buttons/hovered-buttons/delete_button.dart';
import 'package:two_dashboard/core/widgets/buttons/hovered-buttons/edit_button.dart';
import 'package:two_dashboard/core/widgets/container/custom_rounder_container.dart';
import 'package:two_dashboard/core/widgets/container/status-containers/dynamic_status_container.dart';
import 'package:two_dashboard/core/widgets/container/status-containers/time_ago_container.dart';
import 'package:two_dashboard/core/widgets/dialog/global/confirm_deletion_dialog.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/data/models/meeting/meeting_model.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/presentation/bloc/project_status_team_meeting_bloc.dart';

class MeetingCard extends StatelessWidget {
  const MeetingCard({super.key, required this.meetingModel});
  final MeetingModel meetingModel;

  @override
  Widget build(BuildContext context) {
    return CustomRounderContainer(
      margin: EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: AppColors.grayshade1,
            ),
            child: Text(
              "🗓️ Meeting Type : ${meetingModel.meetingType}",
              style: AppTextStyle.bodySm(color: AppColors.fontLightGray),
            ),
          ),
          PaddingConfig.w8,
          // Left Time For The Meeting
          DynamicStatusContainer(
            status: HelperFunctions.getDurationText(
              DateTime.now(),
              meetingModel.date,
            ),
          ),
          // Last Time was Updated
          TimeAgoContainer(date: meetingModel.updatedAt),
          Row(
            children: [
              BlocListener<
                ProjectStatusTeamMeetingBloc,
                ProjectStatusTeamMeetingState
              >(
                listener: (context, state) {
                  MeetingBlocStateHandling().updateMeeting(state, context);
                },
                listenWhen:
                    (previous, current) =>
                        previous.updateMeetingStatus !=
                        current.updateMeetingStatus,
                child: EditButton(onTap: () {}),
              ),
              PaddingConfig.w8,
              BlocListener<
                ProjectStatusTeamMeetingBloc,
                ProjectStatusTeamMeetingState
              >(
                listener: (context, state) {
                  MeetingBlocStateHandling().deleteMeeting(state, context);
                },
                listenWhen:
                    (previous, current) =>
                        previous.deleteMeetingStatus !=
                        current.deleteMeetingStatus,
                child: DeleteButton(
                  onTap:
                      () =>
                          confirmDeletionDialog(context, "this meeting ?", () {
                            context.read<ProjectStatusTeamMeetingBloc>().add(
                              DeleteMeetingEvent(
                                projectId: meetingModel.projectId.toString(),
                                meetingId: meetingModel.id.toString(),
                              ),
                            );
                          }),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
