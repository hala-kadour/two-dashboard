import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:two_dashboard/core/functions/bloc-state-handling/task_bloc_state_handling.dart';
import 'package:two_dashboard/core/functions/device_utility.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/presentation/bloc/sprint_and_task_bloc.dart';

import '../../../../config/constants/padding_config.dart';
import '../../../../config/constants/sizes_config.dart';
import '../../../../config/theme/color.dart';
import '../../../../core/widgets/buttons/icon-buttons/choose_date_button.dart';
import '../../../../core/widgets/texts/page_title.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  bool isKanban = true;
  @override
  void didChangeDependencies() {
    context.read<SprintAndTaskBloc>().add(ShowMyTasksEvent());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          top: SizesConfig.lg,
          left: SizesConfig.lg,
          right: SizesConfig.lg,
        ),
        child: Column(
          children: [
            PageTitle(pageTitle: "My Tasks ❤️‍🔥🦾"),
            PaddingConfig.h24,
            _buildFilters(),
            PaddingConfig.h32,
            if (isKanban)
              BlocListener<SprintAndTaskBloc, SprintAndTaskState>(
                listenWhen:
                    (previous, current) =>
                        previous.deleteTaskStatus != current.deleteTaskStatus,
                listener: (context, state) {
                  TaskBlocStateHandling().deleteTaskListener(state, context, 1);
                },
                child: Flexible(
                  child: BlocBuilder<SprintAndTaskBloc, SprintAndTaskState>(
                    buildWhen:
                        (previous, current) =>
                            (previous.myTasksListStatus !=
                                current.myTasksListStatus),
                    builder: (context, state) {
                      return TaskBlocStateHandling().getMyTasksListTable(state);
                    },
                  ),
                ),
              ),
            if (!isKanban)
              Expanded(
                child: BlocBuilder<SprintAndTaskBloc, SprintAndTaskState>(
                  buildWhen:
                      (previous, current) =>
                          (previous.myTasksListStatus !=
                              current.myTasksListStatus),
                  builder: (context, state) {
                    return TaskBlocStateHandling().getMyTasksListKanban(state);
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleBar() {
    return Container(
      height: 42,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.rockShade2, width: 0.2),
        borderRadius: BorderRadius.circular(SizesConfig.borderRadiusXl),
      ),
      padding: EdgeInsets.all(3.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Iconsax.kanban),
            iconSize: SizesConfig.iconsSm,
            padding: EdgeInsets.all(0.0),
            style: IconButton.styleFrom(
              shape: CircleBorder(),
              backgroundColor:
                  isKanban ? AppColors.greenShade2 : Colors.transparent,
            ),
            onPressed: () => setState(() => isKanban = true),
            color: isKanban ? AppColors.white : Colors.grey,
          ),
          PaddingConfig.w8,
          IconButton(
            icon: Icon(Iconsax.element_4),
            iconSize: SizesConfig.iconsSm,
            padding: EdgeInsets.all(0.0),
            style: IconButton.styleFrom(
              shape: CircleBorder(),
              backgroundColor:
                  !isKanban ? AppColors.greenShade2 : Colors.transparent,
            ),
            onPressed: () => setState(() => isKanban = false),
            color: !isKanban ? AppColors.white : Colors.grey,
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    final isMobile = DeviceUtility.isMobileScreen(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(
            child: Wrap(
              spacing: isMobile ? 8 : 16,
              runSpacing: isMobile ? 8 : 12,
              alignment: WrapAlignment.end,
              children: [
                _wrapButton(child: ChooseDateButton()),
                _wrapButton(child: _buildToggleBar()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _wrapButton({required Widget child}) {
    return IntrinsicWidth(
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: 0, maxWidth: 220),
        child: child,
      ),
    );
  }
}
