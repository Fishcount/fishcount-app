import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AsyncSnapshotHandler {
  final AsyncSnapshot asyncSnapshot;
  final Widget widgetOnWaiting;
  final Widget widgetOnError;
  final Widget widgetOnEmptyResponse;
  final Widget widgetOnSuccess;

  AsyncSnapshotHandler({
    required this.asyncSnapshot,
    required this.widgetOnError,
    required this.widgetOnWaiting,
    required this.widgetOnEmptyResponse,
    required this.widgetOnSuccess,
  });

  Widget handler() {
    if (_requestOnWaiting()) {
      return Center(
        child: widgetOnWaiting,
      );
    }
    if (_requestDone()) {
      if (asyncSnapshot.hasData) {
        return (asyncSnapshot.data is List && asyncSnapshot.data.isEmpty)
            ? widgetOnEmptyResponse
            : widgetOnSuccess;
      }
    }
    if (_requestHasError()) {
      return widgetOnError;
    }
    return Center(
      child: widgetOnWaiting,
    );
  }

  bool _requestHasError() => asyncSnapshot.hasError;

  bool _requestDone() => asyncSnapshot.connectionState == ConnectionState.done;

  bool _requestOnWaiting() =>
      asyncSnapshot.connectionState == ConnectionState.waiting;
}
