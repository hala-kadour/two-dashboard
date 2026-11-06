import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_dashboard/core/network/enums.dart';
import 'package:two_dashboard/core/widgets/animation/loading_status_animation.dart';
import 'package:two_dashboard/features/calendar/presentation/widgets/custom_task_calendar.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/presentation/bloc/sprint_and_task_bloc.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  void didChangeDependencies() {
    context.read<SprintAndTaskBloc>().add(ShowCalendarTasksEvent());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SprintAndTaskBloc, SprintAndTaskState>(
        builder: (context, state) {
          if (state.calendarTasksListStatus == CasualStatus.success) {
            return TasksCalendarPage(
              tasks: state.calendarTasksList,
              onTaskMoved: (taskId, newStart, newEnd) {
                // // ترسلي event إلى BLoC لتحديث المهمة
                // context.read<SprintAndTaskBloc>().add(
                //   UpdateTaskDateEvent(
                //     taskId: taskId,
                //     newStart: newStart,
                //     newEnd: newEnd,
                //   ),
                //);
              },
            );
          } else if (state.calendarTasksListStatus == CasualStatus.loading) {
            return const Center(child: LoadingStatusAnimation());
          } else {
            return const Center(child: Text("Tasks has not loaded"));
          }
        },
      ),
    );
  }
}
