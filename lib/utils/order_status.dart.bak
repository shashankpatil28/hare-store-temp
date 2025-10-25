// Path: lib/utils/order_status.dart

class Order<T> {
  OrderStatus status = OrderStatus.unknown;

  // 1 => request pending,
  // 2 => approved by store,
  // 3 => rejected,
  // 4 => cancelled,
  // 5 => processing,
  // 6 => ready order,
  // 7 => arrived-driver,
  // 8 => ongoing,
  // 9 => completed,
  // 10 => failed

  Order.getStatus(int s) {
    switch (s) {
      case 1:
        status = OrderStatus.pendingOrder;
        break;
      case 2:
        status = OrderStatus.accept;
        break;
      case 3:
        status = OrderStatus.rejected;
        break;
      case 4:
        status = OrderStatus.cancelled;
        break;
      case 5:
        status = OrderStatus.processing;
        break;
      case 6:
        status = OrderStatus.ready;
        break;
      case 7:
      case 8:
        status = OrderStatus.dispatch;
        break;
      case 9:
        status = OrderStatus.complete;
        break;
      default:
        status = OrderStatus.unknown;
        break;
    }
  }
}

enum OrderStatus {
  pendingOrder,
  accept,
  processing,
  ready,
  dispatch,
  complete,
  rejected,
  cancelled,
  unknown
}

const int changeOrderAccept = 2;
const int changeOrderReject = 3;
const int changeOrderCancel = 4;
const int changeOrderStartProcessing = 5;
const int changeOrderReady = 6;
const int changeOrderDispatch = 8;
const int orderStatusComplete = 9;
