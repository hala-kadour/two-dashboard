import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:two_dashboard/config/constants/padding_config.dart';
import 'package:two_dashboard/config/strings/text_strings.dart';
import 'package:two_dashboard/config/theme/color.dart';
import 'package:two_dashboard/config/theme/text_style.dart';
import 'package:two_dashboard/core/functions/bloc-state-handling/task_bloc_state_handling.dart';
import 'package:two_dashboard/core/functions/device_utility.dart';
import 'package:two_dashboard/core/helper/helper_functions.dart';
import 'package:two_dashboard/core/network/enums.dart';
import 'package:two_dashboard/core/widgets/buttons/elevated-buttons/save_elevated_button.dart';
import 'package:two_dashboard/core/widgets/buttons/text-buttons/cancel_text_button.dart';
import 'package:two_dashboard/core/widgets/container/custom_rounder_container.dart';
import 'package:two_dashboard/core/widgets/dropdown-list/custom_dropdown_list_for_member_model.dart';
import 'package:two_dashboard/core/widgets/images/fetch_network_image.dart';
import 'package:two_dashboard/features/auth/presentation/widgets/custom_text_form_field.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/data/models/project/team.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/domain/entity/project_status_model.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/presentation/widgets/date_field.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/domain/entity/task_entity.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/presentation/bloc/sprint_and_task_bloc.dart';

class UpdateTaskForm extends StatefulWidget {
  const UpdateTaskForm({super.key, required this.taskEntity});
  final TaskEntity taskEntity;

  @override
  State<UpdateTaskForm> createState() => _UpdateTaskFormState();
}

class _UpdateTaskFormState extends State<UpdateTaskForm> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  Member? user;
  String? priority;
  TaskStatus? taskStatus;
  int? statusId;
  double? completion;

  DateTime? _startDate;
  DateTime? _endDate;

  List<ProjectStatus> _statusList = [];
  List<Member> _membersList = [];

  Future<void> _pickDateTime({required bool isStart}) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate:
          isStart
              ? (_startDate ?? DateTime.now())
              : (_endDate ?? DateTime.now()),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate == null) return;

    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(
        isStart ? (_startDate ?? DateTime.now()) : (_endDate ?? DateTime.now()),
      ),
    );

    if (pickedTime == null) return;

    final DateTime combined = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );

    setState(() {
      if (isStart) {
        _startDate = combined;
      } else {
        _endDate = combined;
      }
    });
  }

  Future<void> _loadStatuses() async {
    final box = Hive.box<ProjectStatus>(CACHED_STATUS);
    final allStatuses = box.values.toList();
    final filtered =
        allStatuses
            .where((s) => s.projectId == widget.taskEntity.projectId)
            .toList()
          ..sort((a, b) => a.id.compareTo(b.id)); // ترتيب اختياري حسب id

    setState(() {
      _statusList = filtered;
    });
  }

  Future<void> _loadMembers() async {
    final allMembers = await getCachedTeamForProject(
      widget.taskEntity.projectId,
    );
    if (!mounted) return;
    setState(() {
      _membersList = allMembers?.members ?? [];
      user = _membersList.firstWhere(
        (element) => element.id == widget.taskEntity.assignedUser.id,
        //orElse: () => _membersList.isNotEmpty ? _membersList.first : null,
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _titleController = TextEditingController(text: widget.taskEntity.title);
    _descriptionController = TextEditingController(
      text: widget.taskEntity.description,
    );
    priority = HelperFunctions.getPriorityName(widget.taskEntity.taskPriority);
    taskStatus = widget.taskEntity.taskStatus;
    completion = widget.taskEntity.taskCompletion;
    _startDate = widget.taskEntity.startDate;
    _endDate = widget.taskEntity.endDate;

    _loadStatuses();
    _loadMembers();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      runSpacing: 16,
      spacing: 12,
      children: [
        CustomRounderContainer(
          width:
              DeviceUtility.isDesktopScreen(context)
                  ? MediaQuery.of(context).size.width / 2.5 - 32
                  : double.infinity,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Basic Information", style: AppTextStyle.bodySm()),
                PaddingConfig.h16,
                CustomTextFormField(
                  labelText: "Task Title",
                  controller: _titleController,
                  validator: (p0) {
                    if (p0 != null) {
                      return null;
                    } else {
                      return TextStrings.fieldValidation;
                    }
                  },
                ),
                PaddingConfig.h16,
                CustomTextFormField(
                  labelText: "Task description",
                  maxLines: 6,
                  controller: _descriptionController,
                  validator: (p0) {
                    if (p0 != null) {
                      return null;
                    } else {
                      return TextStrings.fieldValidation;
                    }
                  },
                ),
                PaddingConfig.h16,
                Text("Assigned To", style: AppTextStyle.bodySm()),
                PaddingConfig.h16,
                CustomDropdownListForMemberModel(
                  value: user,
                  items:
                      _membersList.map((user) {
                        return DropdownMenuItem(
                          value: user,
                          child: Row(
                            children: [
                              // Assigned to
                              Row(
                                children: [
                                  // image
                                  FetchNetworkImage(
                                    height: 50,
                                    width: 50,
                                    shape: BoxShape.circle,
                                    imagePath: user.image,
                                  ),
                                  PaddingConfig.w8,
                                  // Name and Email
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        user.name,
                                        style: AppTextStyle.bodyMd(
                                          color: AppColors.fontDarkGray,
                                        ),
                                      ),
                                      Text(
                                        user.role,
                                        style: AppTextStyle.bodySm(
                                          color: AppColors.fontLightGray,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                  onChanged: (selectedUser) {
                    setState(() {
                      user = selectedUser;
                    });
                  },
                ),
                PaddingConfig.h24,
                // Priority
                Text("Priority", style: AppTextStyle.bodySm()),
                PaddingConfig.h16,
                CustomRounderContainer(
                  child: Row(
                    children: [
                      _buildRadioForPriority("High", "High"),
                      PaddingConfig.w24,
                      _buildRadioForPriority("Mid", "Medium"),
                      PaddingConfig.w24,
                      _buildRadioForPriority("Low", "Low"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          width:
              DeviceUtility.isDesktopScreen(context)
                  ? MediaQuery.of(context).size.width / 2.5 - 32
                  : double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomRounderContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Status
                    Text("Status", style: AppTextStyle.bodySm()),
                    PaddingConfig.h16,
                    if (_statusList.isEmpty)
                      Text(
                        "No statuses available",
                        style: AppTextStyle.bodyXs(),
                      )
                    else
                      Wrap(
                        spacing: 16,
                        children:
                            _statusList
                                .map(_buildRadioForStatusFromHive)
                                .toList(),
                      ),
                    PaddingConfig.h16,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Completion", style: AppTextStyle.bodySm()),
                        Text(
                          "${completion?.round()}%",
                          style: AppTextStyle.bodySm(),
                        ),
                      ],
                    ),
                    // Completion
                    Slider(
                      value: completion!,
                      inactiveColor: AppColors.gray,
                      activeColor: AppColors.blueShade2,
                      min: 0,
                      max: 100,
                      onChanged: (value) {
                        setState(() {
                          completion = value;
                        });
                      },
                    ),
                    // Date Time
                    PaddingConfig.h16,
                    Row(
                      children: [
                        Expanded(
                          child: DateField(
                            label: 'Start Date & Time',
                            date: _startDate,
                            onTap: () => _pickDateTime(isStart: true),
                          ),
                        ),
                        PaddingConfig.w16,
                        Expanded(
                          child: DateField(
                            label: 'End Date & Time',
                            date: _endDate,
                            onTap: () => _pickDateTime(isStart: false),
                          ),
                        ),
                      ],
                    ),
                    PaddingConfig.h16,
                    if (_startDate != null && _endDate != null)
                      Text("Task Duration", style: AppTextStyle.bodySm()),
                    if (_startDate != null && _endDate != null)
                      PaddingConfig.h8,
                    if (_startDate != null && _endDate != null)
                      Text(
                        HelperFunctions.getDurationText(_startDate!, _endDate!),
                        style: AppTextStyle.bodyXs(
                          color: AppColors.fontLightGray,
                        ),
                      ),
                  ],
                ),
              ),
              PaddingConfig.h24,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CancelTextButton(),
                  PaddingConfig.w24,
                  BlocListener<SprintAndTaskBloc, SprintAndTaskState>(
                    listener: (context, state) {
                      TaskBlocStateHandling().updateTaskListener(
                        state,
                        context,
                        widget.taskEntity.projectId,
                      );
                    },
                    listenWhen:
                        (previous, current) =>
                            previous.updateTaskStatus !=
                            current.updateTaskStatus,
                    child: SaveElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate() &&
                            _startDate != null &&
                            _endDate != null &&
                            user != null &&
                            priority != null &&
                            statusId != null &&
                            completion != null) {
                          context.read<SprintAndTaskBloc>().add(
                            UpdateTaskEvent(
                              taskId: widget.taskEntity.id,
                              title: _titleController.text,
                              description: _descriptionController.text,
                              projectId: widget.taskEntity.projectId,
                              sprintId: widget.taskEntity.sprintId ?? 99,
                              statusId: statusId!,
                              userId: user!.id,
                              priority: priority!,
                              completion: completion!,
                              startDate: HelperFunctions.formateDateForBack(
                                _startDate!,
                              ),
                              endDate: HelperFunctions.formateDateForBack(
                                _endDate!,
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
              PaddingConfig.h16,
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRadioForPriority(String value, String label) {
    return Row(
      children: [
        Radio<String>(
          value: value,
          groupValue: priority,
          activeColor: AppColors.blueShade2,
          onChanged: (String? newValue) {
            setState(() {
              priority = newValue;
            });
          },
        ),
        Text(label, style: AppTextStyle.bodySm()),
      ],
    );
  }

  Widget _buildRadioForStatusFromHive(ProjectStatus status) {
    return Row(
      children: [
        Radio<int>(
          value: status.id,
          groupValue: statusId,
          activeColor: AppColors.blueShade2,
          onChanged: (int? newValue) {
            setState(() {
              statusId = newValue;
            });
          },
        ),
        Text(status.name, style: AppTextStyle.bodySm()),
      ],
    );
  }
}
