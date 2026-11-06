import 'package:flutter/material.dart';
import 'package:two_dashboard/config/constants/sizes_config.dart';
import 'package:two_dashboard/features/services/domain/entities/service_entity.dart';
import 'package:two_dashboard/features/services/presentation/widgets/update_service_form.dart';

class UpdateServiceMobile extends StatelessWidget {
  const UpdateServiceMobile({super.key, required this.serviceEntity});
  final ServiceEntity serviceEntity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(SizesConfig.defaultSpace),
          child: Column(
            children: [UpdateServiceForm(serviceEntity: serviceEntity)],
          ),
        ),
      ),
    );
  }
}
