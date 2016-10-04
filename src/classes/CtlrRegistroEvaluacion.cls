public without sharing class CtlrRegistroEvaluacion {
    public Contact contacto {get;set;}
    public PRIMERA_REVISI_N__c primeraEv {get;set;}
        
    public String idCto {get;set;}
    public Boolean continua {get;set;}
    public Boolean verDuplicado {get;set;}
        
    public CtlrRegistroEvaluacion () {
        idCto = ApexPages.currentPage().getParameters().get('id');
        primeraEv = new PRIMERA_REVISI_N__c();
        verDuplicado = false;
        
        for(PRIMERA_REVISI_N__c priEv : [Select id, Name, Nombre_del_Candidato__c, ValidaRegistro__c
                                            , Nombre_del_grupo_u_organizaci_n_1__c, Tipo_de_grupo_u_organizaci_n_1__c
                                            , CuentanosSobreGrupouOrganizacion1__c, Actividad_como_lider_de_un_grupo_1__c
                                            , Desempe_o_como_l_der_1__c, Justifica_tu_respuesta_1__c
                                            , ComoInvolucrasteOrganizacion1__c, Nombre_del_grupo_u_organizaci_n_2__c
                                            , Tipo_de_grupo_u_organizaci_n_2__c, CuentanosSobreGrupouOrganizacion2__c
                                            , Actividad_como_lider_de_un_grupo_2__c, Desempe_o_como_l_der_2__c
                                            , Justifica_tu_respuesta_2__c, ComoInvolucrasteOrganizacion2__c
                                            , Describe_un_reto_1__c, Describe_un_reto_2__c
                                            , Qu_hiciste_para_superar_la_situaci_n_1__c, Qu_hiciste_para_superar_la_situaci_n_2__c
                                            , SuperasteReto__c, Superaste_reto_2__c
                                            , QueHicisteSuperarReto__c, QueHicisteSuperarReto2__c
                                            , QueImpidioSuperarasReto__c, QueImpidioSuperarasReto2__c
                                            , QueimpidioSuperarRetoTotalidad__c, QueimpidioSuperarRetoTotalidad2__c
                                            , Reacci_n_al_Reto_1__c, Reacci_n_al_Reto_2__c
                                            , Resultados_de_tus_decisiones_1__c, Resultados_de_tus_decisiones_2__c
                                            , Redaccion__c, Servicio_como_voluntario__c
                                            , InvolucrasteInstitucionVoluntariado__c, TiempoInvolucradoActividad__c
                                            , problemas_del_sistema_educativo_Mexicano__c, AccionesONG__c
                                            , Razones_para_querer_formar_parte_de_ExM__c, HeLeidoDetenidamenteQueTrata__c
                                            , EstoyConscienteAceptacion__c, DeSerAceptadoPosibleDebaMudarme__c
                                            , ConfirmacionDeInformacion__c, NombreManeraFirmaElectronica__c
                                            , PeriodoActividad__c
                                        from PRIMERA_REVISI_N__c where Nombre_del_Candidato__c =: idCto]) {
            priEv.HeLeidoDetenidamenteQueTrata__c = false;
            priEv.EstoyConscienteAceptacion__c = false;
            priEv.DeSerAceptadoPosibleDebaMudarme__c = false;
            priEv.ConfirmacionDeInformacion__c = false;
            priEv.NombreManeraFirmaElectronica__c = null;
            priEv.Servicio_como_voluntario__c = '';
            primeraEv = priEv;
            if(primeraEv.ValidaRegistro__c) {
                verDuplicado = true;
            }
        }
        
        contacto = new Contact();
    }
    
    public PageReference guardaContacto() {
        System.debug(':::' + primeraEv.Id);
        String correcto = '';
        String sec1 = '';
        String sec2 = '';
        String sec3 = '';
        String sec4 = '';
        
        if(primeraEv.Nombre_del_grupo_u_organizaci_n_1__c == null)
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Nombre de Grupo u Organización 1.';
        if(primeraEv.Tipo_de_grupo_u_organizaci_n_1__c == null)
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Tipo de Grupo u Organización 1.';
        if(primeraEv.CuentanosSobreGrupouOrganizacion1__c == null)
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar acerca del Grupo u Organización 1.';
        if(primeraEv.Actividad_como_lider_de_un_grupo_1__c == null)
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Rol en el Grupo u Organización 1.';
        if(primeraEv.Desempe_o_como_l_der_1__c == null)
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar desempeño como líder en Grupo u Organización 1.';
        if(primeraEv.Justifica_tu_respuesta_1__c == null)
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar justificación de resultados en Grupo u Organización 1.';
        if(primeraEv.ComoInvolucrasteOrganizacion1__c == null)
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar como te Involucraste en Grupo u Organización 1.';
        if(primeraEv.Nombre_del_grupo_u_organizaci_n_2__c == null)
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Nombre de Grupo u Organización 2.';
        if(primeraEv.Tipo_de_grupo_u_organizaci_n_2__c == null)
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Tipo de Grupo u Organización 2.';
        if(primeraEv.CuentanosSobreGrupouOrganizacion2__c == null)
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar acerca del Grupo u Organización 2.';
        if(primeraEv.Actividad_como_lider_de_un_grupo_2__c == null)
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Rol en el Grupo u Organización 2.';
        if(primeraEv.Desempe_o_como_l_der_2__c == null)
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar desempeño como líder en Grupo u Organización 2.';
        if(primeraEv.Justifica_tu_respuesta_2__c == null)
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar justificación de resultados en Grupo u Organización 2.';
        if(primeraEv.ComoInvolucrasteOrganizacion2__c == null)
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar como te Involucraste en Grupo u Organización 2.';
        
        if(primeraEv.Describe_un_reto_1__c == null)
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar algún reto que hayas tenido que enfrentar 1.';
        if(primeraEv.Describe_un_reto_2__c == null)
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar algún reto que hayas tenido que enfrentar 2.';
        //if(primeraEv.Qu_hiciste_para_superar_la_situaci_n_1__c == null)
            //correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar que paso por tu Mente en Reto 1.';
        //if(primeraEv.Qu_hiciste_para_superar_la_situaci_n_2__c == null)
            //correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar que paso por tu Mente en Reto 2.';
        if(primeraEv.SuperasteReto__c == null)
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Superaste Reto 1.';
        if(primeraEv.Superaste_reto_2__c == null)
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Superaste Reto 2.';
        
        if(primeraEv.QueHicisteSuperarReto__c == null && primeraEv.SuperasteReto__c == 'Si')
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar que hiciste para superar Reto 1.';
        if(primeraEv.QueHicisteSuperarReto2__c == null && primeraEv.Superaste_reto_2__c == 'Si')
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar que hiciste para superar Reto 2.';
        if(primeraEv.QueImpidioSuperarasReto__c == null && primeraEv.SuperasteReto__c == 'No')
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar que impidio superar Reto 1.';
        if(primeraEv.QueImpidioSuperarasReto2__c == null && primeraEv.Superaste_reto_2__c == 'No')
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar que impidio superar Reto 2.';
        if(primeraEv.QueimpidioSuperarRetoTotalidad__c == null && primeraEv.SuperasteReto__c == 'Parcialmente')
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar que impidio superar Reto totalmente 1.';
        if(primeraEv.QueimpidioSuperarRetoTotalidad2__c == null && primeraEv.Superaste_reto_2__c == 'Parcialmente')
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar que impidio superar Reto totalmente 2.';
        //if(primeraEv.Reacci_n_al_Reto_1__c == null)
            //correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Resultados de la desición tomada 1.';
        //if(primeraEv.Reacci_n_al_Reto_2__c == null)
            //correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Resultados de la desición tomada 2.';
        if(primeraEv.Resultados_de_tus_decisiones_1__c == null)
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar cuales fuerón los resultados de tus acciones 1.';
        if(primeraEv.Resultados_de_tus_decisiones_2__c == null)
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar cuales fuerón los resultados de tus acciones 2.';
                
        if(correcto != '') {
            sec1 = '<br/>&nbsp;&nbsp;Seccion Actividades Extracurriculares:' + correcto;
            correcto = '';
        }
        
        if(primeraEv.Redaccion__c == null || primeraEv.Redaccion__c.trim() == '')
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Experiencia en Proyectos.';
        
        if(correcto != '') {
            sec2 = '<br/>&nbsp;&nbsp;Seccion Experiencia trabajando en Proyectos:' + correcto;
            correcto = '';
        }
        
        if(primeraEv.Servicio_como_voluntario__c == null)
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar si has realizado Servicio Voluntario.';
        if(primeraEv.InvolucrasteInstitucionVoluntariado__c == null && primeraEv.Servicio_como_voluntario__c == 'Si')
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar como te involucraste con la Institución de Voluntariado.';
        if(primeraEv.Servicio_como_voluntario__c == 'Si' && primeraEv.TiempoInvolucradoActividad__c == null)
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar el Tiempo involucrado en la actividad.';
        if(primeraEv.problemas_del_sistema_educativo_Mexicano__c == null)
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Problema principal de México.';
        if(primeraEv.AccionesONG__c == null)
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar contribución de la ONG a la mejora del País.';
        if(primeraEv.Razones_para_querer_formar_parte_de_ExM__c == null)
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar porque quieres ser parte de EPM.';
        
        if(correcto != '') {
            sec2 = '<br/>&nbsp;&nbsp;Seccion Tu pefil:' + correcto;
            correcto = '';
        }
        
        if(!primeraEv.HeLeidoDetenidamenteQueTrata__c)
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes Aceptar que has leído de que Trata el Programa.';
        if(!primeraEv.EstoyConscienteAceptacion__c)
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes Aceptar estar conciente de tu Labor una vez Aceptado por el Programa.';
        if(!primeraEv.DeSerAceptadoPosibleDebaMudarme__c)
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes Aceptar es posible cambiar de residencia una vez Aceptado por el Programa.';
        if(!primeraEv.ConfirmacionDeInformacion__c)
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes Aceptar la Información proporcionada.';
        if(primeraEv.NombreManeraFirmaElectronica__c == '' || primeraEv.NombreManeraFirmaElectronica__c == null)
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes Ingresar tu Nombre a manera de Firma Electrónica.';
        
        if(correcto != '') {
            sec3 = '<br/>&nbsp;&nbsp;Seccion Confirmación de información:' + correcto;
            correcto = '';
        }
        
        correcto = sec1 + sec2 + sec3;
                        
        if(correcto == '') {
            System.debug(':::verDuplicado : ' + verDuplicado);
            
            
            if(!verDuplicado) {
                primeraEv.ValidaRegistro__c = true;
                update primeraEv;
                
                return Page.PEnviada;
            } else {
                return Page.PEnviada;
            }
                
        } else {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Revisa los mensajes de error:' + correcto));
                return null;
        }
    }      
}