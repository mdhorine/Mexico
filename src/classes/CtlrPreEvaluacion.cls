public with sharing class CtlrPreEvaluacion {
    public PRIMERA_REVISI_N__c pRevision{get;set;}
    
    public CtlrPreEvaluacion() {
        pRevision = new PRIMERA_REVISI_N__c();
    }
    
    public Pagereference validaFecha() {
        Date fecha = Date.newInstance(2016, 06, 30);
        
        if(pRevision.est_s_titulado__c == null || pRevision.est_s_titulado__c == '') {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Antes de Continuar, debes contestar si estas Titulado.'));
            return null;
        }
        
        if(pRevision.est_s_titulado__c != 'Si' && pRevision.Fecha_de_egreso_o_titulaci_n__c == null) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Ingresa la fecha aproximada de Titulación.'));
            return null;
        }
        
        if(pRevision.est_s_titulado__c != 'Si' && pRevision.Fecha_de_egreso_o_titulaci_n__c > fecha) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'No podemos aceptar tu registro, excedes la fecha límite para comprobar tu titulación.'
                                    + 'Te esperamos en la siguiente Convocatoria.'));
            return null;
        } else {
            String param = '';
            
            if(pRevision.est_s_titulado__c == 'Si') {
                param = '/apex/PrimeraEvaluacion';
            } else {
                param = '/apex/PrimeraEvaluacion?tit=' + pRevision.est_s_titulado__c 
                        + '&yTit=' + pRevision.Fecha_de_egreso_o_titulaci_n__c.year()
                        + '&mTit=' + pRevision.Fecha_de_egreso_o_titulaci_n__c.month() 
                        + '&dTit=' + pRevision.Fecha_de_egreso_o_titulaci_n__c.day();
            }
            
            Pagereference pRef = new Pagereference(param);
            pRef.setRedirect(true);
            return pRef;
        }
    }
}