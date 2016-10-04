public without sharing class CtrlTerceraEvaluacion {
	public Contact contacto {get;set;}
	public String nombre {get;set;}
	public String asistir {get;set;}
	
	public Boolean continuar {get;set;}
	
	public CtrlTerceraEvaluacion() {
		contacto = new Contact();
		continuar = false;
		asistir = '';
		nombre = '';
		
		String idCto = ApexPages.currentPage().getParameters().get('id');
		System.debug(':::idCto : ' + idCto);
		for(Contact c : [Select Id, Name, Evaluado__c, NoAccesos__c, A__c from Contact where Id =: idCto]) {
			contacto = c;
		}
		
		if(contacto.Id != null) {
			continuar = true;
		}
	}
	
	public Pagereference guardaAsistencia() {
		if(contacto.Id != null) {
			if(nombre == '') {
				ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Debes ingresar Nombre!'));
			}
			if(asistir == '' || asistir == null) {
				ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Debes confirmar o no tu asistencia!'));
			}
			
			if(nombre != '' && asistir != '') {
				contacto.A__c = asistir;
				
				update contacto;
				return Page.TEEnviada;
			} else {
				return null;
			}
		} else {
			return null;
		}
	}
}