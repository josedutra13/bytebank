import 'package:http/http.dart';
import 'package:http_interceptor/http/intercepted_client.dart';

import 'interceptors/interceptor.dart';

final Client client =
    InterceptedClient.build(interceptors: [LoggingInterceptor()]);
final Uri baseUrl = Uri.parse('http://192.168.2.108:8080/transactions');
