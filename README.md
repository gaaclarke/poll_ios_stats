# poll_ios_stats

A plugin for polling iOS system information.

**Warning:**: Compatability with Apple's App Store policies isn't guaranteed.

## Supported stats

Currently you can poll:

* time since startup - This gives you the time since the operating launched the
  process measured in microseconds since epoch.
* dirty memory usage - (task_vm_info.phys_footprint) in MB.
* owned shared memory usage -  (task_vm_info.resident_size - task_vm_info.phys_footprint) in MB.
