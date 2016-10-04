trigger PruebaPensamientoCriticoTrigger on Prueba_de_pensamiento_cr_tico__c (after insert, after update) {
	if(Trigger.isAfter) {
		for(Prueba_de_pensamiento_cr_tico__c pPens : Trigger.new) {
			Contact contacto = new Contact();
			if(pPens.Nombre_del_Candidato__c != null) {
				contacto = [Select Id, Name 
							from Contact where Id =: pPens.Nombre_del_candidato__c limit 1];
			}
			
			if(contacto.Name != null) {
				contacto.TipoPensamientoCritico__c = pPens.Tipo_de_pensamiento_cr_tico__c;
				contacto.TiposConstruccionRelaciones__c = pPens.Tipos_de_construcci_n_de_relaciones__c;
				contacto.RECOMENDACIONSEGUNDAEVALUACION__c = pPens.RECOMENDACIONMODELOSEGUNDAEVALUACION__c;
				contacto.PasaTerceraEtapa__c = pPens.PasaTerceraEtapa__c;				
				update contacto;
			}
		}
	}
}