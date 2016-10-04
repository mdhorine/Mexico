public without sharing class CtrlBienvenidaSE {
        public Contact contacto {get;set;}
        public Boolean noExiste {get;set;}
        public String nombre {get;set;}
        @TestVisible private String idCto {get;set;}    
        
        public CtrlBienvenidaSE() {
                contacto = new Contact();
                noExiste = false;
                idCto = ApexPages.currentPage().getParameters().get('Id');
                
                for(Contact c : [Select Id, Name, Evaluado__c, NoAccesos__c from Contact where Id =: idCto]) {
                        contacto = c;
                }
                
                system.debug('::: contacto.Id : ' + contacto.Id + ' ::: ' + contacto.Evaluado__c);
                if(contacto.Id != null && !contacto.Evaluado__c) {
                        nombre = contacto.Name;
                } else {
                        noExiste = true;
                }
        }
        
        public Pagereference enviarSE() {
                if(contacto.Id != null && !contacto.Evaluado__c) {
                        contacto.Evaluado__c = true;
                        
                        update contacto;
                        
                        PageReference pageRef = new PageReference('/apex/SegundaEvaluacion?id=' + idCto);
                        return pageRef;
                } else {
                        return Page.SEEnviada;
                }
        }
}