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
    // fetchPage must return a Future<List<T>> (non-null) — implement accordingly.
    _pagingController = PagingController<int, OrderHistoryItem>(
      // decide next page key from the current state; this helper uses the provided extensions
      getNextPageKey: (pagingState) =>
          pagingState.lastPageIsEmpty ? null : pagingState.nextIntPageKey,
      // When controller needs a page, it calls this function with the pageKey.
      // This fetchPage returns List<OrderHistoryItem> (non-null) or throws on error.
      fetchPage: (pageKey) async {
        // Determine filter at call time
        final currentFilter = filterSelected?.filterType ?? filterAll;

        // Check connectivity first
        var connectivityResult = await cp.Connectivity().checkConnectivity();
        if (connectivityResult.contains(cp.ConnectivityResult.none)) {
          // No internet -> throw so controller captures error
          final noInternetMsg = languages.noInternet;
          // For the initial page also update header stream
          if (pageKey == 1 && !_orderHistoryResponse.isClosed) {
            _orderHistoryResponse.sink.add(ApiResponse.error(noInternetMsg));
          }
          throw Exception(noInternetMsg);
        }

        try {
          // Fetch raw response from repo
          final raw = await _repo.getOrderHistory(page: pageKey, filterType: currentFilter);
          final response = OrderHistoryResponse.fromJson(raw);

          if (!state.mounted) {
            // If widget is unmounted, return empty list (non-null)
            return <OrderHistoryItem>[];
          }

          final apiMsg = getApiMsg(context, response.message, response.messageCode);

          if (!isApiStatus(context, response.status, apiMsg, false)) {
            // API returned non-success -> if first page update header stream, then throw
            if (pageKey == 1 && !_orderHistoryResponse.isClosed) {
              _orderHistoryResponse.add(ApiResponse.error(apiMsg));
            }
            throw Exception(apiMsg);
          }

          // Successful response -> update header for first page
          if (pageKey == 1 && !_orderHistoryResponse.isClosed) {
            _orderHistoryResponse.add(ApiResponse.completed(response));
          }

          // Return items (non-null). Controller will append pages and manage its internal state.
          return response.orderHistory;
        } catch (e) {
          // Ensure header stream updated for first page error
          final errMsg = e is Exception ? e.toString() : languages.apiErrorUnexpectedErrorMsg;
          if (pageKey == 1 && !_orderHistoryResponse.isClosed) {
            _orderHistoryResponse.sink.add(ApiResponse.error(errMsg));
          }
          // Re-throw to let PagingController set its error state
          throw Exception(errMsg);
        }
      },
    );

    // Trigger the first load
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
      final currentValue = _pagingController.value;
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

  // NOTE:
  // getOrderHistory used earlier for manual controller updates is kept for compatibility
  // but it's no longer used by the controller directly. You can remove it if unused.
  Future<void> getOrderHistory(int page, int filterType) async {
    // Kept for backward compatibility — it updates controller state manually.
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
          if (page == 1 && !_orderHistoryResponse.isClosed) {
            _orderHistoryResponse.add(ApiResponse.completed(response));
          }

          final isLastPage = response.currentPage >= response.lastPage;
          final newItems = response.orderHistory;

          final currentValue = _pagingController.value;
          final existingPages = currentValue.pages ?? <List<OrderHistoryItem>>[];
          final existingKeys = currentValue.keys?.cast<int>() ?? <int>[];

          final List<List<OrderHistoryItem>> updatedPages;
          final List<int> updatedKeys;

          if (page == 1) {
            updatedPages = [newItems];
            updatedKeys = [page];
          } else {
            updatedPages = [...existingPages, newItems];
            updatedKeys = [...existingKeys, page];
          }

          _pagingController.value = currentValue.copyWith(
            pages: updatedPages,
            keys: updatedKeys,
            hasNextPage: !isLastPage,
            error: null,
          );
        } else {
          if (!_orderHistoryResponse.isClosed && page == 1) {
            _orderHistoryResponse.add(ApiResponse.error(apiMsg));
          }
          final currentValue = _pagingController.value;
          _pagingController.value = currentValue.copyWith(error: apiMsg);
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
