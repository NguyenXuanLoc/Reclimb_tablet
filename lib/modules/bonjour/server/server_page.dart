import 'package:base_bloc/components/app_scalford.dart';
import 'package:base_bloc/components/app_text_field.dart';
import 'package:base_bloc/components/appbar_widget.dart';
import 'package:base_bloc/data/globals.dart';
import 'package:base_bloc/modules/bonjour/server/server_cubit.dart';
import 'package:base_bloc/modules/bonjour/server/server_state.dart';
import 'package:base_bloc/theme/app_styles.dart';
import 'package:base_bloc/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/app_text.dart';

class ServerPage extends StatefulWidget {
  const ServerPage({Key? key}) : super(key: key);

  @override
  State<ServerPage> createState() => _ServerPageState();
}

class _ServerPageState extends State<ServerPage> {
  final _bloc = ServerCubit();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        appbar: appBarWidget(
            context: context,
            title: AppText("All user", style: typoW400.copyWith())),
        body: BlocBuilder<ServerCubit, ServerState>(
          builder: (BuildContext context, state) => ListView.builder(
              padding: EdgeInsets.all(contentPadding),
              itemCount: state.lUser.length,
              itemBuilder: (BuildContext context, int index) => AppText(
                    "${state.lUser[index].deviceModel} \n${state.lUser[index].accessToken}",
                    style: typoW400.copyWith(color: colorText0),
                  )),
          bloc: _bloc,
        ));
  }
}
