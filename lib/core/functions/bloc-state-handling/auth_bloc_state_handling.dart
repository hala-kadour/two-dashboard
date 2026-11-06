import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:two_dashboard/config/routes/app_route_config.dart';
import 'package:two_dashboard/core/network/enums.dart';
import 'package:two_dashboard/core/services/shared_preferences_services.dart';
import 'package:two_dashboard/core/widgets/dialog/status/error_dialog.dart';
import 'package:two_dashboard/core/widgets/dialog/status/loading_dialog.dart';
import 'package:two_dashboard/core/widgets/dialog/status/not_authorized_dialog.dart';
import 'package:two_dashboard/core/widgets/dialog/status/success_dialog.dart';
import 'package:two_dashboard/features/auth/presentation/bloc/auth_role_profile_bloc.dart';

class AuthBlocStateHandling {
  // Sign Up
  Future<void> signUp(AuthRoleProfileState state, BuildContext context) async {
    if (state.authModelStatus == CasualStatus.loading) {
      showLoadingDialog(context);
    } else if (state.authModelStatus == CasualStatus.success) {
      await SharedPreferencesServices.setUserToken(state.authModel!.token);
      context.pop();
      context.pushReplacementNamed(AppRouteConfig.fillEmployeeProfile);
    } else if (state.authModelStatus == CasualStatus.failure ||
        state.authModelStatus == CasualStatus.not_authorized) {
      context.pop();
      showErrorDialog(context, state.message);
    } else {
      const SizedBox();
    }
  }

  // Login
  Future<void> login(AuthRoleProfileState state, BuildContext context) async {
    if (state.authModelStatus == CasualStatus.loading) {
      showLoadingDialog(context);
    } else if (state.authModelStatus == CasualStatus.success) {
      await SharedPreferencesServices.setUserToken(state.authModel!.token);
      context.pop();
      context.pushReplacementNamed(AppRouteConfig.allProjects);
    } else if (state.authModelStatus == CasualStatus.failure ||
        state.authModelStatus == CasualStatus.not_authorized) {
      context.pop();
      showErrorDialog(context, state.message);
      print(state.message);
    } else {
      const SizedBox();
    }
  }

  // Logout
  void logoutStateHandling(
    AuthRoleProfileState state,
    BuildContext context,
  ) async {
    if (state.logoutStatusStatus == CasualStatus.loading) {
      showLoadingDialog(context);
    } else if (state.logoutStatusStatus == CasualStatus.success) {
      context.pop();
      await SharedPreferencesServices.deleteUserToken();
      showSuccessDialog(context, () {
        context.pushReplacementNamed(AppRouteConfig.login);
        context.pop();
      });
    } else if (state.authModelStatus == CasualStatus.failure) {
      context.pop();
      showErrorDialog(context, state.message);
    } else if (state.authModelStatus == CasualStatus.not_authorized) {
      context.pop();
      showNotAuthorizedDialog(context);
    }
  }

  // Fill Employee Profile
  void fillEmployeeProfile(AuthRoleProfileState state, BuildContext context) {
    if (state.updateEmployeeProfileStatus == CasualStatus.loading) {
      showLoadingDialog(context);
    } else if (state.updateEmployeeProfileStatus == CasualStatus.success) {
      context.pop();
      context.pushReplacementNamed(AppRouteConfig.allProjects);
    } else if (state.updateEmployeeProfileStatus == CasualStatus.failure) {
      context.pop();
      showErrorDialog(context, state.message);
    }
  }
}
