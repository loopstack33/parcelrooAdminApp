
import 'package:parcelroo_admin/views/dashboard/controller/dash_controller.dart';
import 'package:provider/provider.dart';

import '../views/login/controller/login_provider.dart';

/* ---------- THIS FILE ALL THE PROVIDERS (CONTROLLER'S ACCESS)---------- */
/* -------- 14-Apr-2023 -------- */

var multiProvider = [

  /// LoginProvider ///
  ChangeNotifierProvider<LoginProvider>(
    create: (_) => LoginProvider(),
    lazy: true,
  ),

  /// DASHBOARD PROVIDER ///
  ChangeNotifierProvider<DashController>(
    create: (_) => DashController(),
    lazy: true,
  ),

];
