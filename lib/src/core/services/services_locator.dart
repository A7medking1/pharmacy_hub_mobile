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
        responseBody: true,
      ),
    );
    sl.registerLazySingleton(() => AppInterceptors());

    sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(client: sl()));

    sl.registerLazySingleton(() => HomeRepository(sl()));
    sl.registerLazySingleton(() => CartRepository(sl()));
    sl.registerLazySingleton(() => AuthRepository(sl()));


    sl.registerFactory(() => AuthBloc(sl()));
    sl.registerFactory(() => HomeBloc(sl()));
    sl.registerFactory(() => ProfileBloc());
    //sl.registerFactory(() => PaginationBloc(sl()));
    sl.registerFactory(() => PaginationBloc(sl()));
    sl.registerFactory(() => SearchBloc(sl()));
    sl.registerFactory(() => CartBloc(sl()));
  }
}
