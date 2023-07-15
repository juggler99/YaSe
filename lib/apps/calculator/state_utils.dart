import 'package:equatable/equatable.dart';
import 'calculator_model.dart';

abstract class CalculationState extends Equatable {
  final CalculationModel calculationModel;
  const CalculationState({required this.calculationModel});
  @override
  List<Object> get props => [calculationModel];
}

class CalculationInitial extends CalculationState {
  CalculationInitial() : super(calculationModel: CalculationModel());
}

class CalculationChanged extends CalculationState {
  final CalculationModel calculationModel;
  const CalculationChanged({required this.calculationModel})
      : super(calculationModel: calculationModel);
  @override
  List<Object> get props => [calculationModel];
}
