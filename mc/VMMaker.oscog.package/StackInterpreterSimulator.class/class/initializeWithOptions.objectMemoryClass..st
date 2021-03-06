class initialization
initializeWithOptions: optionsDictionaryOrArray objectMemoryClass: objectMemoryClassOrNil
	"The relevant ObjectMemory and Interpreter classes must be initialized in order.
	 This happens notionally every time we start the simulator,
	 but in fact happens when ever we instantiate a simulator."
	initializationOptions := optionsDictionaryOrArray isArray
							ifTrue: [Dictionary newFromPairs: optionsDictionaryOrArray]
							ifFalse: [optionsDictionaryOrArray].

	(self allSuperclasses copyUpThrough: InterpreterPrimitives) do:
		[:sc| sc initializationOptions: initializationOptions].

	(objectMemoryClassOrNil ifNil: [self objectMemoryClass])
		initializeWithOptions: initializationOptions.

	self initializeWithOptions: initializationOptions