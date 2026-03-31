import 'package:bookia_app/core/routes/routes.dart';
import 'package:bookia_app/core/widgets/bottom_navigation_bar.dart';
import 'package:bookia_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookia_app/features/auth/presentation/view/login_screen.dart';
import 'package:bookia_app/features/auth/presentation/view/register_screen.dart';
import 'package:bookia_app/features/home/data/model/best_seller_model/products.dart';
import 'package:bookia_app/features/place_order/presentation/view/place_order_screen.dart';
import 'package:bookia_app/features/product_details.dart/presentation/view/product_details.dart';
import 'package:bookia_app/features/profile/presentation/edit_profile/view_model/edit_profile_cubit.dart';
import 'package:bookia_app/features/profile/presentation/edit_profile/view/edit_profile_screen.dart';
import 'package:bookia_app/features/splash/splash_screen.dart';
import 'package:bookia_app/features/welcome/welcome_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  // configuration
  static GoRouter routes = GoRouter(
    navigatorKey: globalContext,
    routes: [
      GoRoute(
        path: Routes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: Routes.welcome,
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: Routes.login,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(),
          child: const LoginScreen(),
        ),
      ),
      GoRoute(
        path: Routes.register,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(),
          child: const RegisterScreen(),
        ),
      ),
      GoRoute(
        path: Routes.main,
        builder: (context, state) {
          var selectedIndex = state.extra as int?;
          return MainAppScreen(selectedIndex: selectedIndex);
        },
      ),
      GoRoute(
        path: Routes.details,
        builder: (context, state) {
          return ProductDetails(product: state.extra as Product);
        },
      ),
      GoRoute(
        path: Routes.placeOrder,
        builder: (context, state) {
          return PlaceOrderScreen(total: state.extra as String);
        },
      ),
      GoRoute(
        path: Routes.editProfile,
        builder: (context, state) {
          return BlocProvider(
            create: (context) {
              var cubit = EditProfileCubit();
              cubit.loadInitData();
              return cubit;
            },
            child: EditProfileScreen(),
          );
        },
      ),
    ],
  );
}
