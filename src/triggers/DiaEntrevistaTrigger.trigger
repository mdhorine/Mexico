trigger DiaEntrevistaTrigger on Dia_de_Entrevista__c (after insert, after update) {
	if(Trigger.isAfter) {
		for(Dia_de_Entrevista__c dEnt : Trigger.new) {
			Contact contacto = new Contact();
			if(dEnt.Nombre__c != null) {
				contacto = [Select Id, Name 
							from Contact where Id =: dEnt.Nombre__c limit 1];
			}
			
			if(contacto.Name != null) {
				contacto.LiderazgoDiaEntrevista__c = dEnt.Calificacion_finla_liderazgo__c;
				contacto.PerseveranciaFinalDiaEntrevista__c = dEnt.Calificacion_final_perseverancia__c;
				contacto.HabilidadesOrganizacionalesDiaEntrevista__c = dEnt.Habilidades_organizacionales_final__c;
				contacto.InfluenciaMotivacionDiaEntrevista__c = dEnt.Influencia_y_motivaci_n_final__c;
				contacto.PerfilExMDiaEntrevista__c = dEnt.Perfil_ExM_final__c;
				contacto.FirmezaCaracterDiaEntrevista__c = dEnt.calificacion_final_firmeza_de_caracter__c;
				contacto.NoAptoEnsenanzaIngles__c = dEnt.NoAptoEnsenanzaIngles__c;
				contacto.Computadora__c = dEnt.Computadora__c;				
				update contacto;
			}
		}
	}
}