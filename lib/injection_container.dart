import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:two_dashboard/core/network/network_connection_checker.dart';
import 'package:two_dashboard/features/about-us%20&%20why-us/data/datasources/about_us_remote_datasource.dart';
import 'package:two_dashboard/features/about-us%20&%20why-us/data/datasources/why_us_remote_datesource.dart';
import 'package:two_dashboard/features/about-us%20&%20why-us/data/repos/about_us_repo_impl.dart';
import 'package:two_dashboard/features/about-us%20&%20why-us/data/repos/why_us_repo_impl.dart';
import 'package:two_dashboard/features/about-us%20&%20why-us/domain/repos/about_us_repo.dart';
import 'package:two_dashboard/features/about-us%20&%20why-us/domain/repos/why_us_repo.dart';
import 'package:two_dashboard/features/about-us%20&%20why-us/domain/usecases/about-us-usecase/create_about_us_usecase.dart';
import 'package:two_dashboard/features/about-us%20&%20why-us/domain/usecases/about-us-usecase/show_about_us_usecase.dart';
import 'package:two_dashboard/features/about-us%20&%20why-us/domain/usecases/about-us-usecase/update_about_us_usecase.dart';
import 'package:two_dashboard/features/about-us%20&%20why-us/domain/usecases/why-us-usecase/create_why_us_usecase.dart';
import 'package:two_dashboard/features/about-us%20&%20why-us/domain/usecases/why-us-usecase/delete_why_us_usecase.dart';
import 'package:two_dashboard/features/about-us%20&%20why-us/domain/usecases/why-us-usecase/show_why_us_usecase.dart';
import 'package:two_dashboard/features/about-us%20&%20why-us/domain/usecases/why-us-usecase/update_why_us_usecase.dart';
import 'package:two_dashboard/features/about-us%20&%20why-us/presentation/bloc/about_us_why_us_bloc.dart';
import 'package:two_dashboard/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:two_dashboard/features/auth/data/repos/auth_repo_impl.dart';
import 'package:two_dashboard/features/auth/domain/repos/auth_repo.dart';
import 'package:two_dashboard/features/auth/domain/usecases/login_usecase.dart';
import 'package:two_dashboard/features/auth/domain/usecases/logout_usecase.dart';
import 'package:two_dashboard/features/auth/domain/usecases/register_usecase.dart';
import 'package:two_dashboard/features/auth/presentation/bloc/auth_role_profile_bloc.dart';
import 'package:two_dashboard/features/contact-us/data/datasources/contact_us_remote_datasource.dart';
import 'package:two_dashboard/features/contact-us/data/repos/contact_us_repo_impl.dart';
import 'package:two_dashboard/features/contact-us/domain/repos/contact_us_repo.dart';
import 'package:two_dashboard/features/contact-us/domain/usecases/create_contact_us_usecase.dart';
import 'package:two_dashboard/features/contact-us/domain/usecases/mark_contact_us_as_approved_uscase.dart';
import 'package:two_dashboard/features/contact-us/domain/usecases/mark_contact_us_as_seen_usecase.dart';
import 'package:two_dashboard/features/contact-us/domain/usecases/show_contact_us_with_seen_and_approved_usecase.dart';
import 'package:two_dashboard/features/contact-us/presentation/bloc/contact_us_bloc.dart';
import 'package:two_dashboard/features/contracts/data/datasource/contract_remote_datasource.dart';
import 'package:two_dashboard/features/contracts/data/repos/contract_repo_impl.dart';
import 'package:two_dashboard/features/contracts/domain/repos/contract_repo.dart';
import 'package:two_dashboard/features/contracts/domain/usecases/add_draft_usecase.dart';
import 'package:two_dashboard/features/contracts/domain/usecases/admin_sign_contract_usecase.dart';
import 'package:two_dashboard/features/contracts/domain/usecases/contract_manager_approve_contract_usecase.dart';
import 'package:two_dashboard/features/contracts/domain/usecases/contract_manager_update_contract_usecase.dart';
import 'package:two_dashboard/features/contracts/domain/usecases/project_manager_approve_contract_usecase.dart';
import 'package:two_dashboard/features/contracts/domain/usecases/project_manager_update_contract_usecase.dart';
import 'package:two_dashboard/features/contracts/domain/usecases/show_admin_contract_list_usecase.dart';
import 'package:two_dashboard/features/contracts/domain/usecases/show_contract_list_usecase.dart';
import 'package:two_dashboard/features/contracts/domain/usecases/show_contract_manager_contract_list_usecase.dart';
import 'package:two_dashboard/features/contracts/presentation/bloc/contract_bloc.dart';
import 'package:two_dashboard/features/notification/data/datasource/notification_remote_datasource.dart';
import 'package:two_dashboard/features/notification/data/repo/notification_repo_impl.dart';
import 'package:two_dashboard/features/notification/domain/repo/notification_repo.dart';
import 'package:two_dashboard/features/notification/domain/usecase/mark_notification_as_read_usecase.dart';
import 'package:two_dashboard/features/notification/domain/usecase/show_un_read_notification_usecase.dart';
import 'package:two_dashboard/features/posts/data/datasources/posts_local_datasource.dart';
import 'package:two_dashboard/features/posts/data/datasources/posts_remote_datasource.dart';
import 'package:two_dashboard/features/posts/data/repos/post_repo_impl.dart';
import 'package:two_dashboard/features/posts/domain/repos/post_repo.dart';
import 'package:two_dashboard/features/posts/domain/usecases/accept_reply_usecase.dart';
import 'package:two_dashboard/features/posts/presentation/bloc/post_bloc.dart';
import 'package:two_dashboard/features/profile/data/datasources/profile_locale_datasource.dart';
import 'package:two_dashboard/features/profile/data/datasources/profile_remote_datasourse.dart';
import 'package:two_dashboard/features/profile/data/repos/profile_repo_impl.dart';
import 'package:two_dashboard/features/profile/domain/repos/profile_repo.dart';
import 'package:two_dashboard/features/profile/domain/usecases/get_image_usecase.dart';
import 'package:two_dashboard/features/profile/domain/usecases/get_user_profile_usecase.dart';
import 'package:two_dashboard/features/profile/domain/usecases/show_clients_usecase.dart';
import 'package:two_dashboard/features/profile/domain/usecases/show_users_usecase.dart';
import 'package:two_dashboard/features/profile/domain/usecases/toggle_user_approved_usecase.dart';
import 'package:two_dashboard/features/profile/domain/usecases/update_employee_profile_usecase.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/data/datasource/meeting_remote_data_source.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/data/datasource/project_remote_data_source.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/data/datasource/status_remote_data_source.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/data/repos/meeting_repo_impl.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/data/repos/status_repo_impl.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/domain/repos/meeting_repo.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/domain/repos/project_repo.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/domain/repos/status_repo.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/domain/repos/team_repo.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/domain/usecases/meeting/create_meeting_usecase.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/domain/usecases/meeting/delete_meeting_usecase.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/domain/usecases/meeting/show_meeting_list_usecase.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/domain/usecases/meeting/update_meeting_usecase.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/domain/usecases/project/admin_permit_developing_project_usecase.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/domain/usecases/project/approved_project_usecase.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/domain/usecases/project/delete_project_usecase.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/domain/usecases/project/project_manager_accept_project_usecase.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/domain/usecases/project/project_manager_complete_project_usecase.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/domain/usecases/project/project_manager_reject_project_usecase.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/domain/usecases/project/project_manager_sent_edit_project_request_usecase.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/domain/usecases/project/project_manager_update_project_date_usecase.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/domain/usecases/project/reject_project_usecase.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/domain/usecases/project/show_all_projects_usecase.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/domain/usecases/project/show_pended_project_usecase.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/domain/usecases/project/show_project_accepted_assigned_list_usecase.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/domain/usecases/project/show_project_assign_request_list_usecase.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/domain/usecases/project/show_project_edit_request_usecase.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/domain/usecases/project/show_public_projects_usecase.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/domain/usecases/project/show_user_projects_usecase.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/domain/usecases/project/update_project_usecase.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/domain/usecases/status/create_status_usecase.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/domain/usecases/status/delete_status_usecase.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/domain/usecases/status/show_status_usecase.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/domain/usecases/status/update_status_order_usecase.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/domain/usecases/team/add_members_usecase.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/domain/usecases/team/add_team_usecase.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/domain/usecases/team/create_team_usecase.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/domain/usecases/team/show_teams_usecase.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/presentation/bloc/project_status_team_meeting_bloc.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/data/datasource/team__remote_data_source.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/data/repos/project_repo_impl.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/data/repos/team_repo_impl.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/domain/usecases/project/create_project_usecase.dart';
import 'package:two_dashboard/features/roles/data/datasources/role_local_datasource.dart';
import 'package:two_dashboard/features/roles/data/datasources/role_remote_datasource.dart';
import 'package:two_dashboard/features/roles/data/repos/role_repo_impl.dart';
import 'package:two_dashboard/features/roles/domain/repos/role_repo.dart';
import 'package:two_dashboard/features/roles/domain/usecases/show_all_roles_usecase.dart';
import 'package:two_dashboard/features/roles/domain/usecases/show_role_client_usecase.dart';
import 'package:two_dashboard/features/roles/domain/usecases/show_roles_without_client_usecase.dart';
import 'package:two_dashboard/features/services/data/datasources/service_remote_datasource.dart';
import 'package:two_dashboard/features/services/data/repos/service_repo_impl.dart';
import 'package:two_dashboard/features/services/domain/repos/service_repo.dart';
import 'package:two_dashboard/features/services/domain/usecases/create_service_usecase.dart';
import 'package:two_dashboard/features/services/domain/usecases/delete_service_usecase.dart';
import 'package:two_dashboard/features/services/domain/usecases/show_service_usecase.dart';
import 'package:two_dashboard/features/services/domain/usecases/update_service_usecase.dart';
import 'package:two_dashboard/features/services/presentation/bloc/service_bloc.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/data/datasource/sprints_remote_datasource.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/data/datasource/tasks_remote_datasource.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/data/repos/sprint_repo_impl.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/data/repos/task_repo_impl.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/domain/repos/sprint_repo.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/domain/repos/task_repo.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/domain/usecases/sprint-usecase/complete_sprint_usecase.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/domain/usecases/sprint-usecase/create_sprint_usecase.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/domain/usecases/sprint-usecase/delete_sprint_usecase.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/domain/usecases/sprint-usecase/show_project_sprints_usecase.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/domain/usecases/sprint-usecase/show_project_started_sprints_usecase.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/domain/usecases/sprint-usecase/show_project_un_complete_sprints_usecase.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/domain/usecases/sprint-usecase/show_sprint_details_usecase.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/domain/usecases/sprint-usecase/start_sprint_usecase.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/domain/usecases/sprint-usecase/update_sprint_usecase.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/domain/usecases/sprint-usecase/create_backlog_sprint_usecase.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/domain/usecases/task-usecase/create_task_usecase.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/domain/usecases/task-usecase/delete_task_usecase.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/domain/usecases/task-usecase/show_my_project_tasks_usecase.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/domain/usecases/task-usecase/show_my_sprint_tasks_usecase.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/domain/usecases/sprint-usecase/show_project_pending_sprint_usecase.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/domain/usecases/task-usecase/show_my_tasks_list_usecase.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/domain/usecases/task-usecase/show_project_backlog_tasks_usecase.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/domain/usecases/status/show_project_board_usecase.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/domain/usecases/task-usecase/show_project_tasks_usecase.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/domain/usecases/task-usecase/show_sprint_tasks_usecase.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/domain/usecases/task-usecase/show_task_details_usecase.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/domain/usecases/task-usecase/update_task_usecase.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/presentation/bloc/sprint_and_task_bloc.dart';

import 'features/posts/domain/usecases/create_post_usecase.dart';
import 'features/posts/domain/usecases/delete_post_usecase.dart';
import 'features/posts/domain/usecases/reply_to_post_usecase.dart';
import 'features/posts/domain/usecases/show_active_posts_usecase.dart';
import 'features/posts/domain/usecases/show_post_accepted_replies_usecase.dart';
import 'features/posts/domain/usecases/show_post_replies_usecase.dart';
import 'features/posts/domain/usecases/show_un_active_posts_usecase.dart';
import 'features/posts/domain/usecases/un_active_post_usecase.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /**----------------- AUTH FEATURE -----------------------**/
  // Bloc
  sl.registerFactory(
    () => AuthRoleProfileBloc(
      registerUsecase: sl(),
      loginUsecase: sl(),
      logoutUsecase: sl(),
      showRoleClientUsecase: sl(),
      showRolesWithoutClientUsecase: sl(),
      showAllRolesUsecase: sl(),
      updateEmployeeProfileUsecase: sl(),
      getUserProfileUsecase: sl(),
      toggleUserApprovedUsecase: sl(),
      showUsersUsecase: sl(),
      showClientsUsecase: sl(),
      getImageUsecase: sl(),
      showUnReadNotificationUsecase: sl(),
      markNotificationAsReadUsecase: sl(),
    ),
  );
  // Usecases
  sl.registerLazySingleton(() => RegisterUsecase(sl()));
  sl.registerLazySingleton(() => LoginUsecase(sl()));
  sl.registerLazySingleton(() => LogoutUsecase(sl()));
  // Repos
  sl.registerLazySingleton<AuthRepo>(
    () => AuthRepoImpl(authRemoteDataSource: sl()),
  );
  // Datasources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(),
  );

  /**----------------- ROLE FEATURE -----------------------**/
  // Usecase
  sl.registerLazySingleton(() => ShowAllRolesUsecase(sl()));
  sl.registerLazySingleton(() => ShowRoleClientUsecase(sl()));
  sl.registerLazySingleton(() => ShowRolesWithoutClientUsecase(sl()));
  // Repo
  sl.registerLazySingleton<RoleRepo>(() => RoleRepoImpl(sl(), sl(), sl()));
  // Datasource
  sl.registerLazySingleton<RoleRemoteDatasource>(
    () => RoleRemoteDatasourceImpl(),
  );
  sl.registerLazySingleton<RoleLocalDatasource>(
    () => RoleLocalDatasourceImpl(),
  );

  /**----------------- PROFILE FEATURE -----------------------**/
  // Usecase
  sl.registerLazySingleton(() => UpdateEmployeeProfileUsecase(sl()));
  sl.registerLazySingleton(() => GetUserProfileUsecase(sl()));
  sl.registerLazySingleton(() => ToggleUserApprovedUsecase(sl()));
  sl.registerLazySingleton(() => ShowUsersUsecase(sl()));
  sl.registerLazySingleton(() => ShowClientsUsecase(sl()));
  sl.registerLazySingleton(() => GetImageUsecase(sl()));
  // Repo
  sl.registerLazySingleton<ProfileRepo>(
    () => ProfileRepoImpl(sl(), sl(), sl()),
  );
  // Datasource
  sl.registerLazySingleton<ProfileRemoteDatasourse>(
    () => ProfileRemoteDatasourseImpl(),
  );
  sl.registerLazySingleton<ProfileLocaleDatasource>(
    () => ProfileLocaleDatasourceImpl(sl()),
  );

  /**----------------- NOTIFICATION FEATURE -----------------------**/
  // Usecase
  sl.registerLazySingleton(() => ShowUnReadNotificationUsecase(sl()));
  sl.registerLazySingleton(() => MarkNotificationAsReadUsecase(sl()));
  // Repo
  sl.registerLazySingleton<NotificationRepo>(() => NotificationRepoImpl(sl()));
  // Datasource
  sl.registerLazySingleton<NotificationRemoteDatasource>(
    () => NotificationRemoteDatasourceImpl(),
  );

  /**----------------- POST FEATURE -----------------------**/
  // Bloc
  sl.registerFactory(
    () => PostBloc(
      acceptReplyUsecase: sl(),
      createPostUsecase: sl(),
      deletePostUsecase: sl(),
      replyToPostUsecase: sl(),
      showActivePostsUsecase: sl(),
      showPostAcceptedRepliesUsecase: sl(),
      showPostRepliesUsecase: sl(),
      showUnActivePostsUsecase: sl(),
      unActivePostUsecase: sl(),
    ),
  );
  // Usecases
  sl.registerLazySingleton(() => AcceptReplyUsecase(sl()));
  sl.registerLazySingleton(() => CreatePostUsecase(sl()));
  sl.registerLazySingleton(() => DeletePostUsecase(sl()));
  sl.registerLazySingleton(() => ReplyToPostUsecase(sl()));
  sl.registerLazySingleton(() => ShowActivePostsUsecase(sl()));
  sl.registerLazySingleton(() => ShowPostAcceptedRepliesUsecase(sl()));
  sl.registerLazySingleton(() => ShowPostRepliesUsecase(sl()));
  sl.registerLazySingleton(() => ShowUnActivePostsUsecase(sl()));
  sl.registerLazySingleton(() => UnActivePostUsecase(sl()));
  // Repos
  sl.registerLazySingleton<PostRepo>(() => PostRepoImpl(sl(), sl(), sl()));

  // Datasources
  sl.registerLazySingleton<PostRemoteDatasource>(
    () => PostsRemoteDatasourceImpl(),
  );
  sl.registerLazySingleton<PostsLocalDatasource>(
    () => PostsLocalDatasourceImpl(sl()),
  );

  /**----------------- SERVICES FEATURE -----------------------**/
  // Bloc
  sl.registerFactory(() => ServiceBloc(sl(), sl(), sl(), sl()));
  // Usecase
  sl.registerLazySingleton(() => CreateServiceUsecase(sl()));
  sl.registerLazySingleton(() => DeleteServiceUsecase(sl()));
  sl.registerLazySingleton(() => ShowServiceUsecase(sl()));
  sl.registerLazySingleton(() => UpdateServiceUsecase(sl()));
  //Repo
  sl.registerLazySingleton<ServiceRepo>(() => ServiceRepoImpl(sl()));

  // Datasource
  sl.registerLazySingleton<ServiceRemoteDatasource>(
    () => ServiceRemoteDatasourceImpl(),
  );

  /**----------------- ABOUT-US-WHY-US FEATURE -----------------------**/
  // Bloc
  sl.registerFactory(
    () => AboutUsWhyUsBloc(sl(), sl(), sl(), sl(), sl(), sl(), sl()),
  );
  // About Us Usecase
  sl.registerLazySingleton(() => CreateAboutUsUsecase(sl()));
  sl.registerLazySingleton(() => ShowAboutUsUsecase(sl()));
  sl.registerLazySingleton(() => UpdateAboutUsUsecase(sl()));
  // Why Us Usecase
  sl.registerLazySingleton(() => CreateWhyUsUsecase(sl()));
  sl.registerLazySingleton(() => DeleteWhyUsUsecase(sl()));
  sl.registerLazySingleton(() => ShowWhyUsUsecase(sl()));
  sl.registerLazySingleton(() => UpdateWhyUsUsecase(sl()));
  // Repo
  sl.registerLazySingleton<AboutUsRepo>(() => AboutUsRepoImpl(sl()));
  sl.registerLazySingleton<WhyUsRepo>(() => WhyUsRepoImpl(sl()));
  // Datasource
  sl.registerLazySingleton<AboutUsRemoteDatasource>(
    () => AboutUsRemoteDatasourceImpl(),
  );
  sl.registerLazySingleton<WhyUsRemoteDatesource>(
    () => WhyUsRemoteDatesourceImpl(),
  );

  /**----------------- CONTACT-US FEATURE -----------------------**/
  // Bloc
  sl.registerFactory(() => ContactUsBloc(sl(), sl(), sl(), sl()));
  // Usecase
  sl.registerLazySingleton(() => CreateContactUsUsecase(sl()));
  sl.registerLazySingleton(() => MarkContactUsAsApprovedUscase(sl()));
  sl.registerLazySingleton(() => MarkContactUsAsSeenUsecase(sl()));
  sl.registerLazySingleton(() => ShowContactUsWithSeenAndApprovedUsecase(sl()));
  // Repo
  sl.registerLazySingleton<ContactUsRepo>(() => ContactUsRepoImpl(sl()));
  // Datasource
  sl.registerLazySingleton<ContactUsRemoteDatasource>(
    () => ContactUsRemoteDatasourceImpl(),
  );

  /**----------------- CONTRACTS-DRAFTS FEATURE -----------------------**/
  sl.registerFactory(
    () => ContractBloc(
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
    ),
  );
  // Usecase
  sl.registerLazySingleton(() => AddDraftUsecase(sl()));
  sl.registerLazySingleton(() => AdminSignContractUsecase(sl()));
  sl.registerLazySingleton(() => ContractManagerApproveContractUsecase(sl()));
  sl.registerLazySingleton(() => ContractManagerUpdateContractUsecase(sl()));
  sl.registerLazySingleton(() => ProjectManagerApproveContractUsecase(sl()));
  sl.registerLazySingleton(() => ProjectManagerUpdateContractUsecase(sl()));
  sl.registerLazySingleton(() => ShowAdminContractListUsecase(sl()));
  sl.registerLazySingleton(() => ShowContractListUsecase(sl()));
  sl.registerLazySingleton(() => ShowContractManagerContractListUsecase(sl()));
  sl.registerLazySingleton(() => AdminPermitDevelopingProjectUsecase(sl()));

  // Repo
  sl.registerLazySingleton<ContractRepo>(() => ContractRepoImpl(sl()));
  // Datasource
  sl.registerLazySingleton<ContractRemoteDatasource>(
    () => ContractRemoteDatasourceImpl(),
  );

  /**----------------- PROJECTS-STATUS-TEAM-MEETING FEATURE -----------------------**/
  sl.registerFactory(
    () => ProjectStatusTeamMeetingBloc(
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
    ),
  );
  // Project Usecase
  sl.registerLazySingleton(() => CreateProjectUsecase(sl()));
  sl.registerLazySingleton(() => DeleteProjectUsecase(sl()));
  sl.registerLazySingleton(() => ApproveProjectUsecase(sl()));
  sl.registerLazySingleton(() => RejectProjectUsecase(sl()));
  sl.registerLazySingleton(() => UpdateProjectUsecase(sl()));
  sl.registerLazySingleton(() => ShowProjectEditRequestUsecase(sl()));
  sl.registerLazySingleton(() => ShowAllProjectsUsecase(sl()));
  sl.registerLazySingleton(() => ShowPendedProjectUsecase(sl()));
  sl.registerLazySingleton(() => ShowPublicProjectsUsecase(sl()));
  sl.registerLazySingleton(() => ShowUserProjectsUsecase(sl()));
  // Project Manager Usecase
  sl.registerLazySingleton(() => ProjectManagerCompleteProjectUsecase(sl()));
  sl.registerLazySingleton(() => ProjectManagerUpdateProjectDateUsecase(sl()));
  sl.registerLazySingleton(() => ProjectManagerAcceptProjectUsecase(sl()));
  sl.registerLazySingleton(() => ProjectManagerRejectProjectUsecase(sl()));
  sl.registerLazySingleton(
    () => ProjectManagerSentEditProjectRequestUsecase(sl()),
  );
  sl.registerLazySingleton(() => ShowProjectAssignRequestListUsecase(sl()));
  sl.registerLazySingleton(() => ShowProjectAcceptedAssignedListUsecase(sl()));

  // Status Usecase
  sl.registerLazySingleton(() => CreateStatusUsecase(sl()));
  sl.registerLazySingleton(() => DeleteStatusUsecase(sl()));
  sl.registerLazySingleton(() => UpdateStatusOrderUsecase(sl()));
  sl.registerLazySingleton(() => ShowStatusUsecase(sl()));
  sl.registerLazySingleton(() => ShowProjectBoardUsecase(sl()));
  // Team Usecase
  sl.registerLazySingleton(() => CreateTeamUsecase(sl()));
  sl.registerLazySingleton(() => AddMembersUsecase(sl()));
  sl.registerLazySingleton(() => ShowTeamsUsecase(sl()));
  sl.registerLazySingleton(() => AddTeamUsecase(sl()));
  // Meeting Usecase
  sl.registerLazySingleton(() => CreateMeetingUsecase(sl()));
  sl.registerLazySingleton(() => UpdateMeetingUsecase(sl()));
  sl.registerLazySingleton(() => DeleteMeetingUsecase(sl()));
  sl.registerLazySingleton(() => ShowMeetingListUsecase(sl()));

  // Repo
  sl.registerLazySingleton<ProjectRepo>(() => ProjectRepoImpl(sl()));
  sl.registerLazySingleton<StatusRepo>(() => StatusRepoImpl(sl()));
  sl.registerLazySingleton<TeamRepo>(() => TeamRepoImpl(sl()));
  sl.registerLazySingleton<MeetingRepo>(() => MeetingRepoImpl(sl()));
  // Datasource
  sl.registerLazySingleton<ProjectRemoteDataSource>(
    () => ProjectRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<StatusRemoteDataSource>(
    () => StatusRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<TeamRemoteDataSource>(
    () => TeamRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<MeetingRemoteDataSource>(
    () => MeetingRemoteDataSourceImpl(),
  );

  /**----------------- SPRINT-TASK FEATURE -----------------------**/
  sl.registerFactory(
    () => SprintAndTaskBloc(
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
    ),
  );
  // Sprint Usecase
  sl.registerLazySingleton(() => CreateSprintUsecase(sl()));
  sl.registerLazySingleton(() => UpdateSprintUsecase(sl()));
  sl.registerLazySingleton(() => DeleteSprintUsecase(sl()));
  sl.registerLazySingleton(() => StartSprintUsecase(sl()));
  sl.registerLazySingleton(() => CompleteSprintUsecase(sl()));
  sl.registerLazySingleton(() => ShowProjectUnCompleteSprintsUsecase(sl()));
  sl.registerLazySingleton(() => ShowProjectStartedSprintsUsecase(sl()));
  sl.registerLazySingleton(() => ShowProjectPendedSprintsUsecase(sl()));
  sl.registerLazySingleton(() => ShowProjectSprintsUsecase(sl()));
  sl.registerLazySingleton(() => ShowSprintDetailsUsecase(sl()));
  sl.registerLazySingleton(() => CreateBacklogSprintUsecase(sl()));
  // Task Usecase
  sl.registerLazySingleton(() => CreateTaskUsecase(sl()));
  sl.registerLazySingleton(() => UpdateTaskUsecase(sl()));
  sl.registerLazySingleton(() => DeleteTaskUsecase(sl()));
  sl.registerLazySingleton(() => ShowTaskDetailsUsecase(sl()));
  sl.registerLazySingleton(() => ShowMyTasksListUsecase(sl()));
  sl.registerLazySingleton(() => ShowProjectTasksUsecase(sl()));
  sl.registerLazySingleton(() => ShowSprintTasksUsecase(sl()));
  sl.registerLazySingleton(() => ShowMyProjectTasksUsecase(sl()));
  sl.registerLazySingleton(() => ShowMySprintTasksUsecase(sl()));
  sl.registerLazySingleton(() => ShowProjectBacklogTasksUsecase(sl()));

  // Repo
  sl.registerLazySingleton<SprintRepo>(() => SprintRepoImpl(sl()));
  sl.registerLazySingleton<TaskRepo>(() => TaskRepoImpl(sl()));
  // Datasource
  sl.registerLazySingleton<SprintsRemoteDatasource>(
    () => SprintsRemoteDatasourceImpl(),
  );
  sl.registerLazySingleton<TaskRemoteDatasource>(
    () => TaskRemoteDatasourceImpl(),
  );

  ///////////////////////////////////////////////////////////////////////////////////////

  /* CORE */
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  /* External */

  final sharedPreferences = await SharedPreferences.getInstance();
  final internetConnectionChecker = InternetConnectionChecker.createInstance();
  final networkInfo = NetworkInfoImpl(internetConnectionChecker);
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => internetConnectionChecker);
  sl.registerLazySingleton(() => networkInfo);
}
