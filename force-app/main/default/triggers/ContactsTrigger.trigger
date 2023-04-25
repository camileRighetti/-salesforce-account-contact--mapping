trigger ContactsTrigger on Contact(after insert) {
    ContactTriggerHandler.afterInsert(Trigger.new);
}
