import 'package:equatable/equatable.dart';
import 'package:mobile_umroh_v2/regional-manager/model/list_regional_manager_model.dart';

abstract class ListRegionalManagerState extends Equatable {
  @override
  List<Object> get props => [];
}

class ListRegionalManagerInitial extends ListRegionalManagerState {}

class ListRegionalManagerLoading extends ListRegionalManagerState {}

class ListRegionalManagerLoaded extends ListRegionalManagerState { 
  final List<DataListRegionalManager> listRegionalManager;

  ListRegionalManagerLoaded(this.listRegionalManager);

  @override
  List<Object> get props => [listRegionalManager];
}

class ListRegionalManagerError extends ListRegionalManagerState {
  final String message;

  ListRegionalManagerError(this.message);

  @override
  List<Object> get props => [message];
}