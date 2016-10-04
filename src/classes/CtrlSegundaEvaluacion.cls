public without sharing class CtrlSegundaEvaluacion {
    public Prueba_de_pensamiento_cr_tico__c segEv {get;set;}
    public Contact contacto {get;set;}
        
    public Boolean enviado {get;set;}
    public Boolean tiempo {get;set;}
    public String nombre {get;set;}
    public Integer contador {get;set;}
    
    public CtrlSegundaEvaluacion() {
        segEv = new Prueba_de_pensamiento_cr_tico__c();
        contacto = new Contact();
        String idCto = ApexPages.currentPage().getParameters().get('Id');
        
        tiempo = false;
        enviado = false;
        contador = 0;
        
        for(Contact c : [Select Id, Name, Evaluado__c, NoAccesos__c from Contact where Id =: idCto]) {
            contacto = c;
        }
        
        if(contacto.Id != null) {
            nombre = contacto.Name;
        }
        
        System.debug(':::contacto.NoAccesos__c : ' + contacto.NoAccesos__c);
        if(contacto.NoAccesos__c != null) {
            enviado = true;
        }
        
        for(Prueba_de_pensamiento_cr_tico__c sE : [Select id, Name, Nombre_del_candidato__c
                                                        , X1_preguntas_para_el_profesor_Ugarte__c
                                                        , X2_El_aumento_de_participaci_n_en_clases__c
                                                        , X3_Por_qu_sacan_mejores_notas__c
                                                        , X4_Las_conclusiones_de_la_tabla__c
                                                        , X5_La_tabla_no_confirma__c
                                                        , X6_Director_del_colegio_debe_considerar__c
                                                        , X7_Alumnos_que_aumentaron_100_puntos__c
                                                        , X8_Estrategia_para_eliminar__c
                                                        , X9_Tutor_a_de_Felipe_durante_el_almuerzo__c
                                                        , X10_Planifique_su_cambio_de_sistema__c
                                                        , X11_No_puntuaci_n_de_F_lix_a_cambiar__c
                                                        , X12_Tabla_D_es_la_m_s_l_gica__c
                                                        , X13_Cambiar_la_asistencia_de_la_Colegio1__c
                                                        , X14_Cambiar_la_asistencia_de_la_Colegio3__c
                                                        , X15_escuelas_con_buena_asistencia__c                                                                                                           
                                                        , ComoconsiderasposturamaestraJulia__c
                                                        , Comoconsiderasposturadeldirector__c
                                                        , Porqueenfadodirector__c
                                                        , PorquereaccionmaestraJulia__c
                                                        , Comoabordariasdirectorestrategias__c
                                                        , ComoabordarasJuliaestrategias__c
                                                          
                                                    from Prueba_de_pensamiento_cr_tico__c
                                                    where Nombre_del_candidato__c =: idCto]) {
            segEv = sE;
        }
    }
    
    public PageReference guardaInfo() {
        if(segEv.Id != null) {
            Contact con = [Select Id, Name, Evaluado__c, NoAccesos__c from Contact where Id =: contacto.Id];
            
            if(contacto.NoAccesos__c != null) {
                return Page.SEEnviada;
            } else {
                contacto.NoAccesos__c = 5;
                contacto.Evaluado__c = true;
                update contacto;
                
                update segEv;
                return Page.SEEnviada;
            }
        } else {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Error al guardar los datos. Contacte al equipo de Enseña por Mexico'));
            return null;
        }
    }
    
    public Pagereference tiempoAgotado() {
        if(segEv.Id != null) {
            contacto.NoAccesos__c = 5;
            update contacto;
            update segEv;
        }
        
        tiempo = true;
        System.debug(':::tiempo : ' + tiempo);
        return null;
    }
}