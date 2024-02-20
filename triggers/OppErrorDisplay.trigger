trigger OppErrorDisplay on Sample_Object__c (before insert,before update) {
 if(trigger.isinsert){
        OppErrorDisplayHandler.handleBeforeInsertAndUpdate(trigger.new);
    }
     if(trigger.isupdate){
      OppErrorDisplayHandler.handleBeforeInsertAndUpdate(trigger.new);
    }
}