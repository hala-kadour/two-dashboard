import 'package:flutter/material.dart';
import 'package:two_dashboard/features/services/domain/entities/service_entity.dart';
import 'package:two_dashboard/features/services/presentation/widgets/update_service_form.dart';

class UpdateServiceDesktopTablet extends StatelessWidget {
  const UpdateServiceDesktopTablet({super.key, required this.serviceEntity});
  final ServiceEntity serviceEntity;

  @override
  Widget build(BuildContext context) {
    return UpdateServiceForm(serviceEntity: serviceEntity);
  }
}
