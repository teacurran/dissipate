///
//  Generated code. Do not modify.
//  source: dissipate.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'dissipate.pb.dart' as $0;
export 'dissipate.pb.dart';

class DissipateServiceClient extends $grpc.Client {
  static final _$register =
      $grpc.ClientMethod<$0.RegisterRequest, $0.RegisterResponse>(
          '/DissipateService/Register',
          ($0.RegisterRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.RegisterResponse.fromBuffer(value));
  static final _$createHandle =
      $grpc.ClientMethod<$0.CreateHandleRequest, $0.CreateHandleResponse>(
          '/DissipateService/CreateHandle',
          ($0.CreateHandleRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.CreateHandleResponse.fromBuffer(value));

  DissipateServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.RegisterResponse> register($0.RegisterRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$register, request, options: options);
  }

  $grpc.ResponseFuture<$0.CreateHandleResponse> createHandle(
      $0.CreateHandleRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createHandle, request, options: options);
  }
}

abstract class DissipateServiceBase extends $grpc.Service {
  $core.String get $name => 'DissipateService';

  DissipateServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.RegisterRequest, $0.RegisterResponse>(
        'Register',
        register_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.RegisterRequest.fromBuffer(value),
        ($0.RegisterResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.CreateHandleRequest, $0.CreateHandleResponse>(
            'CreateHandle',
            createHandle_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.CreateHandleRequest.fromBuffer(value),
            ($0.CreateHandleResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.RegisterResponse> register_Pre(
      $grpc.ServiceCall call, $async.Future<$0.RegisterRequest> request) async {
    return register(call, await request);
  }

  $async.Future<$0.CreateHandleResponse> createHandle_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.CreateHandleRequest> request) async {
    return createHandle(call, await request);
  }

  $async.Future<$0.RegisterResponse> register(
      $grpc.ServiceCall call, $0.RegisterRequest request);
  $async.Future<$0.CreateHandleResponse> createHandle(
      $grpc.ServiceCall call, $0.CreateHandleRequest request);
}
