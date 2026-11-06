import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_dashboard/config/constants/padding_config.dart';
import 'package:two_dashboard/config/constants/sizes_config.dart';
import 'package:two_dashboard/config/routes/app_route_config.dart';
import 'package:two_dashboard/config/strings/text_strings.dart';
import 'package:two_dashboard/config/theme/color.dart';
import 'package:two_dashboard/core/functions/bloc-state-handling/posts_bloc_state_handling.dart';
import 'package:two_dashboard/core/widgets/breadcrumbs/breadcumbs_item.dart';
import 'package:two_dashboard/core/widgets/buttons/icon-buttons/back_button.dart';
import 'package:two_dashboard/core/widgets/buttons/elevated-buttons/desmiss_elevated_buttom.dart';
import 'package:two_dashboard/core/widgets/buttons/elevated-buttons/save_elevated_button.dart';
import 'package:two_dashboard/core/widgets/dialog/global/forget_some_thing_dialog.dart';
import 'package:two_dashboard/core/widgets/divider/custom_page_divider.dart';
import 'package:two_dashboard/core/widgets/images/fetch_image_box.dart';
import 'package:two_dashboard/core/widgets/layouts/templates/page_template.dart';
import 'package:two_dashboard/core/widgets/texts/page_title.dart';
import 'package:two_dashboard/features/auth/presentation/widgets/custom_text_form_field.dart';
import 'package:two_dashboard/features/posts/presentation/bloc/post_bloc.dart';

class CreatePostForm extends StatefulWidget {
  const CreatePostForm({super.key});

  @override
  State<CreatePostForm> createState() => _CreatePostFormState();
}

class _CreatePostFormState extends State<CreatePostForm> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _postTitleController;
  String? imageBytes;
  void updateImageBytes(String? bytes) {
    setState(() {
      imageBytes = bytes;
    });
  }

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _postTitleController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PostBloc, PostState>(
      listener: (context, state) {
        PostsBlocStateHandling().createPost(state, context);
      },
      listenWhen:
          (previous, current) =>
              previous.createPostStatus != current.createPostStatus,
      child: PageTemplate(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Breadcrumbs(
                paths: [AppRouteConfig.post, AppRouteConfig.createPost],
                pages: ["Posts", "Create Post"],
              ),
              PaddingConfig.h16,
              Row(
                children: [
                  const CustomBackButton(),
                  PaddingConfig.w8,
                  PageTitle(pageTitle: "Create Post"),
                ],
              ),
              CustomPageDivider(),
              PaddingConfig.h24,
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(SizesConfig.md),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(
                    SizesConfig.borderRadiusMd,
                  ),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextFormField(
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: AppColors.gray,
                            width: .7,
                          ),
                          borderRadius: BorderRadius.circular(
                            SizesConfig.cardRadiusMd,
                          ),
                        ),
                        labelText: 'Post Title',
                        controller: _postTitleController,
                        validator: (p0) {
                          if (p0 != null) {
                            return null;
                          } else {
                            return TextStrings.fieldValidation;
                          }
                        },
                      ),
                      PaddingConfig.h16,
                      FetchImageBox(
                        imageB64: imageBytes,
                        onUpdate: updateImageBytes,
                      ),
                      PaddingConfig.h16,
                    ],
                  ),
                ),
              ),
              PaddingConfig.h16,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const DesmissElevatedButtom(),
                  PaddingConfig.w16,
                  SaveElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (imageBytes == null) {
                          forgetSomeThingDialog(context, "image");
                        } else {
                          context.read<PostBloc>().add(
                            CreatePostEvent(
                              image: imageBytes!,
                              body: _postTitleController.text,
                            ),
                          );
                        }
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
