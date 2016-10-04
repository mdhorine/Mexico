public with sharing class CtrlSeleccionPAI {
    public Contact contacto {get;set;}
    public CodigoPostal__c codPostal {get;set;}
    public PRIMERA_REVISI_N__c primeraEv {get;set;}
    public Dia_de_Entrevista__c terceraEv {get;set;}
    public Prueba_de_pensamiento_cr_tico__c segundaEv {get;set;}
    
    public List<CodigoPostal__c> lCP {get;set;}
    
    public Boolean continua {get;set;}
    public Boolean verIngles {get;set;}
    public Boolean verDuplicado {get;set;}
    
    public String cp {get;set;}
    public String idCPSel {get;set;}
    public String idUnivSel {get;set;}
    public String textCorreo {get;set;}
    
    public List<string> lPaises {get;set;}
    
    public CtrlSeleccionPAI () {
        segundaEv = new Prueba_de_pensamiento_cr_tico__c();
        terceraEv = new Dia_de_Entrevista__c();
        primeraEv = new PRIMERA_REVISI_N__c();
        codPostal =  new CodigoPostal__c();
        contacto = new Contact();
        
        lCP = new List<CodigoPostal__c>();
        
        verDuplicado = false;
        verIngles = false;
        continua = false;
        
        textCorreo = '';
        idUnivSel = '';
        idCPSel = '';
        cp = '';
        
        primeraEv.PaisControlador__c = 'México';
        //contacto.PosibilidadSiguientesMunicipios__c = 'No';

        
        lPaises = new List<string>();
        lPaises.add('México');
    }
    
    public void cambiaPais() {
        primeraEv.PaisControlador__c = 'México';
    }
    
    public void validaEncabezado() {
        continua = true;
        contacto.PaisEstudiosLicenciatura__c = primeraEv.PaisControlador__c;
    }
    
    public void validaArea() {
        if(primeraEv.Areapodriasdesarrollarte__c != null && primeraEv.Areapodriasdesarrollarte__c.contains('Inglés')) 
            verIngles = true;
        else if(primeraEv.Areapodriasdesarrollarte__c != null && !primeraEv.Areapodriasdesarrollarte__c.contains('Inglés'))
            verIngles = false;
        else if(primeraEv.Areapodriasdesarrollarte__c == null || primeraEv.Areapodriasdesarrollarte__c == '')
            verIngles = false;
        
        System.debug('::::Area : ' + primeraEv.Areapodriasdesarrollarte__c);
    }
    
    public void cargaCP() {
        lCP = new List<CodigoPostal__c>();
        
        for(CodigoPostal__c cp : [Select id, Name, Ciudad__c, Estado__c, Localidad_Colonia__c, Municipio_Delegacion__c, Pais__c, Seleccionar__c from CodigoPostal__c 
                                    where Name =: cp and (Pais__c =: primeraEv.PaisControlador__c or Pais__c =: contacto.PaisDireccionPermanente__c)]) {
            lCP.add(cp);
        }
    }
    
    public void agregaCP() {
        contacto.CodigoPostal__c = idCPSel;
        
        codPostal = [Select id, Name, Ciudad__c, Estado__c, Localidad_Colonia__c, Municipio_Delegacion__c, Pais__c 
                        from CodigoPostal__c where Id =: idCPSel];
        lCP = new List<CodigoPostal__c>();
    }
    
    public List<SelectOption> getUniv () {
        List<SelectOption> options = new List<SelectOption>();
        
        if(primeraEv.EstadoUniversidad__c != '' || primeraEv.EstadoUniversidad__c != null) {
            options.add(new SelectOption('','Selecciona Universidad...'));
            for(Universidad__c grupoIterado : [Select Id, NombreUniversidad__c From Universidad__c 
                                                where EstadoUniversidad__c =: primeraEv.EstadoUniversidad__c order by NombreUniversidad__c asc]) {
                options.add(new SelectOption(grupoIterado.Id, grupoIterado.NombreUniversidad__c));
            }
            options.add(new SelectOption('otro','OTRO'));
        }
        
        return options;
    }
    
    //Metodo Dummy
    public PageReference metodoVacio() {
        contacto.PaisEstudiosLicenciatura__c = primeraEv.PaisControlador__c;
        idUnivSel = '';
        return null;
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
        
        if(contacto.Birthdate == null )
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Fecha de Nacimiento.';
        //if(contacto.Birthdate != null) {        
          //  if(contacto.Birthdate.year() > 1995 || contacto.Birthdate.year() < 1984)
            //    correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Fecha de Nacimiento válida.';
        //}
        //if(contacto.Nacionalidad__c == '')
            //correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Nacionalidad.';
        //if(contacto.NacionalidadExtranjera__c == null && contacto.Nacionalidad__c == 'Extranjero')
           // correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Nacionalidad Extranjera.';
        if(contacto.CURP__c == null || contacto.CURP__c == '')
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar CURP.';
        if(contacto.CURP__c != null && contacto.CURP__c.length() > 18)
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;CURP no debe tener mas de 18 caractéres.';
        if(contacto.G_nero__c == null || contacto.G_nero__c == '')
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Género.';
        if(contacto.Correo_electr_nico__c == null || contacto.Correo_electr_nico__c == '')
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Correo Electrónico.';
        if(textCorreo == null || textCorreo != contacto.Correo_electr_nico__c)
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar de Nuevo Correo Electrónico.';
        //if(contacto.PaisDireccionPermanente__c == null && (primeraEv.PaisControlador__c == 'EUA' || primeraEv.PaisControlador__c == 'Otro'))
            //correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar País de dirección permanente.';
        //if(contacto.PaisCP__c == null && contacto.PaisDireccionPermanente__c == 'Otro')
            //correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Nombre de País de dirección permanente.';
        if(contacto.Calle__c == null || contacto.Calle__c == '') 
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Calle.';
        if(contacto.NumeroExterior__c == null || contacto.NumeroExterior__c == '' )
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Número Exterior.';
        //if(contacto.CodigoPostal__c == null && (primeraEv.PaisControlador__c == 'México' || contacto.PaisDireccionPermanente__c == 'México'))
            //correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Código Postal.';
        if(contacto.CodigoPostalTxt__c == null || contacto.CodigoPostalTxt__c == '' )
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Código Postal.';
        if(contacto.Localidad_Colonia__c == null && (contacto.PaisDireccionPermanente__c == 'México' || primeraEv.PaisControlador__c == 'México'))  
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Colonia.';
        //if(contacto.EstadoCPEUA__c == null && contacto.PaisDireccionPermanente__c == 'Estados Unidos')
            //correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Estado.';
        if(contacto.EstadoCPMex__c == null && (contacto.PaisDireccionPermanente__c == 'México' || primeraEv.PaisControlador__c == 'México'))
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Estado.';
        //if(contacto.Estado__c == null && contacto.PaisDireccionPermanente__c == 'Otro')
            //correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Estado.';
        if(contacto.CiudadCP__c == null && contacto.PaisDireccionPermanente__c == 'Estados Unidos')
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Condado.';
        if(contacto.CiudadCP__c == null && (contacto.PaisDireccionPermanente__c == 'México' || primeraEv.PaisControlador__c == 'México'))
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Municipio o Delegación.';
        if(contacto.CiudadCP__c == null && contacto.PaisDireccionPermanente__c == 'Otro')
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Ciudad.';
        if(contacto.Tel_fono_de_casa__c == null || contacto.Tel_fono_de_casa__c == '')
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Teléfono de Casa.';
        if(contacto.Tel_fono_celular__c == null || contacto.Tel_fono_celular__c == '')
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Teléfono Celular.';
        if(contacto.Cuenta_de_Skype__c == null || contacto.Cuenta_de_Skype__c == '')
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Cuenta de Skype.';                        
        //if(contacto.HablasAlgunaLenguaIndigena__c == '' || contacto.HablasAlgunaLenguaIndigena__c == null )
        //    correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar si hablas una Lengua Indígena.';
        if(contacto.NumeroSeguridadSocial__c == '' || contacto.NumeroSeguridadSocial__c == null )
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar No. de IFE.';    
        if(contacto.HablasAlgunaLenguaIndigena__c == 'Si') {
            if(contacto.LenguaHablada__c == null)
                correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Lengua Indígena hablada.';
            if(contacto.GradoDominio__c == null)
                correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Grado de Dominio de la Lengua hablada.';
        } 
        if(contacto.PosibilidadSiguientesMunicipios__c == '' || contacto.PosibilidadSiguientesMunicipios__c == null )
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Prioridad 1.';
        if(contacto.PosibilidadSiguientesMunicipios2__c == '' || contacto.PosibilidadSiguientesMunicipios2__c == null )
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Prioridad 2.';    
        //if(contacto.EstadoOriundoPAI__c == '' || contacto.EstadoOriundoPAI__c == null )
            //correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar de que estado eres oriundo.';   
        if(contacto.LenguasMexicanasPAI__c == '' || contacto.LenguasMexicanasPAI__c == null  )
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar si hablas alguna lengua mexicana.';
        //if(contacto.PosibilidadSiguientesMunicipios__c != 'No') {
            //if(contacto.Localidad__c == null || contacto.Localidad__c == '')
                //correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Localidad.'; }
           
        
        if(correcto != '') {
            sec1 = '<br/>&nbsp;&nbsp;Seccion Datos Personales:' + correcto;
            correcto = '';
        }
        
        if(primeraEv.Titulo_Universitario_1__c == null || primeraEv.Titulo_Universitario_1__c == '')
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Título Universitario.';
        if(primeraEv.Carrera__c == null || primeraEv.Carrera__c == '')
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Carrera de Universidad.';
        if(primeraEv.EstadoUniversidad__c == null && primeraEv.PaisControlador__c != 'Otro')
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Estado de la Universidad.';
        if(primeraEv.PaisUniversidadOtro__c == null && primeraEv.PaisControlador__c == 'Otro')
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Estado de la Universidad.';
        if((idUnivSel == '' || idUnivSel == null) && primeraEv.PaisControlador__c != 'Otro')
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Universidad.';
        if(primeraEv.Otra_Universidad_1__c == null && idUnivSel != '' && idUnivSel == 'otro')
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Otra Universidad.';
        if(primeraEv.Otra_Universidad_1__c == null && primeraEv.PaisControlador__c == 'Otro')
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Otra Universidad.';
        if(primeraEv.Promedio_general_de_aprovechamiento_1__c == '' || primeraEv.Promedio_general_de_aprovechamiento_1__c == null)
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Promedio general.';
        if(primeraEv.est_s_titulado__c == null)
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Si estas titulado.';
        if(primeraEv.Fecha_de_egreso_o_titulaci_n__c == null && primeraEv.est_s_titulado__c != 'Si')
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Fecha de Titulación.';
        if(primeraEv.TienesEstudioPosgrado__c == null)
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar si tienes estudios de Posgrado.';
        if((primeraEv.T_tulo_obtenido__c == null || primeraEv.T_tulo_obtenido__c == '' ) && primeraEv.TienesEstudioPosgrado__c == 'Sí')
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar título obtenido.';
        if((primeraEv.NombredelPosgrado__c == null || primeraEv.NombredelPosgrado__c == '' )&& primeraEv.TienesEstudioPosgrado__c == 'Sí')
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Nombre del posgrado.';
        if((primeraEv.NombrePostgrado__c == null || primeraEv.NombrePostgrado__c == '' )&& primeraEv.TienesEstudioPosgrado__c == 'Sí')
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Nombre completo de la Universidad.';
        if((primeraEv.PaisUniversidadPosgrado__c == null || primeraEv.PaisUniversidadPosgrado__c == '' )&& primeraEv.TienesEstudioPosgrado__c == 'Sí')
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar País de Universidad de Posgrado.';
        if(primeraEv.DocenteNuevoIngresoExperiencia__c == null)
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar si eres docente de nuevo ingreso.';
        
        if(correcto != '') {
            sec2 = '<br/>&nbsp;&nbsp;Seccion Datos Académicos:' + correcto;
            correcto = '';
        }
                
        /*if(primeraEv.Areapodriasdesarrollarte__c == null)
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Área en que podrías desarrollarte.';
        if(primeraEv.InglesNivelSecundariaBachillerato__c == null)
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Nivel de Inglés para Secundaria o Bachillerato.';
        if(primeraEv.MatematicasNivelSecundariaBachillerato__c == null)
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Nivel de Matemáticas para Secundaria o Bachillerato.';
        if(primeraEv.QuimicaFisicaNivelSecundariaBachillerato__c == null)
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Nivel de Química y Física para Secundaria o Bachillerato.';
        if(primeraEv.CienciasSocialesNivelSecundaria__c == null)
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Nivel de Ciencias Sociales para Secundaria o Bachillerato.';
        if(primeraEv.LecturaRedaccionNivelSecundariaBachiller__c == null)
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Nivel de Lectura y Redacción para Secundaria o Bachillerato.';
        if(primeraEv.DispuestoClasesPrimaria__c == null)
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar disposición de dar clases en Primaria.';
        if(primeraEv.DispuestoClasesSecundaria__c == null)
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar disposición de dar clases en Secundaria.';
        if(primeraEv.DispuestoClasesBachillerato__c == null)
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar disposición de dar clases en Bachillerato.'; 
        
        if(correcto != '') {
            sec3 = '<br/>&nbsp;&nbsp;Seccion Enseñanza:' + correcto;
            correcto = '';
        } */
        
        if(primeraEv.Servicio_como_voluntario__c == null)
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar si has realizado Servicio de voluntariado.';
        if(primeraEv.Nombre_del_grupo_u_organizaci_n_1__c == null && primeraEv.Servicio_como_voluntario__c == 'Si')
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Nombre del Grupo u Organización.';
        if(primeraEv.Tipo_de_grupo_u_organizaci_n_1__c == null && primeraEv.Servicio_como_voluntario__c == 'Si')
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Tipo de Grupo u Organización.';
        if(primeraEv.CuentanosSobreGrupouOrganizacion1__c == null && primeraEv.Servicio_como_voluntario__c == 'Si')
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar acerca del Grupo u Organización.';
        if(primeraEv.Actividad_como_lider_de_un_grupo_1__c == null && primeraEv.Servicio_como_voluntario__c == 'Si')
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar cuál era tú papel o responsabilidades.';
        if(primeraEv.Desempe_o_como_l_der_1__c == null && primeraEv.Servicio_como_voluntario__c == 'Si')
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar tu desempeño';
        if(primeraEv.Justifica_tu_respuesta_1__c == null && primeraEv.Servicio_como_voluntario__c == 'Si')
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar resultados y aprendizaje obtenidos.';
        /*if(primeraEv.ComoInvolucrasteOrganizacion1__c == null)
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
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar como te Involucraste en Grupo u Organización 2.'; */
        
        if(correcto != '') {
            sec4 = '<br/>&nbsp;&nbsp;Seccion Actividades Extracurriculares:' + correcto;
            correcto = '';
        }
        
        /*if(primeraEv.Describe_un_reto_1__c == null)
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar mayor Reto a enfrentar.';
        if(primeraEv.SuperasteReto__c == null)
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Superaste Reto.';
        if(primeraEv.Qu_hiciste_para_superar_la_situaci_n_1__c == null)
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar que paso por tu Mente en Reto.';
        if(primeraEv.QueHicisteSuperarReto__c == null && primeraEv.SuperasteReto__c == 'Si')
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar que hiciste para superar Reto.';
        if(primeraEv.QueImpidioSuperarasReto__c == null && primeraEv.SuperasteReto__c == 'No')
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar que impidio superar Reto.';
        if(primeraEv.QueimpidioSuperarRetoTotalidad__c == null && primeraEv.SuperasteReto__c == 'Parcialmente')
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar que impidio superar Reto totalmente.';
        if(primeraEv.Reacci_n_al_Reto_1__c == null)
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Resultados de la desición tomada.';
        if(primeraEv.Resultados_de_tus_decisiones_1__c == null)
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Conformidad de los resultados de tus acciones.';
        
        if(correcto != '') {
            sec5 = '<br/>&nbsp;&nbsp;Seccion Tus Retos:' + correcto;
            correcto = '';
        }
        
        if(primeraEv.Redaccion__c == null || primeraEv.Redaccion__c.trim() == '')
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Experiencia en Proyectos.';
        
        if(correcto != '') {
            sec6 = '<br/>&nbsp;&nbsp;Seccion Experiencia trabajando en Proyectos:' + correcto;
            correcto = '';
        } */
        
        //if((primeraEv.NombreOrganizacionDescripcionActividades__c == '' || primeraEv.NombreOrganizacionDescripcionActividades__c == null)&& primeraEv.Servicio_como_voluntario__c == 'Si')
            //correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar nombre de la organización y descripción de actividades.';
        if(primeraEv.ImportanciaSociedadCivilMexico__c == null)
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar mejora de la educación de México.';
        if(primeraEv.QuePuedesAportarPrograma__c == null)
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar que puedas aportar al programa.';
        if(primeraEv.Razones_para_querer_formar_parte_de_ExM__c == null)
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar porque quieres formar parte de PAI.';
        if(primeraEv.TutorAcademicoComunitario__c == null)
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar si has sido tutor académico o comunitario.';
        if(primeraEv.EnQueNivelEscolar__c == null && primeraEv.TutorAcademicoComunitario__c == 'Si')
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar en qué nivel escolar.';
        if(primeraEv.NombreEscuela__c == null && primeraEv.TutorAcademicoComunitario__c == 'Si')
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar el nombre de la escuela.';
        if(primeraEv.EnQueEstadoTutor__c == null && primeraEv.TutorAcademicoComunitario__c == 'Si')
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar en qué estado.';
        if(primeraEv.EnQueMunicipioTutor__c == null && primeraEv.TutorAcademicoComunitario__c == 'Si')
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar en qué municipio fuiste tutor.';
        if(primeraEv.EnQueLocalidadTutor__c == null && primeraEv.TutorAcademicoComunitario__c == 'Si')
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar en qué localidad fuiste tutor.';
    
        if(primeraEv.ParticipantePAI2015__c == null)
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar si fuiste participante PAI en 2015.';
        if(primeraEv.EnQueMunicipioParticipante__c == null && primeraEv.ParticipantePAI2015__c == 'Si')
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar en qué municipio fuiste participante.';
        if(primeraEv.EnQueLocalidadParticipante__c == null && primeraEv.ParticipantePAI2015__c == 'Si')
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar en qué localidad fuiste participante.';
        if(primeraEv.DescribeExperiencia__c == null && primeraEv.ParticipantePAI2015__c == 'Si')
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar la descripción de tu experiencia.';
                    
        if(correcto != '') {
            sec7 = '<br/>&nbsp;&nbsp;Seccion participación en PAI:' + correcto;
            correcto = '';
        }
        
        if(contacto.C_mo_te_enteraste_de_ExM__c == null)
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar como te enteraste sobre ésta convocatoria.';
        if(contacto.OtroMedio__c == null && contacto.C_mo_te_enteraste_de_ExM__c == 'Otro')
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Otro como te enteraste sobre ésta convocatoria.';
        if(primeraEv.Servicio_como_voluntario__c == null)
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar si has realizado Voluntariado o Servicio Social.';
        /*if(primeraEv.SufresDiscapacidadOEnfermedad__c == null)
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar si sufres de alguna Discapacidad o Enfermedad crónica.';
        if(primeraEv.SufresDiscapacidadOEnfermedad__c != null && primeraEv.SufresDiscapacidadOEnfermedad__c == 'Si')
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar que Tratamiento utilizas.';*/
        
        if(correcto != '') {
            sec9 = '<br/>&nbsp;&nbsp;Seccion Información Adicional:' + correcto;
            correcto = '';
        }
        
        if(!primeraEv.HeLeidoDetenidamenteQueTrata__c)
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes Aceptar que has leído de que Trata el Programa.';
        if(!primeraEv.EstoyConscienteAceptacion__c)
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes Aceptar estar conciente de tu Labor una vez Aceptado por el Programa.';
        if(!primeraEv.DeSerAceptadoPosibleDebaMudarme__c)
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes Aceptar que es posible cambiar de residencia una vez Aceptado por el Programa.';
        if(!primeraEv.ConfirmacionDeInformacion__c)
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes Aceptar la Información proporcionada.';
        if(primeraEv.NombreManeraFirmaElectronica__c == '' || primeraEv.NombreManeraFirmaElectronica__c == null)
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes Ingresar tu Nombre a manera de Firma Electrónica.';
        
        if(correcto != '') {
            sec10 = '<br/>&nbsp;&nbsp;Seccion Confirmación de información:' + correcto;
            correcto = '';
        }
        
        correcto = sec1 + sec2 + sec3 + sec4 + sec5 + sec6 + sec7 + sec8 + sec9 + sec10;
                
        if(correcto == '') {
            System.debug(':::verDuplicado : ' + verDuplicado);
            verDuplicado = false;
            
            for(Contact c : [Select Id, Correo_electr_nico__c from Contact 
                                where Correo_electr_nico__c =: contacto.Correo_electr_nico__c]) {
                verDuplicado = true;
            }
            
            if(!verDuplicado) {
                insert contacto;
                primeraEv.Nombre_del_Candidato__c = contacto.Id;
                
                if(idUnivSel != 'otro' && idUnivSel != '')
                    primeraEv.Universidad__c = idUnivSel;
                
                insert primeraEv;
                
                segundaEv.Nombre_del_candidato__c = contacto.Id;
                insert segundaEv;
                
                terceraEv.Nombre__c = contacto.Id;
                insert terceraEv;
                
                return Page.PEEnviadaPAI;
            } else {
                return null;
            }
            
        } else {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Revisa los mensajes de error:' + correcto));
            return null;
        }
    }   
}