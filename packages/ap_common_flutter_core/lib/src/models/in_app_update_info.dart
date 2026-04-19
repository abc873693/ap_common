enum InAppUpdateAvailability {
  unknown,
  updateNotAvailable,
  updateAvailable,
  updateInProgress,
}

class InAppUpdateInfo {
  const InAppUpdateInfo({
    required this.updateAvailability,
    required this.immediateUpdateAllowed,
    required this.flexibleUpdateAllowed,
  });

  final InAppUpdateAvailability updateAvailability;
  final bool immediateUpdateAllowed;
  final bool flexibleUpdateAllowed;
}
