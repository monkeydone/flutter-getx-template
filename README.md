# flutter_getx_template

本示例基于https://github.com/xieyezi/flutter-getx-template
支持了以下功能
- protobuf
- protobuf2json
- 主页框架

## 参考
[Flutter中使用Protobuf](https://cloud.tencent.com/developer/article/1411245)


## 目的
这个template本身已经很方便的完成ui和ui的状态同步,剩下的工作需要我们从服务器拿到数据,然后绘制UI.一般使用json.使用json的时候,需要手动创建model对象.
对于简单的对象还是比较容易的.对于复杂的对象.就需要做不断的调试和修改,
我用过比较好的是[jsontomodel的网页生成器](https://www.webinovers.com/web-tools/json-to-dart-convertor)
很多公司使用protobuf来完成这个model的定义过程.那么我们就可以直接使用这个对象了.网上没有找到简单入门可见的例子.所以总结一下.把文章发出来方便大家使用


##演示
- 增加protobuf支持
- 支持grpc协议
- 修改proto文件
- 本地启动服务器
- 重新生成新的文件
- 在app内部调用接口访问数据
- 增加新的接口文件的定义

## 增加protobuf的支持

![image](https://user-images.githubusercontent.com/1287445/147535135-d5edf777-74dd-4d3f-89fe-a683d25efbb7.png)

## 启动本地服务器

> dart  run test/server.dart

## 使用app内部调用接口访问

```dart
    GrpcRequest().getHelloRequest(name:"dart").then((value) {
      userName = value.message;
      update();
    });
```
点击changeName.先从本地获取,然后从服务器获取

## 重新修改协议
我们增加一个接口,增加两个对象

```protobuf
// The greeting service definition.
service GreeterV2 {
  // Sends a greeting
  rpc SayHelloV2 (HelloRequestV2) returns (HelloReplyV2) {}
}

// The request message containing the user's name.
message HelloRequestV2 {
  string name = 1;
}

// The response message containing the greetings
message HelloReplyV2 {
  string message = 1;
  int32 version = 2;
}

```

我们需要使用命令重新生成proto文件,当遇到各种命令不存在时,可以用下面的命令来处理.

> brew install protobuf
> pub global activate protoc_plugin
> protoc --dart_out=grpc:lib/src/generated -Iprotos protos/helloworld.proto
> export "$PATH:$PWD/.pub-cache/bin"

proto文件更新以后.我们需要增加服务端的处理和客户端的处理

服务器端我们增加下面的内容
```

class GreeterV2Service extends GreeterV2ServiceBase {
  @override
  Future<HelloReplyV2> sayHelloV2(ServiceCall call, HelloRequestV2 request) async {
    return HelloReplyV2()..message = 'Hello, ${request.name}!'..version=2;
  }
}


```
把这个服务增加的服务器上
```dart
  final server = Server(
    [GreeterService(),
     GreeterV2Service()
    ],
```

详情可以看到test/server.dart

客户端我们增加下面的代码用来测试下新的接口服务

```dart

Future<void> helloV2({name="world v2"}) async {
  final channel = ClientChannel(
    'localhost',
    port: 50051,
    options: ChannelOptions(
      credentials: ChannelCredentials.insecure(),
      codecRegistry:
      CodecRegistry(codecs: const [GzipCodec(), IdentityCodec()]),
    ),
  );
  final stub = GreeterV2Client(channel);
  try {
    final response = await stub.sayHelloV2(
      HelloRequestV2()..name = name,
      options: CallOptions(compression: const GzipCodec()),
    );
    print('Greeter client received: ${response.message} version ${response.version}');
  } catch (e) {
    print('Caught error: $e');
  }
  await channel.shutdown();
}

```

## dart中protobuf转成json

```
      var data3 = value.toProto3Json();
      print(data3);
      HelloReply ii = HelloReply.create()..mergeFromProto3Json(data3);
      print(ii.message);
```

# 源码地址
[github地址](git@github.com:monkeydone/flutter-getx-template.git)