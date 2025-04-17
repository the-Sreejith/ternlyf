import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/app_assets.dart';
import '../../../routes/routes.dart';
import '../../../shared/widgets/label.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/custom_textfield.dart';

import '../../../constants/app_sizes.dart';
import '../../../constants/app_colors.dart';

import '../../../theme/app_fonts.dart';

import '../controller/login_controller.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginState = ref.watch(loginController);

    final phoneController = TextEditingController(text: '');

    ref.listen(loginController, (previous, authState) {
      authState.whenOrNull(
        data: (_) {
          // Navigate to OTP screen only when we get success after requesting OTP
          if (previous?.isLoading == true) {
            context.pushNamed(Routes.OTPVerificationScreenRoute);
          }
        },
        error: (e, _) {
          final errorMessage = e.toString();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(errorMessage)),
          );
        },
      );
    });

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Label(
                title: 'Let\'s Log You In',
                subTitle: 'Please enter your phone no to continue'),
            gapH48,
            CustomTextField(
              hintText: 'Phone no (+1234567890)',
              controller: phoneController,
              keyboardType: TextInputType.phone,
            ),
            gapH48,
            CustomButton.primary(
              onPressed: () {
                FocusScope.of(context).unfocus();
                if (phoneController.text.isNotEmpty) {
                  ref
                      .read(loginController.notifier)
                      .requestPhoneOtp(phoneController.text);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter a valid phone number')),
                  );
                }
              },
              child: loginState.maybeWhen(
                loading: () => const CircularProgressIndicator(),
                orElse: () => Text(
                  'Send OTP',
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppFonts.radioCanadaBig,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            gapH20,
            const Center(
              child: Text(
                'OR',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            gapH20,
            CustomButton.secondary(
              onPressed: () =>
                  ref.read(loginController.notifier).signInWithGoogle(),
              child: loginState.maybeWhen(
                loading: () => const CircularProgressIndicator(),
                orElse: () => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(AppAssets.google),
                    gapW8,
                    Text(
                      'Login with Google',
                      style: TextStyle(
                        fontSize: 18,
                        color: AppColors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: AppFonts.radioCanadaBig,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}