import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:two_dashboard/config/constants/sizes_config.dart';
import 'package:two_dashboard/config/strings/text_strings.dart';
import 'package:two_dashboard/core/error/validation.dart';
import 'package:two_dashboard/core/functions/bloc-state-handling/auth_bloc_state_handling.dart';
import 'package:two_dashboard/core/functions/tuggle_password.dart';
import 'package:two_dashboard/features/auth/presentation/bloc/auth_role_profile_bloc.dart';
import 'package:two_dashboard/features/auth/presentation/widgets/login/dont_have_count_row.dart';
import 'package:two_dashboard/features/auth/presentation/widgets/custom_text_form_field.dart';
import 'package:two_dashboard/core/widgets/buttons/hovered-buttons/custom_cartoon_button.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  bool _isSecurePassword = false;
  bool _rememberMe = true;
  ValueNotifier<bool> isHover = ValueNotifier(false);
  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: SizesConfig.spaceBtwSections,
        ),
        child: Column(
          children: [
            // Email
            CustomTextFormField(
              prefixIconWidget: const Icon(Iconsax.direct_right),
              labelText: TextStrings.email,
              controller: _emailController,
              validator: (email) {
                if (email != null && email.isValidEmail()) {
                  return null;
                } else {
                  return TextStrings.emailValidation;
                }
              },
            ),
            const SizedBox(height: SizesConfig.spaceBtwInputFields),
            // Password
            CustomTextFormField(
              prefixIconWidget: const Icon(Iconsax.password_check),
              postfixIconPath: togglePassword(_isSecurePassword, () {
                setState(() {
                  _isSecurePassword = !_isSecurePassword;
                });
              }),
              obscureText: !_isSecurePassword,
              labelText: TextStrings.password,
              hintText: TextStrings.passwordHint,
              controller: _passwordController,
              validator: (password) {
                if (password != null) {
                  return null;
                } else {
                  return TextStrings.passwordValidation;
                }
              },
            ),
            const SizedBox(height: SizesConfig.spaceBtwInputFields / 2),
            // Remember Me & Forget Password
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Remember Me
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Checkbox(
                      value: _rememberMe,
                      onChanged: (value) {
                        setState(() {
                          _rememberMe = !_rememberMe;
                        });
                      },
                    ),
                    const Text(TextStrings.rememberMe),
                  ],
                ),

                // Forget Password
                TextButton(
                  onPressed: () {},
                  child: const Text(TextStrings.forgetPassword),
                ),
              ],
            ),
            const SizedBox(height: SizesConfig.spaceBtwItems),
            BlocListener<AuthRoleProfileBloc, AuthRoleProfileState>(
              listener: (context, state) async {
                await AuthBlocStateHandling().login(state, context);
              },
              listenWhen:
                  (previous, current) =>
                      previous.authModelStatus != current.authModelStatus,
              child: SizedBox(
                width: double.infinity,
                child: CustomCartoonButton(
                  title: TextStrings.signIn,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<AuthRoleProfileBloc>().add(
                        LoginUserEvent(
                          email: _emailController.text,
                          password: _passwordController.text,
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: SizesConfig.spaceBtwItems),
            // Move To Sign Up Page
            const DontHaveCountRow(),
            const SizedBox(height: SizesConfig.spaceBtwItems),
            //const GoogleGitRow(),
          ],
        ),
      ),
    );
  }
}
