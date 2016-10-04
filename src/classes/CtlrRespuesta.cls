public without sharing class CtlrRespuesta {
    public Contact contacto {get;set;}
    public String valor1 {get;set;}
    //public String valor2 {get;set;}
    public String valor3 {get;set;}
    
    public CtlrRespuesta() {
        String idCto = ApexPages.currentPage().getParameters().get('Id');
        valor1 = '';
        valor1 = '';
        valor1 = '';
        //contacto = new Contact();
        for(Contact c : [Select Id, Name, LlamadaOpcional__c, FechaCentroEvaluacion__c, LugarCentroEvaluacion__c from Contact where Id =: idCto]) {
            contacto = c;
        }
    }
    
    public PageReference guardaContacto() {
        if(valor3 == null) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Debes contestar todas las preguntas.'));
            return null;
        } else {
            System.debug(':::' + valor1 + ' ::: ' + valor3);
            System.debug(':::' + contacto );
            //contacto.LlamadaOpcional__c = valor1;
            //contacto.FechaCentroEvaluacion__c = valor2;
            contacto.LugarCentroEvaluacion__c = valor3;
            upsert contacto;
            return Page.PEEnviadaRespuesta;
        }
    }
}