process primitive support
forceInterruptCheckFromHeartbeat
	"Force an interrupt check ASAP. This version is the
	 entry-point to forceInterruptCheck for the heartbeat
	 timer to allow for repeatable debugging."
	suppressHeartbeatFlag ifFalse:
		[self checkForLongRunningPrimitive.
		 self sqLowLevelMFence.
		 deferSmash
			ifTrue:
				[deferredSmash := true.
				 self sqLowLevelMFence]
			ifFalse:
				[self forceInterruptCheck]]