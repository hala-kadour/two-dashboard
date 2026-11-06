import 'package:flutter/material.dart';
import 'package:two_dashboard/config/constants/sizes_config.dart';
import 'package:two_dashboard/features/services/presentation/widgets/create_service_form.dart';

class CreateServiceMobile extends StatelessWidget {
  const CreateServiceMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(SizesConfig.defaultSpace),
          child: Column(children: [CreateServiceForm()]),
        ),
      ),
    );
  }
}
