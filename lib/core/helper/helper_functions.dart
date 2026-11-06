import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:two_dashboard/config/strings/text_strings.dart';
import 'package:two_dashboard/config/theme/color.dart';
import 'package:two_dashboard/core/network/enums.dart';

class HelperFunctions {
  static String getTimeAgo(DateTime dateTime) {
    final Duration difference = DateTime.now().difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
    } else {
      return 'just now';
    }
  }

  static String getDurationText(DateTime startDate, DateTime endDate) {
    final duration = endDate.difference(startDate);

    if (duration.inDays < 0) return "End Date Must Be After The Strating Date.";

    final months = (duration.inDays / 30).floor();
    final days = duration.inDays % 30;

    if (months > 0 && days > 0) {
      return "$months month $days day";
    } else if (months > 0) {
      return "$months month";
    } else {
      return "$days day";
    }
  }

  // Formate Date Time

  static String formatDate(DateTime date) {
    return DateFormat('yyyy/MM/dd').format(date);
  }

  static String formateDateForBack(DateTime date) {
    final formatted = DateFormat('yyyy-MM-dd HH:mm:ss').format(date);
    return formatted;
  }

  // Get Status By Number Or Name
  static ProjectType getProjectTypeByName(String value) {
    if (value.toLowerCase().contains("mob") || value.contains("موب")) {
      return ProjectType.mobile;
    } else if (value.toLowerCase().contains("web") || value.contains("موق")) {
      return ProjectType.website;
    } else if (value.toLowerCase().contains("syst") || value.contains("تحل")) {
      return ProjectType.systemAnalysis;
    } else if (value.toLowerCase().contains("soft") || value.contains("اختب")) {
      return ProjectType.softwareTesting;
    } else {
      return ProjectType.maintain;
    }
  }

  static CooperationType getCooperationTypeByName(String value) {
    if (value.toLowerCase().contains("anal") || value.contains("تحل")) {
      return CooperationType.analysis;
    } else if (value.toLowerCase().contains("deve") || value.contains("تطو")) {
      return CooperationType.development;
    } else if (value.toLowerCase().contains("tes") || value.contains("اختب")) {
      return CooperationType.test;
    } else {
      return CooperationType.managment;
    }
  }

  static TaskStatus getTaskStatusByName(String value) {
    if (value.toLowerCase().contains("pen")) {
      return TaskStatus.pended;
    } else if (value.toLowerCase().contains("in pro")) {
      return TaskStatus.inProgress;
    } else if (value.toLowerCase().contains("in rev")) {
      return TaskStatus.inReview;
    } else if (value.toLowerCase().contains("to d")) {
      return TaskStatus.toDo;
    } else if (value.toLowerCase().contains("done")) {
      return TaskStatus.completed;
    } else {
      return TaskStatus.pended;
    }
  }

  static TaskStatus getTaskStatusByNum(int value) {
    switch (value) {
      case 0:
        return TaskStatus.pended;
      case 1:
        return TaskStatus.toDo;
      case 2:
        return TaskStatus.inProgress;
      case 3:
        return TaskStatus.inReview;
      case 4:
        return TaskStatus.completed;
      case 5:
        return TaskStatus.canceled;
    }
    return TaskStatus.pended;
  }

  static ProjectVisibility getVisibilityByNum(int value) {
    if (value == 0) {
      return ProjectVisibility.public;
    } else {
      return ProjectVisibility.private;
    }
  }

  static int getVisibiltyNum(ProjectVisibility value) {
    if (value == ProjectVisibility.private) {
      return 1;
    } else {
      return 0;
    }
  }

  static TaskPriority getPriorityByName(String value) {
    if (value.toLowerCase().contains("lo")) {
      return TaskPriority.low;
    } else if (value.toLowerCase().contains("mid")) {
      return TaskPriority.medium;
    } else {
      return TaskPriority.high;
    }
  }

  static String getPriorityName(TaskPriority value) {
    switch (value) {
      case TaskPriority.low:
        return TextStrings.low;
      case TaskPriority.medium:
        return TextStrings.mid;
      case TaskPriority.high:
        return TextStrings.high;
    }
  }

  // Project Status Title
  static String getTaskStatusTitle(TaskStatus value) {
    switch (value) {
      case TaskStatus.pended:
        return TextStrings.pending;
      case TaskStatus.toDo:
        return TextStrings.toDo;
      case TaskStatus.inProgress:
        return TextStrings.inProgress;
      case TaskStatus.inReview:
        return TextStrings.inReview;
      case TaskStatus.completed:
        return TextStrings.completed;
      case TaskStatus.canceled:
        return TextStrings.canceled;
    }
  }

  //////// **************** COLORS **************** ////////

  // Project Type Color Returning
  static Color getProjectTypeColor(ProjectType value) {
    switch (value) {
      case ProjectType.mobile:
        return AppColors.blueShade2;
      case ProjectType.maintain:
        return AppColors.yellowShade2;
      case ProjectType.website:
        return AppColors.greenShade2;
      case ProjectType.softwareTesting:
        return AppColors.redShade2;
      case ProjectType.systemAnalysis:
        return AppColors.rockShade2;
    }
  }

  static Color getProjectTypeBackgroundColor(ProjectType value) {
    switch (value) {
      case ProjectType.mobile:
        return AppColors.blueShade1;
      case ProjectType.maintain:
        return AppColors.yellowShade1;
      case ProjectType.website:
        return AppColors.greenShade1;
      case ProjectType.softwareTesting:
        return AppColors.redShade1;
      case ProjectType.systemAnalysis:
        return AppColors.rockshade1;
    }
  }

  static String getProjectTypeText(ProjectType value) {
    switch (value) {
      case ProjectType.mobile:
        return TextStrings.mobileApp;
      case ProjectType.maintain:
        return TextStrings.maintain;
      case ProjectType.website:
        return TextStrings.website;
      case ProjectType.softwareTesting:
        return TextStrings.softwareTesting;
      case ProjectType.systemAnalysis:
        return TextStrings.systemAnalysis;
    }
  }

  // Project Status Color Returning
  static Color getTaskStatusColor(TaskStatus value) {
    switch (value) {
      case TaskStatus.pended:
        return AppColors.yellowShade2;
      case TaskStatus.toDo:
        return AppColors.yellowShade2;
      case TaskStatus.inProgress:
        return AppColors.blueShade2;
      case TaskStatus.inReview:
        return AppColors.redShade2;
      case TaskStatus.completed:
        return AppColors.greenShade2;
      case TaskStatus.canceled:
        return AppColors.redShade2;
    }
  }

  static Color getTaskStatusBackgroundColor(TaskStatus value) {
    switch (value) {
      case TaskStatus.pended:
        return AppColors.yellowShade1;
      case TaskStatus.toDo:
        return AppColors.yellowShade1;
      case TaskStatus.inProgress:
        return AppColors.blueShade1;
      case TaskStatus.inReview:
        return AppColors.redShade1;
      case TaskStatus.completed:
        return AppColors.greenShade1;
      case TaskStatus.canceled:
        return AppColors.redShade1;
    }
  }
  // Priority Color Returning

  static Color getPriorityColor(TaskPriority value) {
    switch (value) {
      case TaskPriority.low:
        return AppColors.yellowShade2;
      case TaskPriority.medium:
        return AppColors.blueShade2;
      case TaskPriority.high:
        return AppColors.redShade2;
    }
  }

  static Color getPriorityBackgroundColor(TaskPriority value) {
    switch (value) {
      case TaskPriority.low:
        return AppColors.yellowShade1;
      case TaskPriority.medium:
        return AppColors.blueShade1;
      case TaskPriority.high:
        return AppColors.redShade1;
    }
  }

  // Visibilty
  static Color getVisibiltyColor(ProjectVisibility value) {
    switch (value) {
      case ProjectVisibility.public:
        return AppColors.blueShade2;
      case ProjectVisibility.private:
        return AppColors.redShade2;
    }
  }

  static Color getVisibiltyBackGroundColor(ProjectVisibility value) {
    switch (value) {
      case ProjectVisibility.public:
        return AppColors.blueShade1;
      case ProjectVisibility.private:
        return AppColors.redShade1;
    }
  }

  // Field Status Color Returning

  static Color geFieldStatusColor(FieldStatus value) {
    switch (value) {
      case FieldStatus.active:
        return AppColors.greenShade2;
      case FieldStatus.unActive:
        return AppColors.rockShade2;
      case FieldStatus.approved:
        return AppColors.blueShade2;
      case FieldStatus.unApproved:
        return AppColors.redShade2;
      case FieldStatus.seen:
        return AppColors.blueShade2;
      case FieldStatus.nonSeen:
        return AppColors.yellowShade2;
      case FieldStatus.needed:
        return AppColors.greenShade2;
      case FieldStatus.nonNeeded:
        return AppColors.yellowShade2;
    }
  }

  static Color getFieldStatusBackgroundColor(FieldStatus value) {
    switch (value) {
      case FieldStatus.active:
        return AppColors.greenShade1;
      case FieldStatus.unActive:
        return AppColors.rockshade1;
      case FieldStatus.approved:
        return AppColors.blueShade1;
      case FieldStatus.unApproved:
        return AppColors.redShade1;
      case FieldStatus.seen:
        return AppColors.blueShade1;
      case FieldStatus.nonSeen:
        return AppColors.yellowShade1;
      case FieldStatus.needed:
        return AppColors.greenShade1;
      case FieldStatus.nonNeeded:
        return AppColors.yellowShade1;
    }
  }

  static String getFieldText(FieldStatus value) {
    switch (value) {
      case FieldStatus.active:
        return TextStrings.active;
      case FieldStatus.unActive:
        return TextStrings.notActive;
      case FieldStatus.approved:
        return TextStrings.approved;
      case FieldStatus.unApproved:
        return TextStrings.unApproved;
      case FieldStatus.seen:
        return TextStrings.seen;
      case FieldStatus.nonSeen:
        return TextStrings.unReaded;
      case FieldStatus.needed:
        return TextStrings.needEdit;
      case FieldStatus.nonNeeded:
        return TextStrings.noNeed;
    }
  }

  // Cooperation Type Color Returning
  static Color getCooperationTypeColor(CooperationType value) {
    switch (value) {
      case CooperationType.analysis:
        return AppColors.blueShade2;
      case CooperationType.development:
        return AppColors.greenShade2;
      case CooperationType.managment:
        return Colors.orange;
      case CooperationType.test:
        return Colors.purple;
    }
  }

  static Color getCooperationTypeBackgroundColor(CooperationType value) {
    switch (value) {
      case CooperationType.analysis:
        return AppColors.blueShade1;
      case CooperationType.development:
        return AppColors.greenShade1;
      case CooperationType.managment:
        return Colors.orange.shade100;
      case CooperationType.test:
        return Colors.purple.shade100;
    }
  }

  static String getCooperationText(CooperationType value) {
    switch (value) {
      case CooperationType.analysis:
        return TextStrings.analysisOnly;
      case CooperationType.development:
        return TextStrings.developmentOnly;
      case CooperationType.managment:
        return TextStrings.completeProjectDevelopment;
      case CooperationType.test:
        return TextStrings.testOnly;
    }
  }

  // Text Color
  static Color getTextBackgroundColor(String text) {
    if (text.toLowerCase().contains("reje") ||
        text.toLowerCase().contains("not") ||
        text.toLowerCase().contains("un")) {
      return AppColors.redShade1;
    } else if (text.toLowerCase().contains('pend')) {
      return AppColors.yellowShade1;
    } else if (text.toLowerCase().contains('mob')) {
      return AppColors.blueShade1;
    } else if (text.toLowerCase().contains('web')) {
      return AppColors.yellowShade1;
    } else {
      return AppColors.greenShade1;
    }
  }

  static Color getTextColor(String text) {
    if (text.toLowerCase().contains("reje") ||
        text.toLowerCase().contains("not") ||
        text.toLowerCase().contains("un")) {
      return AppColors.redShade2;
    } else if (text.toLowerCase().contains('pend')) {
      return AppColors.yellowShade2;
    } else if (text.toLowerCase().contains('mob')) {
      return AppColors.blueShade2;
    } else if (text.toLowerCase().contains('web')) {
      return AppColors.yellowShade3;
    } else {
      return AppColors.greenShade2;
    }
  }
}
