import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';

import '../../../routes/routes.dart';
import '../../../constants/app_sizes.dart';
import '../../../constants/app_colors.dart';
import '../../../shared/widgets/label.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../theme/app_fonts.dart';

import '../controller/login_controller.dart';

class OtpVerificationScreen extends ConsumerWidget {
  const OtpVerificationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginState = ref.watch(loginController);
    final phoneNumber = ref.watch(phoneNumberProvider);
    final pinController = TextEditingController();

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.black),
        borderRadius: BorderRadius.circular(8),
      ),
    );

    ref.listen(loginController, (previous, authState) {
      authState.maybeMap(
        data: (_) {
          // Only navigate away after successful OTP verification
          if (previous?.isLoading == true) {
            context.goNamed(
                Routes.HomeScreenRoute); // Navigate to your home screen
          }
        },
        error: (e) {
          final errorMessage = e.error.toString();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(errorMessage)),
          );
        },
        orElse: () {},
      );
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('OTP Verification'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Label(
              title: 'Enter Verification Code',
              subTitle: 'We have sent a verification code to $phoneNumber',
            ),
            gapH48,
            Center(
              child: Pinput(
                length: 6,
                controller: pinController,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    border: Border.all(color: AppColors.primaryColor),
                  ),
                ),
                onCompleted: (pin) {
                  // Auto-submit when all digits are entered
                  ref.read(loginController.notifier).verifyPhoneOtp(pin);
                },
              ),
            ),
            gapH48,
            CustomButton.primary(
              onPressed: () {
                FocusScope.of(context).unfocus();
                if (pinController.text.length == 6) {
                  ref
                      .read(loginController.notifier)
                      .verifyPhoneOtp(pinController.text);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please enter a valid 6-digit code'),
                    ),
                  );
                }
              },
              child: loginState.maybeWhen(
                loading: () => const CircularProgressIndicator(),
                orElse: () => Text(
                  'Verify',
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
            Center(
              child: TextButton(
                onPressed: () {
                  // Resend OTP
                  ref
                      .read(loginController.notifier)
                      .requestPhoneOtp(phoneNumber);
                },
                child: const Text(
                  'Resend Code',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
