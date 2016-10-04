public without sharing class CtrlBienvenida2 {
        public PRIMERA_REVISI_N__c primera {get;set;}
        public String idCto {get;set;}
        public Boolean validado {get;set;}
        public CtrlBienvenida2() {
                idCto = ApexPages.currentPage().getParameters().get('Id');
                primera = new PRIMERA_REVISI_N__c();
                validado = false;
                
                for(PRIMERA_REVISI_N__c pRev : [Select id, Name, Nombre_del_Candidato__c, ValidaRegistro__c 
                                                                                from PRIMERA_REVISI_N__c where Nombre_del_Candidato__c =: idCto]) {
                        if(pRev.ValidaRegistro__c) {
                                validado = true;
                        }
                }
        }
        
        public Pagereference continuar() {
                if(!primera.ValidaRegistro__c) {
                        PageReference pageRef = new PageReference('/apex/RegistroEvaluacion?id=' + idCto);
                        return pageRef;
                } else {
                        return Page.PEEnviada;
                }
        }
}