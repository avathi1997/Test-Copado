public class OppErrorDisplayHandler {
    public static void handleBeforeInsertAndUpdate(List<Sample_Object__c> customObjects) {
        set<Id> oppId = new set<Id>();
        // Map<Id, Opportunity> oppMap = new Map<Id, Opportunity>();
        List<Opportunity> oppList = new List<Opportunity>();
        for(Sample_Object__c obj :customObjects){
            oppId.add(obj.Opportunity__c);
            system.debug('oppId-->'+oppId);
        }
        Map<Id, Opportunity> oppMap = new Map<Id, Opportunity>([SELECT Id, Opp_Checkbox__c, (SELECT Id, OppLine_CheckBox__c FROM OpportunityLineItems) FROM Opportunity WHERE Id IN :oppId]);
        
        for (Sample_Object__c objRec : customObjects) {
             system.debug('oppMap-->'+oppMap);
            if (oppMap.containsKey(objRec.Opportunity__c)) {
                Opportunity opp = oppMap.get(objRec.Opportunity__c);
                Boolean isError = false;
                Boolean isAllLineItemsChecked = true;
                 System.debug('Opportunity Id: ' + opp.Id);
                 System.debug('Opportunity Checkbox: ' + opp.Opp_Checkbox__c);
                 system.debug('oppMap-->'+oppMap);
                if (opp.Opp_Checkbox__c) {
                    for (OpportunityLineItem oli : opp.OpportunityLineItems) {
                        if (!oli.OppLine_CheckBox__c) {
                            isAllLineItemsChecked = false;
                        }
                    }
                    
                  objRec.Error_Display__c = isAllLineItemsChecked;

                   if (isAllLineItemsChecked) {
                            objRec.Error_Display__c = true;
                        } else {
                            objRec.Error_Display__c = false;
                            objRec.addError('At least one Opportunity Line Item checkbox is unchecked.');
                        }
                    } else {
                        objRec.addError('Opportunity checkbox is unchecked.');
                    }
            }
        }
    }
}