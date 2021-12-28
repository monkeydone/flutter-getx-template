import 'package:flutter_getx_template/env.dart';

// 开发环境
const SERVER_HOST_DEV = 'http://192.168.3.21:30366';

// 生产环境
// 生产环境地址禁止随意修改！！！
const SERVER_HOST_PROD = '';

const SERVER_API_URL = ENV_IS_DEV ? SERVER_HOST_DEV : SERVER_HOST_PROD;

const ENV_IS_DEV = ENV == "DEV";

const PUSH_PREFIX = ENV_IS_DEV ? "test_" : "prod_";

const GRPC_SERVER_HOST = '127.0.0.1';
const GRPC_PORT = 50051;
