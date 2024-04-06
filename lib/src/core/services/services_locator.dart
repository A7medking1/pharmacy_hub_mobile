part of 'index.dart';

final GetIt sl = GetIt.instance;

class ServicesLocator {
  Future<void> init() async {
    /// app prefs

    final sharedPrefs = await SharedPreferences.getInstance();

    sl.registerFactory<SharedPreferences>(() => sharedPrefs);

    sl.registerLazySingleton<AppPreferences>(() => AppPreferences(sl()));

    /// Dio
    sl.registerLazySingleton<Dio>(() => Dio());

    sl.registerLazySingleton(
      () => PrettyDioLogger(
        request: false,
        responseBody: false,
      ),
    );
    sl.registerLazySingleton(() => AppInterceptors());

    sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(client: sl()));
    sl.registerFactory(() => AuthBloc());

    sl.registerLazySingleton(() => HomeRepository(sl()));

    sl.registerFactory(() => HomeBloc(sl()));
    sl.registerFactory(() => ProfileBloc());
    sl.registerFactory(() => PaginationBloc(sl()));
  }
}
