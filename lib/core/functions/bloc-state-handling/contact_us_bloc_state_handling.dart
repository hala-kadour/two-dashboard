import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:two_dashboard/core/network/enums.dart';
import 'package:two_dashboard/core/widgets/animation/error_status_animation.dart';
import 'package:two_dashboard/core/widgets/animation/unauthorized_status_animation.dart';
import 'package:two_dashboard/core/widgets/data-table/custom/contact-us/contact_us_table.dart';
import 'package:two_dashboard/core/widgets/data-table/custom/contact-us/loading_contact_us_table.dart';
import 'package:two_dashboard/core/widgets/dialog/status/error_dialog.dart';
import 'package:two_dashboard/core/widgets/dialog/status/loading_dialog.dart';
import 'package:two_dashboard/core/widgets/dialog/status/success_dialog.dart';
import 'package:two_dashboard/features/contact-us/presentation/bloc/contact_us_bloc.dart';

class ContactUsBlocStateHandling {
  Widget getContactUsTable(ContactUsState state) {
    if (state.contactUsListStatus == CasualStatus.loading) {
      return const LoadingContactUsTable();
    } else if (state.contactUsListStatus == CasualStatus.success) {
      return ContactUsTable(contactUsList: state.contactUsList);
    } else if (state.contactUsListStatus == CasualStatus.failure) {
      return Center(child: ErrorStatusAnimation(errorMessage: state.message));
    } else if (state.contactUsListStatus == CasualStatus.not_authorized) {
      return Center(child: UnauthorizedStatusAnimation());
    } else {
      return const SizedBox();
    }
  }

  void toggleContactUsApprovedOrSeen(
    ContactUsState state,
    BuildContext context,
  ) {
    if (state.approvedMarkerStatus == CasualStatus.loading ||
        state.seenMarkerStatus == CasualStatus.loading) {
      showLoadingDialog(context);
    } else if (state.approvedMarkerStatus == CasualStatus.success ||
        state.seenMarkerStatus == CasualStatus.success) {
      context.pop();
      showSuccessDialog(context, () {
        context.pop();
      });
    } else if (state.approvedMarkerStatus == CasualStatus.failure ||
        state.seenMarkerStatus == CasualStatus.failure) {
      context.pop();
      showErrorDialog(context, state.message);
    } else if (state.approvedMarkerStatus == CasualStatus.not_authorized ||
        state.seenMarkerStatus == CasualStatus.not_authorized) {
      context.pop();
      showErrorDialog(context, state.message);
    }
  }
}
