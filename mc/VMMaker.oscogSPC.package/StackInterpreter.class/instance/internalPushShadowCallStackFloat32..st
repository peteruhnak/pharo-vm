internal interpreter access
internalPushShadowCallStackFloat32: singleFloatValue
	<option: #LowcodeVM>
	<var: #singleFloatValue type: #float >
	"In the StackInterpreter stacks grow down."
	shadowCallStackPointer := shadowCallStackPointer - objectMemory bytesPerOop.

	"In the StackInterpreter stacks grow down."
	stackPages singleFloatAtPointer: shadowCallStackPointer put: singleFloatValue