import 'package:equatable/equatable.dart';
import 'dart:developer';

class CalculationModel extends Equatable {
  CalculationModel({
    this.firstOperand,
    this.operator,
    this.secondOperand,
    this.result,
  });
  final int? firstOperand;
  final String? operator;
  final int? secondOperand;
  final int? result;
  @override
  String toString() {
    return "$firstOperand$operator$secondOperand=$result";
  }

  @override
  List<Object?> get props => [firstOperand, operator, secondOperand, result];

  CalculationModel copyWith(
      {int? Function()? firstOperand,
      String? Function()? operator,
      int? Function()? secondOperand,
      int? Function()? result}) {
    return CalculationModel(
      firstOperand: firstOperand?.call() ?? this.firstOperand,
      operator: operator?.call() ?? this.operator,
      secondOperand: secondOperand?.call() ?? this.secondOperand,
      result: result?.call() ?? this.result,
    );
  }
}
