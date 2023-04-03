import 'dart:async';
import 'package:flutter/material.dart';
import './theme_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuple/tuple.dart';
import './../../../utils/dlg_utils.dart';
import './../../../yase/yase.dart';
import 'dart:developer';
import 'theme_manager_bloc_event.dart';
import 'theme_manager_bloc_state.dart';

class BlocThemeManagerProvider
    extends Bloc<ThemeManagerEvent, ThemeManagerState> {
  BlocThemeManagerProvider() : super(ThemeManagerInitial()) {
    on<RemoveTheme>(_onRemoveTheme);
    on<AddTheme>(_onAddTheme);
    on<ChangeMode>(_onChangeThemeMode);
    on<ModifySystemTheme>(_onModifySystemTheme);
    on<ApplyTheme>(_onApplyTheme);
    on<SwapTheme>(_onChangeTheme);
    on<GetThemeMode>(_onGetThemeMode);
    on<GetThemeData>(_onGetThemeData);
    on<GetAvailableThemes>(_onGetAvailableThemes);
    //on<CreateTheme>(_onCreateTheme);
    on<ValidateThemeName>(_onValidateThemeName);
    on<GetThemeDataItemsAsListOfTuples>(_onGetThemeDataItemsAsListOfTuples);
  }

  //OperatorPressed event, Emitter<CalculationState> emit) {
  void _onGetAvailableThemes(
      GetAvailableThemes event, Emitter<ThemeManagerState> emit) {
    var state = ThemeManagerInitial();
    emit(state);
  }

  void _onChangeThemeMode(ChangeMode event, Emitter<ThemeManagerState> emit) {
    var newState = ThemeChanged(
        themeManager: event.themeManager,
        themeName: state.themeName,
        themeData: state.themeData,
        themeMode: event.mode,
        result: state.result,
        error: state.error,
        themeNames: []);
    emit(newState);
  }

  void _onRemoveTheme(RemoveTheme event, Emitter<ThemeManagerState> emit) {
    bool result = false;
    String error = '';
    var rawState = ThemeManagerInitial();
    if (event.themeManager.getAvailableThemes().containsKey(event.themeName)) {
      event.themeManager.getAvailableThemes().remove(event.themeName);
      result = true;
    } else {
      result = true;
      var themeName = event.themeName;
      error = 'Theme not found: $themeName';
    }
    emit(ThemeChanged(
        themeManager: event.themeManager,
        themeName: '',
        themeData: ThemeData(),
        themeMode: ThemeMode.system,
        result: result,
        error: error,
        themeNames: []));
  }

  void _onAddTheme(AddTheme event, Emitter<ThemeManagerState> emit) {
    bool result = false;
    String error = '';
    var rawState = ThemeManagerInitial();
    if (!event.themeManager.getAvailableThemes().containsKey(event.themeName)) {
      event.themeManager.getAvailableThemes()[event.themeName] =
          event.themeData;
      result = true;
    } else {
      if (event.force) {
        event.themeManager.getAvailableThemes()[event.themeName] =
            event.themeData;
        result = true;
      } else {
        result = false;
        error = 'Theme already exists';
      }
    }
    emit(ThemeChanged(
        themeManager: event.themeManager,
        themeName: '',
        themeData: ThemeData(),
        themeMode: ThemeMode.system,
        result: result,
        error: error,
        themeNames: []));
  }

  void _onModifySystemTheme(
      ModifySystemTheme event, Emitter<ThemeManagerState> emit) {
    bool result = false;
    String error = '';
    var rawState = ThemeManagerInitial();
    debugger();
    event.themeManager.getAvailableThemes()['system'] = event.newThemeData;
    emit(ThemeChanged(
        themeManager: event.themeManager,
        themeName: 'system',
        themeData: event.newThemeData,
        themeMode: event.themeManager.getThemeMode(),
        result: result,
        error: error,
        themeNames: []));
  }

  void _onApplyTheme(ApplyTheme event, Emitter<ThemeManagerState> emit) {
    bool result = false;
    String error = '';
    var rawState = ThemeManagerInitial();
    event.themeManager.getAvailableThemes()['prevSystem'] =
        event.themeManager.getAvailableThemes()['system']!;
    if (event.themeManager.getAvailableThemes().containsKey(event.themeName)) {
      event.themeManager.getAvailableThemes()['system'] =
          event.themeManager.getAvailableThemes()[event.themeName]!;
    } else {
      event.themeManager.getAvailableThemes()[event.themeName] =
          event.themeData;
      event.themeManager.getAvailableThemes()['system'] = event.themeData;
    }
    result = true;
    emit(ThemeChanged(
        themeManager: event.themeManager,
        themeName: event.themeName,
        themeData: event.themeData,
        themeMode: event.themeManager.getThemeMode(),
        result: result,
        error: error,
        themeNames: []));
  }

  void _onChangeTheme(SwapTheme event, Emitter<ThemeManagerState> emit) {
    bool result = false;
    String error = '';
    var rawState = ThemeManagerInitial();
    var incomingThemeName = event.incommingThemeName;
    var outgoingThemeName = event.outgoingThemeName;
    if (!event.themeManager
        .getAvailableThemes()
        .containsKey(event.incommingThemeName))
      error = 'Incoming theme $incomingThemeName not found';
    if (!event.themeManager
        .getAvailableThemes()
        .containsKey(event.outgoingThemeName))
      error = 'Outgoing theme $outgoingThemeName not found';
    if (error.length == 0) {
      event.themeManager.getAvailableThemes()['prevSystem'] =
          event.themeManager.getAvailableThemes()['system']!;
      event.themeManager.getAvailableThemes()['system'] =
          event.themeManager.getAvailableThemes()[event.incommingThemeName]!;
      result = true;
    }
    emit(ThemeChanged(
        themeManager: event.themeManager,
        themeName: event.incommingThemeName,
        themeData:
            event.themeManager.getAvailableThemes()[event.incommingThemeName],
        themeMode: event.themeManager.getThemeMode(),
        result: result,
        error: error,
        themeNames: []));
  }

  void _onGetThemeMode(GetThemeMode event, Emitter<ThemeManagerState> emit) {
    bool result = true;
    String error = '';
    var rawState = ThemeManagerInitial();
    emit(ThemeChanged(
        themeManager: event.themeManager,
        themeName: '',
        themeData: null,
        themeMode: event.themeManager.getThemeMode(),
        result: result,
        error: error,
        themeNames: []));
  }

  void _onGetThemeData(GetThemeData event, Emitter<ThemeManagerState> emit) {
    bool result = true;
    String error = '';
    var rawState = ThemeManagerInitial();
    emit(ThemeChanged(
        themeManager: event.themeManager,
        themeName: '',
        themeData: event.themeManager.getAvailableThemes()[event.themeName]!,
        themeMode: ThemeMode.system,
        result: result,
        error: error,
        themeNames: []));
  }

/*
  void _onCreateTheme(
      CreateTheme event, Emitter<ThemeManagerState> emit) async {
    bool result = true;
    String error = '';
    var rawState = ThemeManagerInitial();
    String? themeName = await PromptUserInputSingleEdit(
        event.context, 'Create Theme', 'New Theme Name', 'OK', 'Cancel');
    if (themeName!.length == 0) {
      return;
    }
    print('CreateTheme: $themeName');
    if (event.themeManager.getAvailableThemes().containsKey(themeName)) {
      PromptUserBool(event.context, 'Create Theme',
          'Theme name $themeName already exists', 'OK', '');
    } else {
      event.themeManager.getAvailableThemes()[themeName] = event.themeManager.getAvailableThemes()['system']!;
    }
    emit(ThemeChanged(
      themeManager: event.themeManager,
        themeName: '',
        themeData: event.themeManager.getAvailableThemes()[themeName]!,
        themeMode: ThemeMode.system,
        result: result,
        error: error,
        themeNames: []));
  }
*/
  void _onValidateThemeName(
      ValidateThemeName event, Emitter<ThemeManagerState> emit) {
    bool result = true;
    String error = '';
    var rawState = ThemeManagerInitial();
    var themeName = event.themeName;
    if (event.themeManager.getAvailableThemes().containsKey(event.themeName)) {
      error = '$themeName not found';
      result = false;
    }
    emit(ThemeChanged(
        themeManager: event.themeManager,
        themeName: '',
        themeData: event.themeManager.getAvailableThemes()[event.themeName]!,
        themeMode: ThemeMode.system,
        result: result,
        error: error,
        themeNames: []));
  }

  void _onGetThemeDataItemsAsListOfTuples(
      GetThemeDataItemsAsListOfTuples event, Emitter<ThemeManagerState> emit) {
    bool result = true;
    String error = '';
    var rawState = ThemeManagerInitial();
    List<Tuple2<String, ThemeData>> themeNames = [];
    event.themeManager.getAvailableThemes().entries.toList().forEach((element) {
      themeNames.add(Tuple2<String, ThemeData>(element.key, element.value));
    });
    emit(ThemeChanged(
        themeManager: event.themeManager,
        themeName: '',
        themeData: event.themeManager.getAvailableThemes()['system']!,
        themeMode: ThemeMode.system,
        result: result,
        error: error,
        themeNames: themeNames));
  }
}
