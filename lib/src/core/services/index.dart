library services ;

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pharmacy_hub/src/core/api/api_consumer.dart';
import 'package:pharmacy_hub/src/core/api/app_interceptors.dart';
import 'package:pharmacy_hub/src/core/api/dio_consumer.dart';
import 'package:pharmacy_hub/src/core/app_prefs/app_prefs.dart';
import 'package:pharmacy_hub/src/features/auth/logic/auth_bloc.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'services_locator.dart';