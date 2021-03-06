primitives
primitiveSocketCreateNetwork: netType type: socketType receiveBufferSize: recvBufSize sendBufSize: sendBufSize semaIndex: semaIndex readSemaIndex: aReadSema writeSemaIndex: aWriteSema 
	| socketOop s okToCreate |
	<var: #s type: 'SocketPtr '>
	self primitive: 'primitiveSocketCreate3Semaphores' parameters: #(#SmallInteger #SmallInteger #SmallInteger #SmallInteger #SmallInteger #SmallInteger #SmallInteger ).
	"If the security plugin can be loaded, use it to check for permission.
	If not, assume it's ok"
	sCCSOTfn ~= 0 ifTrue:
		[okToCreate := self cCode: ' ((sqInt (*) (sqInt, sqInt)) sCCSOTfn)(netType, socketType)'.
		 okToCreate ifFalse:
			[^ interpreterProxy primitiveFail]].
	socketOop := interpreterProxy instantiateClass: interpreterProxy classByteArray indexableSize: self socketRecordSize.
	s := self socketValueOf: socketOop.
	interpreterProxy failed ifFalse:
		[self
			sqSocket: s
			CreateNetType: netType
			SocketType: socketType
			RecvBytes: recvBufSize
			SendBytes: sendBufSize
			SemaID: semaIndex
			ReadSemaID: aReadSema
			WriteSemaID: aWriteSema].
	^socketOop