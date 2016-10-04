trigger PrimeraRevisionTrigger on PRIMERA_REVISI_N__c (after insert, after update) {
    if(Trigger.isAfter) {
        for(PRIMERA_REVISI_N__c pRev : Trigger.new) {
            Contact contacto = new Contact();
            if(pRev.Nombre_del_Candidato__c != null) {
                contacto = [Select Id, Name 
                            from Contact where Id =: pRev.Nombre_del_Candidato__c limit 1];
            }
            
            if(contacto.Name != null) {
                contacto.LiderazgoPrimeraRevision__c = pRev.Liderazgo__c;
                contacto.PerseveranciaPrimeraRevision__c = pRev.Perseverancia__c;
                contacto.FirmezaCaracterPrimeraRevision__c = pRev.Firmeza_de_car_cter__c;
                contacto.PerfilExMPrimeraRevision__c = pRev.Perfil_ExM__c;
                contacto.QuePuedesEnsenar__c = pRev.Qu_puedes_ense_ar__c;
                contacto.RECOMENDACIONPRIMERAEVALUACION__c = pRev.RECOMENDACIONMODELOGRAFICA__c;
                contacto.PuntajeCompetenciasPrimeraEvaluacion__c = pRev.PUNTAJE_DE_COMPETENCIAS__c;
                contacto.OpinionEvaluadorPrimeraEvaluacion__c = pRev.OPINI_N_EVALUADOR__c;
                contacto.OrigenEstudios__c = pRev.OrigenEstudios__c;
                update contacto;  
            }
        }
    }
}