// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_role_profile_bloc.dart';

// ignore: must_be_immutable
class AuthRoleProfileState {
  String message;
  //Auth States //
  CasualStatus authModelStatus;
  UserModel? authModel;
  CasualStatus logoutStatusStatus;
  //Role States //
  List<RoleModel> roleWithoutClientList;
  CasualStatus roleWithoutClientListStatus;
  List<RoleModel> roleList;
  CasualStatus roleListStatus;
  List<RoleModel> allRolesList;
  CasualStatus allRolesListStatus;
  //Profile States //
  CasualStatus updateEmployeeProfileStatus;
  CasualStatus userHeaderStatus;
  EmployeeEntity? userHeader;
  CasualStatus userProfileStatus;
  EmployeeEntity? userProfile;
  CasualStatus toggleApproveStatus;
  List<EmployeeEntity> userList;
  CasualStatus userListStatus;
  List<ClientEntity> clientList;
  CasualStatus clientListStatus;
  CasualStatus imageBytesStatus;
  Uint8List? imageBytes;
  // Notification States //
  CasualStatus unReadNotificationListStatus;
  List<NotificationModel> unReadNotificationList;
  CasualStatus markNotificationAsReadStatus;

  AuthRoleProfileState({
    this.message = "",
    this.authModelStatus = CasualStatus.initial,
    this.authModel,
    this.logoutStatusStatus = CasualStatus.initial,
    this.roleWithoutClientList = const [],
    this.roleWithoutClientListStatus = CasualStatus.initial,
    this.roleList = const [],
    this.roleListStatus = CasualStatus.initial,
    this.allRolesList = const [],
    this.allRolesListStatus = CasualStatus.initial,
    this.updateEmployeeProfileStatus = CasualStatus.initial,
    this.userHeaderStatus = CasualStatus.initial,
    this.userHeader,
    this.userProfileStatus = CasualStatus.initial,
    this.userProfile,
    this.toggleApproveStatus = CasualStatus.initial,
    this.userList = const [],
    this.userListStatus = CasualStatus.initial,
    this.clientList = const [],
    this.clientListStatus = CasualStatus.initial,
    this.imageBytesStatus = CasualStatus.initial,
    this.imageBytes,
    this.unReadNotificationListStatus = CasualStatus.initial,
    this.unReadNotificationList = const [],
    this.markNotificationAsReadStatus = CasualStatus.initial,
  });

  AuthRoleProfileState copyWith({
    String? message,
    CasualStatus? authModelStatus,
    UserModel? authModel,
    CasualStatus? logoutStatusStatus,
    List<RoleModel>? roleWithoutClientList,
    CasualStatus? roleWithoutClientListStatus,
    List<RoleModel>? roleList,
    CasualStatus? roleListStatus,
    List<RoleModel>? allRolesList,
    CasualStatus? allRolesListStatus,
    CasualStatus? updateEmployeeProfileStatus,
    CasualStatus? userHeaderStatus,
    EmployeeEntity? userHeader,
    CasualStatus? userProfileStatus,
    EmployeeEntity? userProfile,
    CasualStatus? toggleApproveStatus,
    List<EmployeeEntity>? userList,
    CasualStatus? userListStatus,
    List<ClientEntity>? clientList,
    CasualStatus? clientListStatus,
    CasualStatus? imageBytesStatus,
    Uint8List? imageBytes,
    CasualStatus? unReadNotificationListStatus,
    List<NotificationModel>? unReadNotificationList,
    CasualStatus? markNotificationAsReadStatus,
  }) {
    return AuthRoleProfileState(
      message: message ?? this.message,
      authModelStatus: authModelStatus ?? this.authModelStatus,
      authModel: authModel ?? this.authModel,
      logoutStatusStatus: logoutStatusStatus ?? this.logoutStatusStatus,
      roleWithoutClientList:
          roleWithoutClientList ?? this.roleWithoutClientList,
      roleWithoutClientListStatus:
          roleWithoutClientListStatus ?? this.roleWithoutClientListStatus,
      roleList: roleList ?? this.roleList,
      roleListStatus: roleListStatus ?? this.roleListStatus,
      allRolesList: allRolesList ?? this.allRolesList,
      allRolesListStatus: allRolesListStatus ?? this.allRolesListStatus,
      updateEmployeeProfileStatus:
          updateEmployeeProfileStatus ?? this.updateEmployeeProfileStatus,
      userHeaderStatus: userHeaderStatus ?? this.userHeaderStatus,
      userHeader: userHeader ?? this.userHeader,
      userProfileStatus: userProfileStatus ?? this.userProfileStatus,
      userProfile: userProfile ?? this.userProfile,
      toggleApproveStatus: toggleApproveStatus ?? this.toggleApproveStatus,
      userList: userList ?? this.userList,
      userListStatus: userListStatus ?? this.userListStatus,
      clientList: clientList ?? this.clientList,
      clientListStatus: clientListStatus ?? this.clientListStatus,
      imageBytesStatus: imageBytesStatus ?? this.imageBytesStatus,
      imageBytes: imageBytes ?? this.imageBytes,
      unReadNotificationListStatus:
          unReadNotificationListStatus ?? this.unReadNotificationListStatus,
      unReadNotificationList:
          unReadNotificationList ?? this.unReadNotificationList,
      markNotificationAsReadStatus:
          markNotificationAsReadStatus ?? this.markNotificationAsReadStatus,
    );
  }
}
