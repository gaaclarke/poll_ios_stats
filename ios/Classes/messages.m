// Autogenerated from Pigeon (v0.1.2), do not edit directly.
// See also: https://pub.dev/packages/pigeon
#import "messages.h"
#import <Flutter/Flutter.h>

#if !__has_feature(objc_arc)
#error File requires ARC to be enabled.
#endif

static NSDictionary* wrapResult(NSDictionary *result, FlutterError *error) {
  NSDictionary *errorDict = (NSDictionary *)[NSNull null];
  if (error) {
    errorDict = [NSDictionary dictionaryWithObjectsAndKeys:
        (error.code ? error.code : [NSNull null]), @"code",
        (error.message ? error.message : [NSNull null]), @"message",
        (error.details ? error.details : [NSNull null]), @"details",
        nil];
  }
  return [NSDictionary dictionaryWithObjectsAndKeys:
      (result ? result : [NSNull null]), @"result",
      errorDict, @"error",
      nil];
}

@interface ACMemoryUsage ()
+(ACMemoryUsage*)fromMap:(NSDictionary*)dict;
-(NSDictionary*)toMap;
@end
@interface ACStartupTime ()
+(ACStartupTime*)fromMap:(NSDictionary*)dict;
-(NSDictionary*)toMap;
@end

@implementation ACMemoryUsage
+(ACMemoryUsage*)fromMap:(NSDictionary*)dict {
  ACMemoryUsage* result = [[ACMemoryUsage alloc] init];
  result.dirtyMemoryUsage = dict[@"dirtyMemoryUsage"];
  if ((NSNull *)result.dirtyMemoryUsage == [NSNull null]) {
    result.dirtyMemoryUsage = nil;
  }
  result.ownedSharedMemoryUsage = dict[@"ownedSharedMemoryUsage"];
  if ((NSNull *)result.ownedSharedMemoryUsage == [NSNull null]) {
    result.ownedSharedMemoryUsage = nil;
  }
  return result;
}
-(NSDictionary*)toMap {
  return [NSDictionary dictionaryWithObjectsAndKeys:(self.dirtyMemoryUsage ? self.dirtyMemoryUsage : [NSNull null]), @"dirtyMemoryUsage", (self.ownedSharedMemoryUsage ? self.ownedSharedMemoryUsage : [NSNull null]), @"ownedSharedMemoryUsage", nil];
}
@end

@implementation ACStartupTime
+(ACStartupTime*)fromMap:(NSDictionary*)dict {
  ACStartupTime* result = [[ACStartupTime alloc] init];
  result.startupTime = dict[@"startupTime"];
  if ((NSNull *)result.startupTime == [NSNull null]) {
    result.startupTime = nil;
  }
  return result;
}
-(NSDictionary*)toMap {
  return [NSDictionary dictionaryWithObjectsAndKeys:(self.startupTime ? self.startupTime : [NSNull null]), @"startupTime", nil];
}
@end

void ACPollIosStatsSetup(id<FlutterBinaryMessenger> binaryMessenger, id<ACPollIosStats> api) {
  {
    FlutterBasicMessageChannel *channel =
      [FlutterBasicMessageChannel
        messageChannelWithName:@"dev.flutter.pigeon.PollIosStats.pollMemoryUsage"
        binaryMessenger:binaryMessenger];
    if (api) {
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        FlutterError *error;
        ACMemoryUsage *output = [api pollMemoryUsage:&error];
        callback(wrapResult([output toMap], error));
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [FlutterBasicMessageChannel
        messageChannelWithName:@"dev.flutter.pigeon.PollIosStats.pollStartupTime"
        binaryMessenger:binaryMessenger];
    if (api) {
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        FlutterError *error;
        ACStartupTime *output = [api pollStartupTime:&error];
        callback(wrapResult([output toMap], error));
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
}
