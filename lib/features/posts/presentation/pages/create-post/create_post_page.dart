import 'package:flutter/material.dart';
import 'package:two_dashboard/core/widgets/responsive/responsive_design.dart';
import 'package:two_dashboard/features/posts/presentation/pages/create-post/responsive-pages/create_post_desktop_tablet.dart';
import 'package:two_dashboard/features/posts/presentation/pages/create-post/responsive-pages/create_post_mobile.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({super.key});

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  @override
  Widget build(BuildContext context) {
    return CustomResponsiveDesign(
      desktop: const CreatePostDesktopTablet(),
      tablet: const CreatePostDesktopTablet(),
      mobile: const CreatePostMobile(),
    );
  }
}
