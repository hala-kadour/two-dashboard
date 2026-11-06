import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signature/signature.dart';
import 'package:two_dashboard/core/functions/bloc-state-handling/contracts_bloc_state_handling.dart';
import 'package:two_dashboard/core/widgets/buttons/elevated-buttons/save_elevated_button.dart';
import 'package:two_dashboard/core/widgets/buttons/text-buttons/clear_text_button.dart';
import 'package:two_dashboard/core/widgets/buttons/text-buttons/preview_text_button.dart';
import 'package:two_dashboard/core/widgets/texts/page_title.dart';
import 'package:two_dashboard/features/contracts/presentation/bloc/contract_bloc.dart';

import '../../../../config/constants/padding_config.dart';
import '../../../../config/routes/app_route_config.dart';
import '../../../../core/widgets/breadcrumbs/breadcumbs_item.dart';
import '../../../../core/widgets/buttons/icon-buttons/back_button.dart';

class SignatureBoardPage extends StatefulWidget {
  const SignatureBoardPage({
    super.key,
    required this.contractId,
    required this.projectId,
  });
  final String contractId;
  final String projectId;

  @override
  State<SignatureBoardPage> createState() => _SignatureBoardPageState();
}

class _SignatureBoardPageState extends State<SignatureBoardPage> {
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 3,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

  Uint8List? _signatureImage;
  String? base64Image;

  Future<void> _saveSignature() async {
    if (_controller.isNotEmpty) {
      final image = await _controller.toPngBytes();
      if (image != null) {
        setState(() {
          _signatureImage = image;
        });
        base64Image = base64Encode(image);
      }
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please Sign First")));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<ContractBloc, ContractState>(
        listener: (context, state) {
          ContractsBlocStateHandling().adminSignContract(state, context);
          ContractsBlocStateHandling().adminPermitDevelopingProject(
            state,
            context,
          );
        },
        listenWhen:
            (previous, current) =>
                (previous.adminSignContractStatus !=
                    current.adminSignContractStatus) &&
                previous.adminSignContractStatus !=
                    current.adminSignContractStatus,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Breadcrumbs(
                  paths: [
                    AppRouteConfig.adminContracts,
                    AppRouteConfig.addSign,
                  ],
                  pages: ["Admin Contracts", "Signature Board"],
                ),
                PaddingConfig.h16,
                Row(
                  children: [
                    const CustomBackButton(),
                    PaddingConfig.w8,
                    PageTitle(pageTitle: "Draw Your Signature"),
                  ],
                ),
                PaddingConfig.h24,
                // لوحة التوقيع
                Signature(
                  controller: _controller,
                  width: double.infinity,
                  height: 300,
                  backgroundColor: Colors.grey[200]!,
                ),
                PaddingConfig.h24,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ClearTextButton(onPressed: _controller.clear),
                    PaddingConfig.w16,
                    PreviewTextButton(onPressed: _saveSignature),
                  ],
                ),
                PaddingConfig.h24,
                if (_signatureImage != null)
                  Column(
                    children: [
                      const Text("Preview saved signature"),
                      PaddingConfig.h24,
                      Image.memory(_signatureImage!),
                      PaddingConfig.h24,
                      SaveElevatedButton(
                        onPressed: () {
                          context.read<ContractBloc>().add(
                            AdminSignContractEvent(
                              signature: base64Image!,
                              contractId: widget.contractId,
                            ),
                          );
                          context.read<ContractBloc>().add(
                            AdminPermitDevelopingProjectEvent(
                              projectId: int.parse(widget.projectId),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
