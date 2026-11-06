import 'package:go_router/go_router.dart';
import 'package:two_dashboard/config/routes/app_route_config.dart';
import 'package:two_dashboard/features/about-us%20&%20why-us/presentation/pages/about_us_why_us_page.dart';
import 'package:two_dashboard/features/auth/presentation/pages/fill-profile/fill_employee_profile_page.dart';
import 'package:two_dashboard/features/auth/presentation/pages/login/login_page.dart';
import 'package:two_dashboard/features/auth/presentation/pages/sign-up/sign_up_page.dart';
import 'package:two_dashboard/features/calendar/presentation/pages/calender_page.dart';
import 'package:two_dashboard/features/contracts/presentation/pages/admin_contracts_page.dart';
import 'package:two_dashboard/features/contracts/presentation/pages/cm_update_contract_page.dart';
import 'package:two_dashboard/features/contracts/presentation/pages/main_contract_page.dart';
import 'package:two_dashboard/features/contracts/presentation/pages/pm_update_contract_page.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/data/models/project/team.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/domain/entity/project_entity.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/presentation/pages/assign_requests_page.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/presentation/pages/my_projects_page.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/presentation/pages/pended_projects_page.dart';
import 'package:two_dashboard/features/contracts/presentation/pages/signature_board_page.dart';
import 'package:two_dashboard/features/contracts/presentation/pages/cm_contracts_page.dart';
import 'package:two_dashboard/features/contracts/presentation/pages/create_draft_page.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/presentation/pages/create_team_page.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/presentation/pages/all_projects_page.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/presentation/pages/project_details_page.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/presentation/pages/select_team_page.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/presentation/pages/team_page.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/presentation/pages/update_project_page.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/presentation/pages/update_team_page.dart';
import 'package:two_dashboard/features/services/domain/entities/service_entity.dart';
import 'package:two_dashboard/features/services/presentation/pages/update-service/update_service_page.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/domain/entity/sprint_entity.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/domain/entity/task_entity.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/presentation/pages/create_sprint_page.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/presentation/pages/create_task_page.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/presentation/pages/sprint_details_page.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/presentation/pages/task_details_page.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/presentation/pages/tasks_page.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/presentation/pages/update_sprint_page.dart';
import 'package:two_dashboard/features/sprints%20&%20tasks/presentation/pages/update_task_page.dart';
import 'package:two_dashboard/root_page.dart';
import 'package:two_dashboard/features/posts/presentation/pages/create-post/create_post_page.dart';
import 'package:two_dashboard/features/posts/presentation/pages/post_replies_page.dart';
import 'package:two_dashboard/features/posts/presentation/pages/posts_page.dart';
import 'package:two_dashboard/features/profile/presentation/pages/accounts_page.dart';
import 'package:two_dashboard/features/profile/presentation/pages/profile_page.dart';
import 'package:two_dashboard/features/services/presentation/pages/create-service/create_service_page.dart';
import 'package:two_dashboard/features/services/presentation/pages/services_page.dart';

class AppRouter {
  GoRouter router = GoRouter(
    initialLocation: '/login',
    routes: [
      // AUTH PAGES
      GoRoute(
        name: AppRouteConfig.login,
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        name: AppRouteConfig.signup,
        path: '/signup',
        builder: (context, state) => const SignUpPage(),
      ),
      GoRoute(
        name: AppRouteConfig.fillEmployeeProfile,
        path: '/fill-employee-profile',
        builder: (context, state) => const FillEmployeeProfilePage(),
      ),
      // MAIN WEB APP PAGES
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => RootPage(shell: shell),
        branches: [
          // All Projects Branch
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: AppRouteConfig.allProjects,
                path: '/all-projects',
                builder: (context, state) => const AllProjectPage(),
              ),
              GoRoute(
                name: AppRouteConfig.projectDetails,
                path: '/project-details',
                builder:
                    (context, state) => ProjectDetailsPage(
                      projectEntity: state.extra! as ProjectEntity,
                    ),
              ),
              GoRoute(
                name: AppRouteConfig.pmUpdateContract,
                path: '/pm-update-contract/:pId/:cId',
                builder:
                    (context, state) => PmUpdateContractPage(
                      projectId: state.pathParameters['pId'] ?? '',
                      contractId: state.pathParameters['cId'] ?? '',
                    ),
              ),
              GoRoute(
                name: AppRouteConfig.createDraft,
                path: '/create-draft/:id',
                builder:
                    (context, state) => CreateDraftPage(
                      projectId: state.pathParameters['id'] ?? '',
                    ),
              ),
              GoRoute(
                name: AppRouteConfig.updateProject,
                path: '/update-project',
                builder:
                    (context, state) => UpdateProjectPage(
                      projectEntity: state.extra! as ProjectEntity,
                    ),
              ),
              GoRoute(
                name: AppRouteConfig.createSprint,
                path: '/create-sprint/:id',
                builder:
                    (context, state) => CreateSprintPage(
                      projectId: state.pathParameters['id'] ?? '',
                    ),
              ),
              GoRoute(
                name: AppRouteConfig.createTask,
                path: '/create-task/:pId/:sId',
                builder:
                    (context, state) => CreateTaskPage(
                      projectId: state.pathParameters['pId'] ?? '',
                      sprintId: state.pathParameters['sId'] ?? '',
                    ),
              ),
              GoRoute(
                name: AppRouteConfig.updateSprint,
                path: '/update-sprint',
                builder:
                    (context, state) => UpdateSprintPage(
                      sprintEntity: state.extra as SprintEntity,
                    ),
              ),
              GoRoute(
                name: AppRouteConfig.updateTask,
                path: '/update-task',
                builder:
                    (context, state) =>
                        UpdateTaskPage(taskEntity: state.extra as TaskEntity),
              ),
              GoRoute(
                name: AppRouteConfig.sprintDetails,
                path: '/sprint-details',
                builder:
                    (context, state) => SprintDetailsPage(
                      sprintEntity: state.extra as SprintEntity,
                    ),
              ),
              GoRoute(
                name: AppRouteConfig.taskDetails,
                path: '/task-details',
                builder:
                    (context, state) =>
                        TaskDetailsPage(taskEntity: state.extra as TaskEntity),
              ),
              GoRoute(
                name: AppRouteConfig.createTeam,
                path: '/create-team',
                builder: (context, state) => const CreateTeamPage(),
              ),
              GoRoute(
                name: AppRouteConfig.updateTeam,
                path: '/update-team',
                builder:
                    (context, state) =>
                        UpdateTeamPage(team: state.extra as Team),
              ),
            ],
          ),
          // My Project Branch
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: AppRouteConfig.myProjects,
                path: '/my-projects',
                builder: (context, state) => const MyProjectsPage(),
              ),
            ],
          ),
          // Assign Requsts Branch
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: AppRouteConfig.assignRequests,
                path: '/assign-requests',
                builder: (context, state) => const AssignRequestsPage(),
              ),
            ],
          ),
          // Project Requsts Branch
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: AppRouteConfig.projectRequests,
                path: '/project-requests',
                builder: (context, state) => const PendedProjectsPage(),
              ),
              GoRoute(
                name: AppRouteConfig.selectTeam,
                path: '/select-team/:id',
                builder:
                    (context, state) => SelectTeamPage(
                      projectId: state.pathParameters['id'] ?? '',
                    ),
              ),
            ],
          ),
          // Team Branch
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: AppRouteConfig.teams,
                path: '/teams',
                builder: (context, state) => const TeamPage(),
              ),
              GoRoute(
                name: AppRouteConfig.createNewTeam,
                path: '/create-new-team',
                builder: (context, state) => const CreateTeamPage(),
              ),
              GoRoute(
                name: AppRouteConfig.updateNewTeam,
                path: '/update-new-team',
                builder:
                    (context, state) =>
                        UpdateTeamPage(team: state.extra as Team),
              ),
            ],
          ),
          // Task Branch
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: AppRouteConfig.tasks,
                path: '/tasks',
                builder: (context, state) => const TasksPage(),
              ),
            ],
          ),
          // Calendar
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: AppRouteConfig.calendar,
                path: '/calendar',
                builder: (context, state) => const CalendarPage(),
              ),
            ],
          ),
          // Acounts Branch
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: AppRouteConfig.acounts,
                path: '/acounts',
                builder: (context, state) => const AccountsPage(),
              ),
            ],
          ),
          // Contracts Branch
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: AppRouteConfig.mainContract,
                path: '/main-contracts',
                builder: (context, state) => const MainContractPage(),
              ),
              GoRoute(
                name: AppRouteConfig.cmContracts,
                path: '/contrcat-manager-contracts',
                builder: (context, state) => const CMContractsPage(),
              ),
              GoRoute(
                name: AppRouteConfig.cmUpdateContract,
                path: '/cm-update-contract/:id',
                builder:
                    (context, state) => CmUpdateContractPage(
                      contractId: state.pathParameters['id'] ?? '',
                    ),
              ),
              GoRoute(
                name: AppRouteConfig.adminContracts,
                path: '/admin-contracts',
                builder: (context, state) => const AdminContractsPage(),
              ),
              GoRoute(
                name: AppRouteConfig.addSign,
                path: '/add-sign/:cId/:pId',
                builder:
                    (context, state) => SignatureBoardPage(
                      contractId: state.pathParameters['cId'] ?? '',
                      projectId: state.pathParameters['pId'] ?? '',
                    ),
              ),
            ],
          ),
          // About Us Why Us Branch
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: AppRouteConfig.aboutUsWhyUs,
                path: '/about-us-why-us',
                builder: (context, state) => const AboutUsWhyUsPage(),
              ),
            ],
          ),
          // Service Branch
          StatefulShellBranch(
            routes: [
              // services page
              GoRoute(
                name: AppRouteConfig.services,
                path: '/services',
                builder: (context, state) => const ServicesPage(),
              ),
              // create service page
              GoRoute(
                name: AppRouteConfig.createService,
                path: '/services/create-service',
                builder: (context, state) => const CreateServicePage(),
              ),
              // update service page
              GoRoute(
                name: AppRouteConfig.updateService,
                path: '/services/update-service',
                builder:
                    (context, state) => UpdateServicePage(
                      serviceEntity: state.extra as ServiceEntity,
                    ),
              ),
            ],
          ),
          // Posts Branch
          StatefulShellBranch(
            routes: [
              // posts page
              GoRoute(
                name: AppRouteConfig.post,
                path: '/posts',
                builder: (context, state) => const PostsPage(),
              ),
              // create post page
              GoRoute(
                name: AppRouteConfig.createPost,
                path: '/posts/create-post',
                builder: (context, state) => const CreatePostPage(),
              ),
              // post replies page
              GoRoute(
                name: AppRouteConfig.postReplies,
                path: '/posts/post-replies/:id',
                builder:
                    (context, state) => PostRepliesPage(
                      postId: state.pathParameters['id'] ?? '',
                    ),
              ),
            ],
          ),
          // Profile Branch
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: AppRouteConfig.profile,
                path: '/profile',
                builder: (context, state) => const ProfilePage(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
