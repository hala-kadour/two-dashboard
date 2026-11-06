import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:two_dashboard/config/constants/sizes_config.dart';
import 'package:two_dashboard/config/routes/app_route_config.dart';
import 'package:two_dashboard/core/functions/bloc-state-handling/services_bloc_state_handling.dart';
import 'package:two_dashboard/core/widgets/buttons/elevated-buttons/create_elevated_button.dart';
import 'package:two_dashboard/core/widgets/texts/page_title.dart';
import 'package:two_dashboard/features/services/presentation/bloc/service_bloc.dart';

class ServicesPage extends StatefulWidget {
  const ServicesPage({super.key});

  @override
  State<ServicesPage> createState() => _ShowPostsPageState();
}

class _ShowPostsPageState extends State<ServicesPage> {
  @override
  void didChangeDependencies() {
    context.read<ServiceBloc>().add(ShowServicesEvent());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(SizesConfig.lg),
        child: BlocListener<ServiceBloc, ServiceState>(
          listener: (context, state) {
            ServicesBlocStateHandling().deleteService(state, context);
          },
          listenWhen:
              (previous, current) =>
                  (previous.deleteServiceStatus != current.deleteServiceStatus),
          child: Column(
            children: [
              const PageTitle(pageTitle: "Services"),
              const SizedBox(height: SizesConfig.spaceBtwSections),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CreateElevatedButton(
                    addingType: "Service",
                    onPressed: () {
                      context.pushNamed(AppRouteConfig.createService);
                    },
                  ),
                ],
              ),
              const SizedBox(height: SizesConfig.spaceBtwSections),
              Flexible(
                child: BlocBuilder<ServiceBloc, ServiceState>(
                  builder: (context, state) {
                    return ServicesBlocStateHandling().getServicesTable(state);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
