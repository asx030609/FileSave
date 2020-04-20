update DMT_TAGU SET ADDRESSU='DB521.DINT36' WHERE TAG_CODEU='ScanCodeInboundSign02';
update DMT_TAGU SET ADDRESSU='DB521.DINT20' WHERE TAG_CODEU='ScanCodeInbound02';
update DMT_TAGU SET ADDRESSU='DB522.DINT28' WHERE TAG_CODEU='ScanCodeInboundFeedback02';
update DMT_TAGU SET ADDRESSU='DB521.DINT56' WHERE TAG_CODEU='ScanCodeInboundSign03';
update DMT_TAGU SET ADDRESSU='DB521.DINT40' WHERE TAG_CODEU='ScanCodeInbound03';
update DMT_TAGU SET ADDRESSU='DB522.DINT56' WHERE TAG_CODEU='ScanCodeInboundFeedback03';
----TaskArrive => TaskArriveRequest
update DMT_TAGU SET TAG_CODEU='TaskArriveRequestSign01' where TAG_CODEU='TaskArriveSign01';
update DMT_TAGU SET TAG_CODEU='TaskArriveRequestSign02' where TAG_CODEU='TaskArriveSign02';
update DMT_TAGU SET TAG_CODEU='TaskArriveRequest01' where TAG_CODEU='TaskArrive01';
update DMT_TAGU SET TAG_CODEU='TaskArriveRequest02' where TAG_CODEU='TaskArrive02';
update DMT_TAGU SET ADDRESSU='DB531.DINT36' WHERE TAG_CODEU='TaskArriveRequestSign02';
update DMT_TAGU SET ADDRESSU='DB531.DINT20' WHERE TAG_CODEU='TaskArriveRequest02';
update DMT_TAGU SET ADDRESSU='DB532.DINT20' WHERE TAG_CODEU='TaskArriveFeedback02';
commit;