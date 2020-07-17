import 'package:pigeon/pigeon.dart';

class MemoryUsage {
  double dirtyMemoryUsage;
  double ownedSharedMemoryUsage;
}

class StartupTime {
  int startupTime;
}

@HostApi()
abstract class PollIosStats {
  MemoryUsage pollMemoryUsage();
  StartupTime pollStartupTime();
}

void configurePigeon(PigeonOptions opts) {
  opts.objcOptions.prefix = "AC";
  opts.dartOut = "lib/messages.dart";
  opts.objcHeaderOut = "ios/Classes/messages.h";
  opts.objcSourceOut = "ios/Classes/messages.m";
}
