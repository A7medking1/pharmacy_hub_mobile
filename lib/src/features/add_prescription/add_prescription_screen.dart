import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy_hub/src/core/enums.dart';
import 'package:pharmacy_hub/src/core/helper.dart';
import 'package:pharmacy_hub/src/core/resources/app_colors.dart';
import 'package:pharmacy_hub/src/features/add_prescription/add_prescription_bloc.dart';

class AddPrescriptionScreen extends StatelessWidget {
  const AddPrescriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<AddPrescriptionBloc, AddPrescriptionState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsetsDirectional.symmetric(
              horizontal: 15.w,
              vertical: 30.h,
            ),
            child: Column(
              children: [
                Text(
                  'Search for your medicine quickly by uploading a photo of your doctor’s prescription or a specific medicine product. Simply capture or select a picture, and easily find what you need.',
                  style: context.titleSmall,
                ),
                40.verticalSpace,
                if (state.uploadReqState == ReqState.loading) ...[
                  const LinearProgressIndicator(),
                  50.verticalSpace,
                ],
                GestureDetector(
                  onTap: () {
                    //  BlocProvider.of<AddPrescriptionBloc>(context).add(AddImageEvent());
                    context.read<AddPrescriptionBloc>().add(AddImageEvent(context));
                  },
                  child: Container(
                    width: 120.w,
                    height: 120.h,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.camera_alt_outlined,
                            color: AppColors.white,
                            size: 40.h,
                          ),
                          15.verticalSpace,
                          Text(
                            'Upload',
                            style: context.titleSmall.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
