# flutter_getx_template

本示例基于https://github.com/xieyezi/flutter-getx-template
支持了以下功能
- protobuf
- protobuf2json
- 主页框架

## 参考
[Flutter中使用Protobuf](https://cloud.tencent.com/developer/article/1411245)

> pub global activate protoc_plugin
> protoc --dart_out=grpc:lib/src/generated -Iprotos protos/helloworld.proto