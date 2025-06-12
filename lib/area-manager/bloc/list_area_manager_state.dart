import 'package:equatable/equatable.dart';
import 'package:mobile_umroh_v2/area-manager/model/list_area_manager_model.dart';

abstract class ListAreaManagerState extends Equatable {
  @override
  List<Object> get props => [];
}

class ListAreaManagerInitial extends ListAreaManagerState {}

class ListAreaManagerLoading extends ListAreaManagerState {}

class ListAreaManagerLoaded extends ListAreaManagerState {
  final List<DataListAreaManager> dataListAreaManager;

  ListAreaManagerLoaded(this.dataListAreaManager);

  @override
  List<Object> get props => [dataListAreaManager];
}

class ListAreaManagerError extends ListAreaManagerState {
  final String message;

  ListAreaManagerError(this.message);

  @override
  List<Object> get props => [message];
}
