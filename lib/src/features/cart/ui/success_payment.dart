import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:pharmacy_hub/src/core/helper.dart';
import 'package:pharmacy_hub/src/core/resources/routes_manager.dart';
import 'package:pharmacy_hub/src/core/widget/custom_button.dart';

class SuccessPaymentScreen extends StatefulWidget {
  const SuccessPaymentScreen({super.key});

  @override
  State<SuccessPaymentScreen> createState() => _SuccessPaymentScreenState();
}

class _SuccessPaymentScreenState extends State<SuccessPaymentScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              100.verticalSpace,
              Lottie.asset(
                'assets/lottie/success_payment_animation.json',
                controller: _controller,
                fit: BoxFit.cover,
                alignment: AlignmentDirectional.center,
                onLoaded: (composition) {
                  _controller.duration = composition.duration;
                  _controller
                    ..reset()
                    ..forward();
                },
              ),
              20.verticalSpace,
              Text(
                'Your Order has been successfully placed !',
                style: context.titleSmall.copyWith(
                  fontWeight: FontWeight.w300,
                ),
              ),
              40.verticalSpace,
              CustomButton(
                text: 'Back to home',
                textStyle: context.titleSmall,
                isBorderButton: true,
                onTap: () => context.goNamed(Routes.appLayOut),
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
