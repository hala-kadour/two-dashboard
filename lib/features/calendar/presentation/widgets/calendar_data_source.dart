import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter/material.dart';
import 'package:two_dashboard/config/theme/color.dart';
import 'package:two_dashboard/core/network/enums.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/domain/entity/task_entity.dart';

class TaskCalendarDataSource extends CalendarDataSource {
  TaskCalendarDataSource(List<TaskEntity> tasks) {
    appointments = tasks.map((task) => _mapTaskToAppointment(task)).toList();
  }

  Appointment _mapTaskToAppointment(TaskEntity task) {
    return Appointment(
      startTime: task.startDate,
      endTime: task.endDate,
      subject: task.title,
      notes: task.id.toString(), // لتعرفي التاسك لاحقًا
      color: _getColorByPriority(task.taskPriority),
    );
  }

  Color _getColorByPriority(TaskPriority priority) {
    switch (priority) {
      case TaskPriority.low:
        return AppColors.yellowShade3;
      case TaskPriority.medium:
        return AppColors.blueShade3;
      case TaskPriority.high:
        return AppColors.redShade3;
    }
  }
}
