public with sharing class CtrlPrimeraEvaluacionIngles {
        public Contact contacto {get;set;}
        public CodigoPostal__c codPostal {get;set;}
        public PRIMERA_REVISI_N__c primeraEv {get;set;}
        public Dia_de_Entrevista__c terceraEv {get;set;}
        public Prueba_de_pensamiento_cr_tico__c segundaEv {get;set;}
        
        public List<CodigoPostal__c> lCP {get;set;}
        public List<String> lCorreos {get;set;}
        
        public Boolean continua {get;set;}
        public Boolean verIngles {get;set;}
        
        public String cp {get;set;}
        public String idCPSel {get;set;}
        public String idUnivSel {get;set;}
        public String textCorreo {get;set;}
        
        public CtrlPrimeraEvaluacionIngles () {
                segundaEv = new Prueba_de_pensamiento_cr_tico__c();
                terceraEv = new Dia_de_Entrevista__c();
                primeraEv = new PRIMERA_REVISI_N__c();
                codPostal =  new CodigoPostal__c();
                contacto = new Contact();
                
                lCP = new List<CodigoPostal__c>();
                lCorreos = new List<String>();
                
                verIngles = false;
                continua = false;
                
                textCorreo = '';
                idUnivSel = 'none';
                idCPSel = '';
                cp = '';
                
                for(Contact c : [Select Id, Correo_electr_nico__c from Contact]) {
                	lCorreos.add(c.Correo_electr_nico__c);
                }
        }
        
        public void validaEncabezado() {
                continua = true;
        }
        
        public List<SelectOption> getUniv () {
                List<SelectOption> options = new List<SelectOption>();
                
                if(primeraEv.EstadoUniversidadIngles__c != '' || primeraEv.EstadoUniversidadIngles__c != null) {
                        options.add(new SelectOption('','Select University...'));
                        for(Universidad__c grupoIterado : [Select Id, NombreUniversidad__c From Universidad__c 
                                                                                                where EstadoUniversidad__c =: primeraEv.EstadoUniversidadIngles__c order by NombreUniversidad__c asc]) {
                                options.add(new SelectOption(grupoIterado.Id, grupoIterado.NombreUniversidad__c));
                        }
                        options.add(new SelectOption('otro','OTHER'));
                }
                
                return options;
        }
        
        public PageReference guardaContacto() {
                String correcto = '';
                String sec1 = '';
                String sec2 = '';
                String sec3 = '';
                String sec4 = '';
                String sec5 = '';
                String sec6 = '';
                String sec7 = '';
                String sec8 = '';
                String sec9 = '';
                String sec10 = '';
                String sec11 = '';
                
                if(contacto.Birthdate == null)
                        correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Date of birth. Value is required.';
                if(contacto.Birthdate != null) {                
                        if(contacto.Birthdate.year() > 1995 || contacto.Birthdate.year() < 1984)
                                correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Valid Date of birth.';
                }
                if(contacto.NacionalidadIngles__c == '' || contacto.NacionalidadIngles__c == null)
                        correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Nationality. Value is required.';
                if(contacto.GeneroIngles__c == null || contacto.GeneroIngles__c == '')
                        correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Gender. Value is required.';
                if(contacto.Correo_electr_nico__c == null || contacto.Correo_electr_nico__c.trim() == '')
                        correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;E-mail address. Value is required.';
                if(textCorreo == null || textCorreo.trim() == '' || textCorreo != contacto.Correo_electr_nico__c)
                        correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Repeat E-mail address. Value is required.';
                if(contacto.Calle__c == null || contacto.Calle__c.trim() == '')
                        correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Street. Value is required.';
                if(contacto.NumeroExterior__c == null || contacto.NumeroExterior__c.trim() == '')
                        correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Number. Value is required.';
                if(contacto.CodigoPostalTxt__c == null || contacto.CodigoPostalTxt__c.trim() == '')
                        correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;ZIP Code. Value is required.';
                //if(contacto.EstadoCPEUA__c == null || contacto.EstadoCPEUA__c.trim() == '')
                if(contacto.EstadoIngles__c == null || contacto.EstadoIngles__c == '')
                        correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;State. Value is required.';
                if(contacto.CiudadCP__c == null || contacto.CiudadCP__c.trim() == '')
                        correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;City. Value is required.';
                if(contacto.Tel_fono_de_casa__c == null || contacto.Tel_fono_de_casa__c.trim() == '')
                        correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Home phone number. Value is required.';
                if(contacto.Tel_fono_celular__c == null || contacto.Tel_fono_celular__c.trim() == '')
                        correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Mobile number. Value is required.';
                if(contacto.Cuenta_de_Skype__c == null || contacto.Cuenta_de_Skype__c.trim() == '')
                        correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Skype account. Value is required.';
                if(contacto.HablasAlgunaLenguaIndigenaIngles__c == '' || contacto.HablasAlgunaLenguaIndigenaIngles__c == null)
                        correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Do you speak a Mexican indigenous language?. Value is required.';
                if(contacto.HablasAlgunaLenguaIndigenaIngles__c == 'Yes') {
                        if(contacto.GradoDominioIngles__c == null || contacto.GradoDominioIngles__c == '')
                                correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Degree of mastery. Value is required.';
                }
                if(correcto != '') {
                        sec1 = '<br/>&nbsp;&nbsp;Personal information:' + correcto;
                        correcto = '';
                }
                
                if(primeraEv.TituloUniversitarioIngles__c == null || primeraEv.TituloUniversitarioIngles__c == '')
                        correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;College degree. Value is required.';
                if(primeraEv.Carrera__c == null || primeraEv.Carrera__c.trim() == '')
                        correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Major. Value is required.';
                if(primeraEv.EstasGraduadoIngles__c == null || primeraEv.EstasGraduadoIngles__c == '')
                        correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Are you a graduate?. Value is required.';
                if(primeraEv.Fecha_de_egreso_o_titulaci_n__c == null && primeraEv.EstasGraduadoIngles__c != 'Yes')
                        correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Expected graduation date. Value is required.';
                //if(primeraEv.EstadoUniversidadIngles__c == null || primeraEv.EstadoUniversidadIngles__c == '')
                if(primeraEv.EstadoIngles__c == null || primeraEv.EstadoIngles__c == '')
                        correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;State where your university is located. Value is required.';
                //if(idUnivSel == 'none' || idUnivSel == null)
                if(primeraEv.UniversidadIngles__c == null || primeraEv.UniversidadIngles__c.trim() == '')
                        correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;University. Value is required.';
                //if((primeraEv.Otra_Universidad_1__c == null || primeraEv.Otra_Universidad_1__c == null) && idUnivSel != 'none' && idUnivSel == 'otro')
                  //      correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;University. Value is required.';
                if(primeraEv.GPA__c == '' || primeraEv.GPA__c == null)
                        correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;GPA. Value is required.';
                
                if(primeraEv.EstudiosPosgradoIngles__c == null || primeraEv.EstudiosPosgradoIngles__c == '')
                        correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Graduate studies. Value is required.';
                if(primeraEv.EstudiosPosgradoIngles__c == 'Yes') {
                        if(primeraEv.NivelPosgradoIngles__c == null || primeraEv.NivelPosgradoIngles__c == '')
                                correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Level Obtained. Value is required.';
                        if(primeraEv.NombredelPosgrado__c == null || primeraEv.NombredelPosgrado__c.trim() == '')
                                correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Name of the degree. Value is required.';
                        if(primeraEv.EstadoInglesPosgrado__c == null || primeraEv.EstadoInglesPosgrado__c.trim() == '')
                                correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;State where your university is located. Value is required.';
                        if(primeraEv.NombrePostgrado__c == null || primeraEv.NombrePostgrado__c.trim() == '')
                                correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;University. Value is required.';
                }
                
                if(correcto != '') {
                        sec2 = '<br/>&nbsp;&nbsp;Academic information:' + correcto;
                        correcto = '';
                }
                                
                if(primeraEv.AreaPodriasEnseniarIngles__c == null)
                        correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Areas of knowledge you could teach. Value is required.';
                                
                if(correcto != '') {
                        sec3 = '<br/>&nbsp;&nbsp;Teaching:' + correcto;
                        correcto = '';
                }
                
                if(primeraEv.Nombre_del_grupo_u_organizaci_n_1__c == null || primeraEv.Nombre_del_grupo_u_organizaci_n_1__c.trim() == '')
                        correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Name of group or organization 1. Value is required.';
                if(primeraEv.TipoGrupoOrganizacion1Ingles__c == null || primeraEv.TipoGrupoOrganizacion1Ingles__c == '')
                        correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Type of group or organization 1. Value is required.';
                if(primeraEv.CuentanosSobreGrupouOrganizacion1__c == null || primeraEv.CuentanosSobreGrupouOrganizacion1__c.trim() == '')
                        correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Tell us more about this group or organization 1. Value is required.';
                if(primeraEv.Actividad_como_lider_de_un_grupo_1__c == null || primeraEv.Actividad_como_lider_de_un_grupo_1__c.trim() == '')
                        correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;What was your role? 1. Value is required.';
                if(primeraEv.DesempenioLiderIngles__c == null || primeraEv.DesempenioLiderIngles__c == '')
                        correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;How was your performance as a leader? 1. Value is required.';
                if(primeraEv.Justifica_tu_respuesta_1__c == null || primeraEv.Justifica_tu_respuesta_1__c.trim() == '')
                        correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Justify your answer based on observable results 1. Value is required.';
                if(primeraEv.ComoInvolucrasteOrganizacion1Ingles__c == null || primeraEv.ComoInvolucrasteOrganizacion1Ingles__c == '')
                        correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;How did you get involved in that group? 1. Value is required.';
                if(primeraEv.Nombre_del_grupo_u_organizaci_n_2__c == null || primeraEv.Nombre_del_grupo_u_organizaci_n_2__c.trim() == '')
                        correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Name of group or organization 2. Value is required.';
                if(primeraEv.TipoGrupoOrganizacion2Ingles__c == null || primeraEv.TipoGrupoOrganizacion2Ingles__c == '')
                        correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Type of group or organization 2. Value is required.';
                if(primeraEv.CuentanosSobreGrupouOrganizacion2__c == null || primeraEv.CuentanosSobreGrupouOrganizacion2__c.trim() == '')
                        correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Tell us more about this group or organization 2. Value is required.';
                if(primeraEv.Actividad_como_lider_de_un_grupo_2__c == null || primeraEv.Actividad_como_lider_de_un_grupo_2__c.trim() == '')
                        correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;What was your role? 2. Value is required.';
                if(primeraEv.DesempenioLider2Ingles__c == null || primeraEv.DesempenioLider2Ingles__c == '')
                        correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;How was your performance as a leader? 2. Value is required.';
                if(primeraEv.Justifica_tu_respuesta_2__c == null || primeraEv.Justifica_tu_respuesta_2__c.trim() == '')
                        correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Justify your answer based on observable results 2. Value is required.';
                if(primeraEv.InvolucrasteOrganizacion2Ingles__c == null || primeraEv.InvolucrasteOrganizacion2Ingles__c == '')
                        correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;How did you get involved in that group? 2. Value is required.';
                
                if(correcto != '') {
                        sec4 = '<br/>&nbsp;&nbsp;Extracurricular activities:' + correcto;
                        correcto = '';
                }
                
                if(primeraEv.Describe_un_reto_1__c == null || primeraEv.Describe_un_reto_1__c.trim() == '')
                        correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;What is the greatest challenge you have faced?. Value is required.';
                if(primeraEv.SuperasteRetoIngles__c == null || primeraEv.SuperasteRetoIngles__c == '')
                        correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Did you overcome the challenge?. Value is required.';
                if(primeraEv.Qu_hiciste_para_superar_la_situaci_n_1__c == null || primeraEv.Qu_hiciste_para_superar_la_situaci_n_1__c.trim() == '')
                        correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;What was the first thing that came to your mind when you faced this challenge?. Value is required.';
                if((primeraEv.QueHicisteSuperarReto__c == null || primeraEv.QueHicisteSuperarReto__c.trim() == '') && primeraEv.SuperasteReto__c == 'Yes')
                        correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;What did you do to overcome the challenge?. Value is required. Value is required.';
                if((primeraEv.QueImpidioSuperarasReto__c == null || primeraEv.QueImpidioSuperarasReto__c.trim() == '') && primeraEv.SuperasteReto__c == 'No')
                        correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;What prevented you from overcoming the challenge?. Value is required.';
                if((primeraEv.QueimpidioSuperarRetoTotalidad__c == null || primeraEv.QueimpidioSuperarRetoTotalidad__c.trim() == '') && primeraEv.SuperasteReto__c == 'Partially')
                        correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;What prevented you from completely overcoming the challenge?. Value is required.';
                if(primeraEv.Reacci_n_al_Reto_1__c == null || primeraEv.Reacci_n_al_Reto_1__c.trim() == '')
                        correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;What were the results of the decisions you made?. Value is required.';
                if(primeraEv.Resultados_de_tus_decisiones_1__c == null || primeraEv.Resultados_de_tus_decisiones_1__c.trim() == '')
                        correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Were you satisfied with the results of your actions?. Value is required.';
                
                if(correcto != '') {
                        sec5 = '<br/>&nbsp;&nbsp;Challenging experienciess:' + correcto;
                        correcto = '';
                }
                
                if(primeraEv.Redaccion__c == null || primeraEv.Redaccion__c.trim() == '')
                        correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Please describe the project in which you participated. Value is required.';
                
                if(correcto != '') {
                        sec6 = '<br/>&nbsp;&nbsp;Experience with projects:' + correcto;
                        correcto = '';
                }
                
                if(primeraEv.ServicioVoluntariadoIngles__c == null || primeraEv.ServicioVoluntariadoIngles__c == '')
                        correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Do you have volunteering experience?. Value is required.';
                if((primeraEv.InvolucrasteInstitucionVoluntariadoIng__c == null || primeraEv.InvolucrasteInstitucionVoluntariadoIng__c == '') 
                        && primeraEv.ServicioVoluntariadoIngles__c == 'Si')
                        correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;How did you get involved with the organization you volunteered in?. Value is required.';
                if((primeraEv.TiempoInvolucradoActividadIngles__c == null || primeraEv.TiempoInvolucradoActividadIngles__c == '') && primeraEv.ServicioVoluntariadoIngles__c == 'Yes')
                        correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;How long were you involved in this activity?. Value is required.';
                if((primeraEv.PeriodoActividadIngles__c == null || primeraEv.PeriodoActividadIngles__c == '') && primeraEv.ServicioVoluntariadoIngles__c == 'Yes')
                        correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Period involved in this activity. Value is required.';
                if(primeraEv.Razones_para_querer_formar_parte_de_ExM__c == null || primeraEv.Razones_para_querer_formar_parte_de_ExM__c.trim() == '')
                        correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Why do you want to be part of Teach for Mexico?. Value is required.';
                if(primeraEv.problemas_del_sistema_educativo_Mexicano__c == null || primeraEv.problemas_del_sistema_educativo_Mexicano__c.trim() == '')
                        correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;What is the main problem in Mexico?. Value is required.';
                if(primeraEv.AccionesONG__c == null || primeraEv.AccionesONG__c.trim() == '')
                        correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;To what extent do you think NGOs can contribute to the improvement of Mexico?. Value is required.';
                                
                if(correcto != '') {
                        sec7 = '<br/>&nbsp;&nbsp;Your profile:' + correcto;
                        correcto = '';
                }
                
                if(contacto.ComoEnterasteExMIngles__c == null || contacto.ComoEnterasteExMIngles__c == '')
                        correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;How did you hear about us?. Value is required.';
                if((contacto.OtroMedio__c == null || contacto.OtroMedio__c.trim() == '') && contacto.C_mo_te_enteraste_de_ExM__c == 'Otro')
                        correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Add Other. Value is required.';
                
                if(correcto != '') {
                        sec9 = '<br/>&nbsp;&nbsp;Additional information:' + correcto;
                        correcto = '';
                }
                
                if(!primeraEv.HeLeidoDetenidamenteQueTrata__c)
                        correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;I have carefully read what the program is about. Value is required.';
                if(!primeraEv.EstoyConscienteAceptacion__c)
                        correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;I am aware that if I am accepted through the selection process... Value is required.';
                if(!primeraEv.DeSerAceptadoPosibleDebaMudarme__c)
                        correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;I am aware that if accepted, I will most likely have to relocate. Value is required.';
                if(!primeraEv.ConfirmacionDeInformacion__c)
                        correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;I hereby confirm that the information... Value is required.';
                if(primeraEv.NombreManeraFirmaElectronica__c == '' || primeraEv.NombreManeraFirmaElectronica__c == null)
                        correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Your full name as your electronic signature. Value is required.';
                
                if(correcto != '') {
                        sec10 = '<br/>&nbsp;&nbsp;Seccion Confirmación de información:' + correcto;
                        correcto = '';
                }
                
                correcto = sec1 + sec2 + sec3 + sec4 + sec5 + sec6 + sec7 + sec8 + sec9 + sec10;
                
                Boolean duplicado = false;
                
                for(String str : lCorreos) {
                	if(contacto.Correo_electr_nico__c == str) {
                		duplicado = true;
                	}
                }
                                
                if(correcto == '') {
                        insert contacto;
                        primeraEv.Nombre_del_Candidato__c = contacto.Id;
                        
                        //if(idUnivSel != 'otro' && idUnivSel != 'none')
                          //      primeraEv.Universidad__c = idUnivSel;
                        
                        insert primeraEv;
                        
                        segundaEv.Nombre_del_candidato__c = contacto.Id;
                        insert segundaEv;
                        
                        terceraEv.Nombre__c = contacto.Id;
                        insert terceraEv;
                        
                        return Page.PESend;
                } else {
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'ERRORS:' + correcto));
                        return null;
                }
        }       
}