import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../controls/bloc_controls/theme_manager/theme_manager_bloc_provider.dart';
import '../controls/bloc_controls/py_code/py_code_bloc.dart';
import '../controls/bloc_controls/screen_size_provider/screen_size_bloc.dart';
import '../controls/bloc_controls/theme_manager/theme_manager.dart';
import 'app_config.dart';
import 'yase.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppConfig.loadConfig();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (_) => BlocThemeManagerProvider()),
    BlocProvider(create: (_) => PyCodeBloc()),
    BlocProvider(create: (_) => ScreenSizeBloc())
  ], child: YaSeApp()));
}
