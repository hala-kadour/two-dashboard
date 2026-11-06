import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:two_dashboard/config/constants/padding_config.dart';
import 'package:two_dashboard/config/routes/app_route_config.dart';
import 'package:two_dashboard/config/theme/color.dart';
import 'package:two_dashboard/config/theme/text_style.dart';
import 'package:two_dashboard/core/functions/bloc-state-handling/task_bloc_state_handling.dart';
import 'package:two_dashboard/core/functions/device_utility.dart';
import 'package:two_dashboard/core/helper/helper_functions.dart';
import 'package:two_dashboard/core/widgets/breadcrumbs/breadcumbs_item.dart';
import 'package:two_dashboard/core/widgets/buttons/elevated-buttons/create_elevated_button.dart';
import 'package:two_dashboard/core/widgets/buttons/elevated-buttons/update_elevated_button.dart';
import 'package:two_dashboard/core/widgets/buttons/icon-buttons/back_button.dart';
import 'package:two_dashboard/core/widgets/container/status-containers/dynamic_status_container.dart';
import 'package:two_dashboard/core/widgets/divider/custom_page_divider.dart';
import 'package:two_dashboard/core/widgets/layouts/templates/page_template.dart';
import 'package:two_dashboard/core/widgets/texts/page_title.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/domain/entity/sprint_entity.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/presentation/bloc/sprint_and_task_bloc.dart';

class SprintDetailsPage extends StatefulWidget {
  const SprintDetailsPage({super.key, required this.sprintEntity});
  final SprintEntity sprintEntity;

  @override
  State<SprintDetailsPage> createState() => _SprintDetailsPageState();
}

class _SprintDetailsPageState extends State<SprintDetailsPage> {
  ValueNotifier<int> filter = ValueNotifier(0);

  Widget _buildRadio(int value, String label) {
    return Row(
      children: [
        ValueListenableBuilder(
          valueListenable: filter,
          builder:
              (_, vv, _) => Radio<int>(
                value: value,
                groupValue: filter.value,
                activeColor: AppColors.blueShade2,
                onChanged: (int? newValue) {
                  filter.value = newValue!;
                  if (newValue == 0) {
                    // 0 ---> All Tasks
                    context.read<SprintAndTaskBloc>().add(
                      ShowSprintTasksEvent(sprintId: widget.sprintEntity.id),
                    );
                  } else {
                    // 1 ---> My Tasks
                    context.read<SprintAndTaskBloc>().add(
                      ShowMySprintTasksEvent(
                        projectId: widget.sprintEntity.projectId,
                        sprinttId: widget.sprintEntity.id,
                        proirity: "proirity",
                        status: "status",
                      ),
                    );
                  }
                },
              ),
        ),
        Text(label, style: AppTextStyle.bodySm()),
      ],
    );
  }

  @override
  void didChangeDependencies() {
    context.read<SprintAndTaskBloc>().add(
      ShowSprintTasksEvent(sprintId: widget.sprintEntity.id),
    );
    context.read<SprintAndTaskBloc>().add(
      ShowMySprintTasksEvent(
        projectId: widget.sprintEntity.projectId,
        sprinttId: widget.sprintEntity.id,
        proirity: "proirity",
        status: "status",
      ),
    );
    super.didChangeDependencies();
  }

  // final SprintEntity sprintEntity;
  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Breadcrumbs(
              paths: [
                AppRouteConfig.allProjects,
                AppRouteConfig.projectDetails,
                AppRouteConfig.sprintDetails,
              ],
              pages: ["All Project", "Project Details", "Sprint Details"],
            ),
            PaddingConfig.h16,
            Row(
              children: [
                const CustomBackButton(),
                PaddingConfig.w8,
                PageTitle(pageTitle: "Sprint Details"),
              ],
            ),
            CustomPageDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                UpdateElevatedButton(
                  updateType: "Sprint",
                  onPressed:
                      () => context.pushNamed(
                        AppRouteConfig.updateSprint,
                        extra: widget.sprintEntity,
                      ),
                ),
                PaddingConfig.w8,
                CreateElevatedButton(
                  addingType: "New Task",
                  onPressed:
                      () => context.pushNamed(
                        AppRouteConfig.createTask,
                        pathParameters: {
                          'pId': widget.sprintEntity.projectId.toString(),
                          'sId': widget.sprintEntity.id.toString(),
                        },
                      ),
                ),
              ],
            ),
            PaddingConfig.h24,
            Wrap(
              alignment: WrapAlignment.spaceBetween,
              runSpacing: 16,
              spacing: 12,
              children: [
                SizedBox(
                  width:
                      DeviceUtility.isMobileScreen(context)
                          ? double.infinity
                          : MediaQuery.of(context).size.width / 2.5 - 32,
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Iconsax.paperclip, color: AppColors.blueShade2),
                          PaddingConfig.w8,
                          Text(
                            "Sprint Lable",
                            style: AppTextStyle.bodyMd(
                              color: AppColors.blueShade2,
                            ),
                          ),
                          SizedBox(width: 75),
                          Text(
                            widget.sprintEntity.label,
                            style: AppTextStyle.bodySm(
                              color: AppColors.fontLightGray,
                            ),
                          ),
                        ],
                      ),
                      PaddingConfig.h24,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Iconsax.brush_1, color: AppColors.blueShade2),
                          PaddingConfig.w8,
                          Text(
                            "Sprint Descreption",
                            style: AppTextStyle.bodyMd(
                              color: AppColors.blueShade2,
                            ),
                          ),
                          PaddingConfig.w24,
                          Flexible(
                            child: SizedBox(
                              width: 200,
                              child: Text(
                                widget.sprintEntity.description,
                                style: AppTextStyle.bodySm(
                                  color: AppColors.fontLightGray,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      PaddingConfig.h24,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Iconsax.flag, color: AppColors.blueShade2),
                          PaddingConfig.w8,
                          Text(
                            "Sprint Goal",
                            style: AppTextStyle.bodyMd(
                              color: AppColors.blueShade2,
                            ),
                          ),
                          PaddingConfig.w80,
                          Flexible(
                            child: SizedBox(
                              width: 200,
                              child: Text(
                                widget.sprintEntity.goal,
                                style: AppTextStyle.bodySm(
                                  color: AppColors.fontLightGray,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      PaddingConfig.h24,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Iconsax.brush, color: AppColors.blueShade2),
                          PaddingConfig.w8,
                          Text(
                            "Sprint Status",
                            style: AppTextStyle.bodyMd(
                              color: AppColors.blueShade2,
                            ),
                          ),
                          SizedBox(width: 72),
                          DynamicStatusContainer(
                            status: widget.sprintEntity.sprintStatus,
                          ),
                        ],
                      ),
                      PaddingConfig.h32,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Iconsax.clock, color: AppColors.blueShade2),
                          PaddingConfig.w8,
                          Text(
                            "Start Date",
                            style: AppTextStyle.bodyMd(
                              color: AppColors.blueShade2,
                            ),
                          ),
                          PaddingConfig.w80,
                          Text(
                            HelperFunctions.formateDateForBack(
                              widget.sprintEntity.start,
                            ),
                            style: AppTextStyle.bodySm(
                              color: AppColors.fontLightGray,
                            ),
                          ),
                        ],
                      ),
                      PaddingConfig.h24,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Iconsax.clock, color: AppColors.blueShade2),
                          PaddingConfig.w8,
                          Text(
                            "End Date",
                            style: AppTextStyle.bodyMd(
                              color: AppColors.blueShade2,
                            ),
                          ),
                          PaddingConfig.w88,
                          Text(
                            HelperFunctions.formateDateForBack(
                              widget.sprintEntity.end,
                            ),
                            // "${HelperFunctions.formatDate(DateTime.now())} - ${TimeOfDay.fromDateTime(DateTime.now()).format(context)}",
                            style: AppTextStyle.bodySm(
                              color: AppColors.fontLightGray,
                            ),
                          ),
                        ],
                      ),
                      PaddingConfig.h24,
                    ],
                  ),
                ),
                PaddingConfig.w16,
                SizedBox(
                  width:
                      DeviceUtility.isMobileScreen(context)
                          ? double.infinity
                          : MediaQuery.of(context).size.width / 2.5 - 32,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Iconsax.task, color: AppColors.blueShade2),
                              PaddingConfig.w8,
                              Text(
                                "Sprint Tasks",
                                style: AppTextStyle.bodyMd(
                                  color: AppColors.blueShade2,
                                ),
                              ),
                              SizedBox(width: 44),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _buildRadio(0, "All Tasks"),
                              PaddingConfig.w16,
                              _buildRadio(1, "My Tasks"),
                            ],
                          ),
                        ],
                      ),
                      PaddingConfig.h16,
                      SizedBox(
                        height: 400,
                        child: ValueListenableBuilder(
                          valueListenable: filter,
                          builder: (_, value, _) {
                            if (value == 0) {
                              // All Tasks
                              return BlocBuilder<
                                SprintAndTaskBloc,
                                SprintAndTaskState
                              >(
                                buildWhen:
                                    (previous, current) =>
                                        previous.sprintTasksListStatus !=
                                        current.sprintTasksListStatus,
                                builder:
                                    (context, state) => TaskBlocStateHandling()
                                        .getAllTasksInsideSprint(state),
                              );
                            } else {
                              return BlocBuilder<
                                SprintAndTaskBloc,
                                SprintAndTaskState
                              >(
                                buildWhen:
                                    (previous, current) =>
                                        previous.mySprintTasksListStatus !=
                                        current.mySprintTasksList,
                                builder:
                                    (context, state) => TaskBlocStateHandling()
                                        .getMyTasksInsideSprint(state),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
