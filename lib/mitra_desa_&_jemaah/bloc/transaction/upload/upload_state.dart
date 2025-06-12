import 'package:equatable/equatable.dart';

abstract class UploadState extends Equatable {
  @override
  List<Object> get props => [];
}

class UploadInitial extends UploadState {}

class UploadLoading extends UploadState {}

class UploadSuccess extends UploadState {
  @override
  List<Object> get props => [];
}

class UploadError extends UploadState {
  final String message;

  UploadError(this.message);

  @override
  List<Object> get props => [message];
}
