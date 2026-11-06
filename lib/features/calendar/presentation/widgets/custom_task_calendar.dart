import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:two_dashboard/features/calendar/presentation/widgets/calendar_data_source.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/domain/entity/task_entity.dart';

class TasksCalendarPage extends StatelessWidget {
  final List<TaskEntity> tasks;
  final void Function(int taskId, DateTime newStart, DateTime newEnd)?
  onTaskMoved;

  const TasksCalendarPage({super.key, required this.tasks, this.onTaskMoved});

  @override
  Widget build(BuildContext context) {
    return SfCalendar(
      view: CalendarView.month,
      firstDayOfWeek: 6, // السبت كبداية الأسبوع
      dataSource: TaskCalendarDataSource(tasks),
      monthViewSettings: const MonthViewSettings(
        appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
        showAgenda: true,
      ),
      allowDragAndDrop: true,
      onDragEnd: (details) {
        // final appointment = details.appointment;
        // final newStart = details.droppingTime;
        // if (appointment != null && newStart != null) {
        //   final taskId = int.tryParse(appointment.notes ?? '');
        //   if (taskId != null && onTaskMoved != null) {
        //     final duration = appointment.endTime.difference(
        //       appointment.startTime,
        //     );
        //     final newEnd = newStart.add(duration);
        //     onTaskMoved!(taskId, newStart, newEnd);
        //   }
        // }
      },
    );
  }
}
