import 'package:base_bloc/components/app_button.dart';
import 'package:base_bloc/components/app_scalford.dart';
import 'package:base_bloc/components/app_text.dart';
import 'package:base_bloc/components/appbar_widget.dart';
import 'package:base_bloc/modules/bonjour/client/client_cubit.dart';
import 'package:base_bloc/modules/bonjour/client/client_state.dart';
import 'package:base_bloc/theme/app_styles.dart';
import 'package:base_bloc/theme/colors.dart';
import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClientPage extends StatefulWidget {
  const ClientPage({Key? key}) : super(key: key);

  @override
  State<ClientPage> createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage> {
  var _bloc = ClientCubit();

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        appbar: appBarWidget(
            context: context, title: AppText("CLIENT", style: typoW400)),
        body: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BlocBuilder<ClientCubit, ClientState>(
              bloc: _bloc,
              builder: (c, state) => AppButton(
                  title: !state.isLogin ? "LOGIN" : "LOGOUT",
                  backgroundColor: colorOrange100,
                  onPress: () => !state.isLogin
                      ? _bloc.loginOnClick(context)
                      : _bloc.logoutOnClick(context),
                  shapeBorder: const RoundedRectangleBorder(
                      side: BorderSide(color: colorOrange100),
                      borderRadius: BorderRadius.all(Radius.circular(20))))),
        ],
      ),
    ));
  }

  @override
  void dispose() {
    _bloc.logoutOnClick(context);
    super.dispose();
  }
}
