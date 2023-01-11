import 'package:equatable/equatable.dart';

class ClientState extends Equatable {
  final bool isLogin;

  ClientState(this.isLogin);

  @override
  List<Object?> get props => [isLogin];
}
