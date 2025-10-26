// Path: lib/screen/ordersHistoryScreen/order_history_bloc.dart

import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart' as cp; // Alias connectivity_plus
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:rxdart/rxdart.dart'; // <-- ADD THIS IMPORT

import '../../network/api_response.dart';
import '../../utils/bloc.dart';
import '../../utils/common_util.dart';
import 'order_history_dl.dart';
import 'order_history_repo.dart';
import 'order_history_screen.dart';

class OrderHistoryBloc implements Bloc {
  String tag = "OrderHistoryBloc>>>";
  BuildContext context;
  final OrderHistoryRepo _repo = OrderHistoryRepo();

  // Define filter types constants
  final int filterToday = 1,
      filterUpcoming = 5,
      filterLast7Days = 2,
      filterThisMonth = 3,
      filterYear = 4,
      filterAll = 0;

  late List<HistoryFilterModel> list; // Initialize in constructor
  HistoryFilterModel? filterSelected; // Keep track of the selected filter

  // --- NEW PAGING CONTROLLER PATTERN (infinite_scroll_pagination v5.x) ---
  // The PagingController now accepts getNextPageKey and fetchPage in constructor
  // We still expose the controller.value.state via the `state` getter used by widgets
  late final PagingController<int, OrderHistoryItem> _pagingController;
  PagingController<int, OrderHistoryItem> get pagingController => _pagingController;

  // Stream to hold the overall response (mainly for initial load and aggregate data)
  final _orderHistoryResponse = BehaviorSubject<ApiResponse<OrderHistoryResponse>>();
  // Stream to hold the currently selected filter model for UI updates
  final historyFilterModel = BehaviorSubject<HistoryFilterModel>();

  State<OrderHistoryScreen> state;

  OrderHistoryBloc(this.context, this.state) {
    // Initialize filter list using localized strings
    list = [
      HistoryFilterModel(languages.txtToday, filterToday),
      HistoryFilterModel(languages.txtUpcoming, filterUpcoming),
      HistoryFilterModel(languages.txtLast7Days, filterLast7Days),
      HistoryFilterModel(languages.txtThisMonth, filterThisMonth),
      HistoryFilterModel(languages.txtYear, filterYear),
      HistoryFilterModel(languages.txtAll, filterAll),
    ];

    // Set default filter
    filterSelected = list[0]; // Default to "Today"
    historyFilterModel.add(filterSelected!); // Emit default filter

    // Initialize the PagingController using the new API.
    // getNextPageKey is used by the controller to compute next integer page keys.
    // fetchPage is called by the controller when it needs data for a specific page key.
    _pagingController = PagingController<int, OrderHistoryItem>(
      // decide next page key from the current state; this helper uses the provided extensions
      getNextPageKey: (pagingState) =>
          pagingState.lastPageIsEmpty ? null : pagingState.nextIntPageKey,
      // When controller needs a page, it calls this function with the pageKey.
      // We'll delegate actual fetching to getOrderHistory which updates controller.value via copyWith.
      fetchPage: (pageKey) async {
        final currentFilter = filterSelected?.filterType ?? filterAll;
        await getOrderHistory(pageKey, currentFilter);
      },

    );

    // Note: no addPageRequestListener needed in v5.x — controller will call fetchPage automatically.

    // Optionally trigger the first load by fetching first page key using fetchNextPage.
    // The controller will internally call our fetchPage to load the first page.
    // If you prefer to wait until UI mounts, you can call this from the screen after init.
    _pagingController.fetchNextPage();
  }

  // Stream for the overall response (useful for header data like counts)
  Stream<ApiResponse<OrderHistoryResponse>> get orderHistoryResponseStream =>
      _orderHistoryResponse.stream;

  // Function to change the filter and refresh the list
  void changeFilter(HistoryFilterModel newFilter) {
    if (filterSelected?.filterType != newFilter.filterType) {
      filterSelected = newFilter;
      if (!historyFilterModel.isClosed) {
        historyFilterModel.add(newFilter);
      }
      // Reset paging state and trigger first page load
      // New API: we swap the controller.state to an "empty" state and call fetchNextPage.
      // Easiest approach here: clear pages and keys synchronously and request next page.
      final currentValue = _pagingController.value;
      // reset pages/keys and hasNextPage true (so fetchNextPage will run)
      _pagingController.value = currentValue.copyWith(
        pages: const <List<OrderHistoryItem>>[],
        keys: const <int>[],
        hasNextPage: true,
        error: null,
      );
      // trigger the first page fetch for the new filter
      _pagingController.fetchNextPage();
    }
  }

  // The new getOrderHistory updates PagingController.value using copyWith on its PagingState.
  // page: integer page number (pageKey). filterType: filter value.
  Future<void> getOrderHistory(int page, int filterType) async {
    // For the first page, also set the overall response stream loading
    if (page == 1 && !_orderHistoryResponse.isClosed) {
      _orderHistoryResponse.add(ApiResponse.loading());
    }

    var connectivityResult = await cp.Connectivity().checkConnectivity(); // Use alias
    if (!connectivityResult.contains(cp.ConnectivityResult.none)) {
      try {
        final response = OrderHistoryResponse.fromJson(
            await _repo.getOrderHistory(page: page, filterType: filterType));

        if (!state.mounted) return; // Check mounted after await

        final apiMsg = getApiMsg(context, response.message, response.messageCode);

        if (isApiStatus(context, response.status, apiMsg, false)) {
          // update header stream only for first page
          if (page == 1 && !_orderHistoryResponse.isClosed) {
            _orderHistoryResponse.add(ApiResponse.completed(response));
          }

          final isLastPage = response.currentPage >= response.lastPage;
          final newItems = response.orderHistory;

          // Build new pages and keys lists from current PagingState
          final currentValue = _pagingController.value;
          final existingPages = currentValue.pages ?? <List<OrderHistoryItem>>[];
          final existingKeys = currentValue.keys?.cast<int>() ?? <int>[];

          final List<List<OrderHistoryItem>> updatedPages;
          final List<int> updatedKeys;

          if (page == 1) {
            // replace pages with the first page
            updatedPages = [newItems];
            updatedKeys = [page];
          } else {
            updatedPages = [...existingPages, newItems];
            updatedKeys = [...existingKeys, page];
          }

          // Update the controller's state. copyWith accepts pages, keys, hasNextPage and more.
          _pagingController.value = currentValue.copyWith(
            pages: updatedPages,
            keys: updatedKeys,
            hasNextPage: !isLastPage,
            // clear any previous error
            error: null,
          );
        } else {
          // API indicated an error or non-success status
          if (!_orderHistoryResponse.isClosed && page == 1) {
            _orderHistoryResponse.add(ApiResponse.error(apiMsg));
          }
          // set error into the controller's state
          final currentValue = _pagingController.value;
          _pagingController.value = currentValue.copyWith(error: apiMsg);
          // Optionally show snackbar, but isApiStatus may already handle it
        }
      } catch (e) {
        if (!state.mounted) return;
        final errorMessage =
            e is Exception ? e.toString() : languages.apiErrorUnexpectedErrorMsg;
        logd(tag, "Get Order History Error (Page $page): $e");

        if (!_orderHistoryResponse.isClosed && page == 1) {
          _orderHistoryResponse.sink.add(ApiResponse.error(errorMessage));
        }

        final currentValue = _pagingController.value;
        _pagingController.value = currentValue.copyWith(error: errorMessage);
      }
    } else {
      // No internet
      if (!state.mounted) return;
      final noInternetMsg = languages.noInternet;
      if (!_orderHistoryResponse.isClosed && page == 1) {
        _orderHistoryResponse.sink.add(ApiResponse.error(noInternetMsg));
      }
      final currentValue = _pagingController.value;
      _pagingController.value = currentValue.copyWith(error: noInternetMsg);
      openSimpleSnackbar(noInternetMsg);
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    _orderHistoryResponse.close();
    historyFilterModel.close();
    // No super.dispose needed
  }
}

// Model for filter options (keep it simple)
class HistoryFilterModel {
  String filterName;
  int filterType;

  HistoryFilterModel(this.filterName, this.filterType);

  // Add == and hashCode for comparison, useful for Radio groupValue
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HistoryFilterModel &&
          runtimeType == other.runtimeType &&
          filterType == other.filterType;

  @override
  int get hashCode => filterType.hashCode;
}
