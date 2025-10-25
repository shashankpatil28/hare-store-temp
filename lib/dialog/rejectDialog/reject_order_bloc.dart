// Path: lib/dialog/rejectDialog/reject_order_bloc.dart

import 'package:flutter/cupertino.dart';

import '../../network/api_response.dart';
import '../../screen/homeScreen/home_dl.dart';
import '../../utils/bloc.dart';

class RejectOrderBloc extends Bloc {
  BuildContext context;

  final _rejectOrder = BehaviorSubject<ApiResponse<HomeResponse>>();

  BehaviorSubject<ApiResponse<HomeResponse>> get rejectOrder => _rejectOrder;

  RejectOrderBloc(this.context);

  @override
  void dispose() {
    _rejectOrder.close();
  }
}
