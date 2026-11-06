import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:two_dashboard/config/constants/padding_config.dart';
import 'package:two_dashboard/core/network/enums.dart';
import 'package:two_dashboard/core/widgets/animation/empty_status_animation.dart';
import 'package:two_dashboard/core/widgets/animation/error_status_animation.dart';
import 'package:two_dashboard/core/widgets/data-table/custom/why-us/loading_why_us_table.dart';
import 'package:two_dashboard/core/widgets/data-table/custom/why-us/why_us_table.dart';
import 'package:two_dashboard/core/widgets/dialog/status/error_dialog.dart';
import 'package:two_dashboard/core/widgets/dialog/status/loading_dialog.dart';
import 'package:two_dashboard/core/widgets/dialog/status/not_authorized_dialog.dart';
import 'package:two_dashboard/core/widgets/dialog/status/success_dialog.dart';
import 'package:two_dashboard/core/widgets/shimmers/card-loading/loading_site_card.dart';
import 'package:two_dashboard/core/widgets/shimmers/card-loading/loading_working_time_card.dart';
import 'package:two_dashboard/features/about-us%20&%20why-us/domain/entities/about_us_entity.dart';
import 'package:two_dashboard/features/about-us%20&%20why-us/presentation/bloc/about_us_why_us_bloc.dart';
import 'package:two_dashboard/features/about-us%20&%20why-us/presentation/widgets/site_card.dart';
import 'package:two_dashboard/features/about-us%20&%20why-us/presentation/widgets/working_time_card.dart';

class AboutUsWhyUsBlocStateHandling {
  Widget getAboutUs(AboutUsWhyUsState state, AboutUsEntity? aboutUsEntity) {
    if (state.getAboutUsStatus == CasualStatus.loading) {
      return const Row(
        children: [
          LoadingWorkingTimeCard(),
          PaddingConfig.w24,
          LoadingSiteCard(),
        ],
      );
    } else if (state.getAboutUsStatus == CasualStatus.success) {
      if (state.getAboutUsEntity == null) {
        return Center(child: EmptyStatusAnimation());
      } else {
        aboutUsEntity = state.getAboutUsEntity!;
        return Row(
          children: [
            WorkingTimeCard(workingTime: state.getAboutUsEntity!.aboutWorkTime),
            PaddingConfig.w24,
            SiteCard(site: state.getAboutUsEntity!.aboutSite),
          ],
        );
      }
    } else if (state.getAboutUsStatus == CasualStatus.failure) {
      return Center(child: ErrorStatusAnimation(errorMessage: state.message));
    } else {
      return const SizedBox();
    }
  }

  void createAboutUs(AboutUsWhyUsState state, BuildContext context) {
    if (state.createAboutUsStatus == CasualStatus.loading) {
      showLoadingDialog(context);
    } else if (state.createAboutUsStatus == CasualStatus.success) {
      context.pop();
      showSuccessDialog(context, () {
        context.pop();
      });
      context.read<AboutUsWhyUsBloc>().add(GetAboutUsEvent());
    } else if (state.createAboutUsStatus == CasualStatus.failure) {
      context.pop();
      showErrorDialog(context, state.message);
    } else if (state.createAboutUsStatus == CasualStatus.not_authorized) {
      context.pop();
      showNotAuthorizedDialog(context);
    }
  }

  void updateAboutUs(AboutUsWhyUsState state, BuildContext context) {
    if (state.updateAboutUsStatus == CasualStatus.loading) {
      showLoadingDialog(context);
    } else if (state.updateAboutUsStatus == CasualStatus.success) {
      context.pop();
      showSuccessDialog(context, () {
        context.pop();
      });
      context.read<AboutUsWhyUsBloc>().add(GetAboutUsEvent());
    } else if (state.updateAboutUsStatus == CasualStatus.failure) {
      context.pop();
      showErrorDialog(context, state.message);
    } else if (state.updateAboutUsStatus == CasualStatus.not_authorized) {
      context.pop();
      showNotAuthorizedDialog(context);
    }
  }

  Widget getWhyUsTable(AboutUsWhyUsState state) {
    if (state.getWhyUsStatus == CasualStatus.loading) {
      return const LoadingWhyUsTable();
    } else if (state.getWhyUsStatus == CasualStatus.success) {
      if (state.getWhyUsList.isEmpty) {
        return Center(child: EmptyStatusAnimation());
      } else {
        return WhyUsTable(whyUsList: state.getWhyUsList);
      }
    } else if (state.getWhyUsStatus == CasualStatus.failure) {
      return Center(child: ErrorStatusAnimation(errorMessage: state.message));
    } else {
      return const SizedBox();
    }
  }

  void createWhyUs(AboutUsWhyUsState state, BuildContext context) {
    if (state.createWhyUsStatus == CasualStatus.loading) {
      showLoadingDialog(context);
    } else if (state.createWhyUsStatus == CasualStatus.success) {
      context.pop();
      showSuccessDialog(context, () {
        context.pop();
      });
      context.read<AboutUsWhyUsBloc>().add(GetWhyUsEvent());
    } else if (state.createWhyUsStatus == CasualStatus.failure) {
      showErrorDialog(context, state.message);
    } else if (state.createWhyUsStatus == CasualStatus.not_authorized) {
      showNotAuthorizedDialog(context);
    }
  }

  void updateOrDeleteWhyUs(AboutUsWhyUsState state, BuildContext context) {
    if (state.updateWhyUsStatus == CasualStatus.loading ||
        state.deleteWhyUsStatus == CasualStatus.loading) {
      showLoadingDialog(context);
    } else if (state.updateWhyUsStatus == CasualStatus.success ||
        state.deleteWhyUsStatus == CasualStatus.success) {
      context.pop();
      showSuccessDialog(context, () {
        context.pop();
      });
      context.read<AboutUsWhyUsBloc>().add(GetWhyUsEvent());
    } else if (state.updateWhyUsStatus == CasualStatus.failure ||
        state.deleteWhyUsStatus == CasualStatus.failure) {
      context.pop();
      showErrorDialog(context, state.message);
    } else if (state.updateWhyUsStatus == CasualStatus.not_authorized ||
        state.deleteWhyUsStatus == CasualStatus.not_authorized) {
      context.pop();
      showNotAuthorizedDialog(context);
    }
  }
}
