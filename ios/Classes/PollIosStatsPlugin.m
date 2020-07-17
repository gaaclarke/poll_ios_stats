#import "PollIosStatsPlugin.h"

#import "messages.h"
#import <mach/mach.h>
#import <sys/sysctl.h>
#import <sys/types.h>

@interface MyPollIosStats : NSObject <ACPollIosStats>
@end

@implementation MyPollIosStats

- (nullable ACMemoryUsage *)pollMemoryUsage:
    (FlutterError *_Nullable *_Nonnull)error {
  kern_return_t kernel_return_code;
  task_vm_info_data_t task_memory_info;
  mach_msg_type_number_t task_memory_info_count = TASK_VM_INFO_COUNT;

  kernel_return_code =
      task_info(mach_task_self(), TASK_VM_INFO,
                (task_info_t)(&task_memory_info), &task_memory_info_count);
  if (kernel_return_code != KERN_SUCCESS) {
    NSString *message =
        [NSString stringWithUTF8String:mach_error_string(kernel_return_code)];
    *error = [FlutterError errorWithCode:@"poll_ios_stats"
                                 message:message
                                 details:nil];
    return nil;
  }

  const double dirty_memory_usage =
      (double)(task_memory_info.phys_footprint) / 1024.0 / 1024.0;
  const double owned_shared_memory_usage =
      (double)(task_memory_info.resident_size) / 1024.0 / 1024.0 -
      dirty_memory_usage;

  ACMemoryUsage *result = [[ACMemoryUsage alloc] init];

  result.dirtyMemoryUsage = @(dirty_memory_usage);
  result.ownedSharedMemoryUsage = @(owned_shared_memory_usage);

  return result;
}

- (nullable ACStartupTime *)pollStartupTime:
    (FlutterError *_Nullable *_Nonnull)error {
  pid_t pid = [[NSProcessInfo processInfo] processIdentifier];
  int mib[4] = {CTL_KERN, KERN_PROC, KERN_PROC_PID, pid};
  struct kinfo_proc proc;
  size_t size = sizeof(proc);
  int err = sysctl(mib, 4, &proc, &size, NULL, 0);  
  if (err != 0) {
    int errCode = errno;
    *error = [FlutterError errorWithCode:@"poll_ios_stats"
                                 message:[NSString stringWithFormat:@"sysctl %d", errCode]
                                 details:nil];
    return nil;
  }

  struct timeval startTime = proc.kp_proc.p_starttime;
  int64_t microsecondsInSecond = 1000000LL;
  int64_t microsecondsSinceEpoch =
      (int64_t)(startTime.tv_sec * microsecondsInSecond) +
      (int64_t)startTime.tv_usec;

  ACStartupTime *result = [[ACStartupTime alloc] init];
  result.startupTime = @(microsecondsSinceEpoch);
  return result;
}
@end

@implementation PollIosStatsPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
  ACPollIosStatsSetup(registrar.messenger, [[MyPollIosStats alloc] init]);
}
@end
