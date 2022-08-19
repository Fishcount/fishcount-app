class UrlBuilder<T> {
  String baseUrl;

  String? param;

  String? queryParam;

  UrlBuilder({
    required this.baseUrl,
  });

  UrlBuilder addQueryParam(String key, String value) {
    final String separator = queryParam == null ? '?' : '&';
    String query = queryParam == null ? '' : queryParam!;
    queryParam = '$query$separator$key=$value';
    return this;
  }

  UrlBuilder addParam(String param) {
    if (this.param == null) {
      this.param = '/$param';
      return this;
    }
    this.param = this.param! + '/$param';
    return this;
  }

  String build() {
    if (param != null) {
      baseUrl = baseUrl + param!;
    }
    if (queryParam != null) {
      baseUrl = baseUrl + queryParam!;
    }
    return baseUrl;
  }
}
