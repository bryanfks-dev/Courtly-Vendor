import 'package:courtly_vendor/core/config/app_themes.dart';
import 'package:courtly_vendor/data/repository/api/change_password_repository.dart';
import 'package:courtly_vendor/data/repository/api/court_repository.dart';
import 'package:courtly_vendor/data/repository/api/login_repository.dart';
import 'package:courtly_vendor/data/repository/api/logout_repository.dart';
import 'package:courtly_vendor/data/repository/api/order_repository.dart';
import 'package:courtly_vendor/data/repository/api/review_repository.dart';
import 'package:courtly_vendor/data/repository/api/vendor_repository.dart';
import 'package:courtly_vendor/data/repository/api/verify_password_repository.dart';
import 'package:courtly_vendor/data/repository/storage/token_repository.dart';
import 'package:courtly_vendor/domain/usecases/auth_usecase.dart';
import 'package:courtly_vendor/domain/usecases/change_password_usecase.dart';
import 'package:courtly_vendor/domain/usecases/court_usecase.dart';
import 'package:courtly_vendor/domain/usecases/login_usecase.dart';
import 'package:courtly_vendor/domain/usecases/logout_usecase.dart';
import 'package:courtly_vendor/domain/usecases/order_usecase.dart';
import 'package:courtly_vendor/domain/usecases/review_usecase.dart';
import 'package:courtly_vendor/domain/usecases/vendor_usecase.dart';
import 'package:courtly_vendor/domain/usecases/verify_password_usecase.dart';
import 'package:courtly_vendor/presentation/blocs/auth_bloc.dart';
import 'package:courtly_vendor/presentation/blocs/change_password_bloc.dart';
import 'package:courtly_vendor/presentation/blocs/events/auth_event.dart';
import 'package:courtly_vendor/presentation/blocs/home_bloc.dart';
import 'package:courtly_vendor/presentation/blocs/login_bloc.dart';
import 'package:courtly_vendor/presentation/blocs/logout_bloc.dart';
import 'package:courtly_vendor/presentation/blocs/my_courts_bloc.dart';
import 'package:courtly_vendor/presentation/blocs/orders_bloc.dart';
import 'package:courtly_vendor/presentation/blocs/reviews_bloc.dart';
import 'package:courtly_vendor/presentation/blocs/states/auth_state.dart';
import 'package:courtly_vendor/presentation/blocs/vendor_bloc.dart';
import 'package:courtly_vendor/presentation/pages/add_new_court.dart';
import 'package:courtly_vendor/presentation/pages/change_password.dart';
import 'package:courtly_vendor/presentation/pages/my_court_detail.dart';
import 'package:courtly_vendor/presentation/pages/login.dart';
import 'package:courtly_vendor/presentation/pages/my_courts.dart';
import 'package:courtly_vendor/presentation/widgets/app_scaffold.dart';
import 'package:courtly_vendor/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// [main] is the entry point of the application.
/// This function runs the application.
///
/// - Returns: void
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

/// [MyApp] is the main application widget.
/// This widget is the root of the application.
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => AuthBloc(
            authUsecase: AuthUsecase(
              tokenRepository: TokenRepository(),
            ),
          )..add(CheckAuthEvent()),
        ),
        BlocProvider(
            create: (BuildContext context) => LoginBloc(
                loginUsecase: LoginUsecase(
                    tokenRepository: TokenRepository(),
                    loginRepository: LoginRepository()))),
        BlocProvider(
            create: (BuildContext context) => HomeBloc(
                orderUsecase:
                    OrderUsecase(orderRepository: OrderRepository()))),
        BlocProvider(
            create: (BuildContext context) => VendorBloc(
                vendorUsecase:
                    VendorUsecase(vendorRepository: VendorRepository()))),
        BlocProvider(
            create: (BuildContext context) => ChangePasswordBloc(
                verifyPasswordUsecase: VerifyPasswordUsecase(
                    verifyPasswordRepository: VerifyPasswordRepository()),
                changePasswordUsecase: ChangePasswordUsecase(
                    changePasswordRepository: ChangePasswordRepository()))),
        BlocProvider(
            create: (BuildContext context) => OrdersBloc(
                orderUsecase:
                    OrderUsecase(orderRepository: OrderRepository()))),
        BlocProvider(
            create: (BuildContext context) => ReviewsBloc(
                reviewUsecase:
                    ReviewUsecase(reviewRepository: ReviewRepository()))),
        BlocProvider(
            create: (BuildContext context) => MyCourtsBloc(
                courtUsecase:
                    CourtUsecase(courtRepository: CourtRepository()))),
        BlocProvider(
            create: (BuildContext context) => LogoutBloc(
                logoutUsecase: LogoutUsecase(
                    logoutRepository: LogoutRepository(),
                    tokenRepository: TokenRepository())))
      ],
      child: MaterialApp(
        title: 'Courtly Vendor',
        debugShowCheckedModeBanner: false,
        theme: AppThemes.light,
        routes: {
          Routes.myCourts: (context) => const MyCourtsPage(),
          Routes.detailCourts: (context) => const MyCourtDetail(),
          Routes.changePassword: (context) => const ChangePasswordPage(),
          Routes.addNewCourt: (context) => const AddNewCourtPage(),
        },
        home: BlocBuilder<AuthBloc, AuthState>(
            builder: (BuildContext context, AuthState state) {
          if (state is AuthenticatedState) {
            return const AppScaffold();
          }

          return LoginPage();
        }),
      ),
    );
  }
}
