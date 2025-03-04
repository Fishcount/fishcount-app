import 'package:dio/dio.dart';
import 'package:fishcount_app/api/dio/CustomDio.dart';

class RequestBuilder<T> {
  String url;

  String? _param;

  String? _queryParam;

  Map<String, dynamic>? _body;

  bool _hasBody = true;

  RequestBuilder({
    required this.url,
  });

  Future<Response<dynamic>> get() async {
    return CustomDio().dioGet(url);
  }

  Future<Response<List<dynamic>>> getAll() async {
    return CustomDio().dioGetAll(url);
  }

  Future<Response<dynamic>> post() async {
    if (_body == null && _hasBody) {
      throw Exception('Body was not set!');
    }
    if (!_hasBody){
      return CustomDio().dioPostWithoutBody(url);
    }
    return CustomDio().dioPost(url, _body!);
  }

  Future<Response<void>> put() async {
    if (_body == null && _hasBody) {
      throw Exception('Body was not set!');
    }
    if (!_hasBody){
      return CustomDio().dioPutWithoutBody(url);
    }
    return CustomDio().dioPut(url, _body!);
  }

  Future<Response<void>> delete() async {
    return CustomDio().dioDelete(url);
  }

  RequestBuilder setBody(Map<String, dynamic> data) {
    _body ??= data;
    return this;
  }

  RequestBuilder addQueryParam(String key, String value) {
    final String separator = _queryParam == null ? '?' : '&';
    String query = _queryParam == null ? '' : _queryParam!;
    _queryParam = '$query$separator$key=$value';
    return this;
  }

  RequestBuilder addPathParam(String param) {
    if (_param == null) {
      _param = '/$param';
      return this;
    }
    _param = _param! + '/$param';
    return this;
  }

  RequestBuilder buildUrl() {
    if (_param != null) {
      url = url + _param!;
    }
    if (_queryParam != null) {
      url = url + _queryParam!;
    }
    return this;
  }

  RequestBuilder hasBody(bool hasBody){
    _hasBody = hasBody;

    return this;
  }
}
