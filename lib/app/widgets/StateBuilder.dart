import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tutorheaven/app/data/models/States/states.dart';

class StateBuilder extends StatelessWidget {
  Rx<Appstate> state;
  Widget Function() onInitial;
  Widget Function() onLoading;
  Widget Function() onError;
  Widget Function() onSuccess;
  StateBuilder({
    super.key,
    required this.onInitial,
    required this.state,
    required this.onLoading,
    required this.onError,
    required this.onSuccess,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
    
      switch (state.value) {
        case Appstate.loading:
          return onLoading();
        case Appstate.success:
          return onSuccess();
        case Appstate.error:
          return onError();
        default:
          return onInitial();
      }
    });
  }
}
