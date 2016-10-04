public with sharing class CtrlPrimeraEvaluacion {
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
    
    public CtrlPrimeraEvaluacion () {
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
        
        String titulado = ApexPages.currentPage().getParameters().get('tit');
        
        if(titulado != null) {
            Integer aTitulado = Integer.valueOf(ApexPages.currentPage().getParameters().get('yTit'));
            Integer mTitulado = Integer.valueOf(ApexPages.currentPage().getParameters().get('mTit'));
            Integer dTitulado = Integer.valueOf(ApexPages.currentPage().getParameters().get('dTit'));
            
            primeraEv.est_s_titulado__c = titulado;
            primeraEv.Fecha_de_egreso_o_titulaci_n__c = Date.newInstance(aTitulado, mTitulado, dTitulado);
        } else {
            primeraEv.est_s_titulado__c = 'Si';
        }
         
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
        
        if(contacto.Birthdate == null)
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Fecha de Nacimiento.';
        if(contacto.Birthdate != null) {        
            if(contacto.Birthdate.year() > 1995 || contacto.Birthdate.year() < 1984)
                correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Fecha de Nacimiento válida.';
        }
        if(contacto.Nacionalidad__c == null || contacto.Nacionalidad__c == '')
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Nacionalidad.';
        if(contacto.NacionalidadExtranjera__c == null && contacto.Nacionalidad__c == 'Extranjero')
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Nacionalidad Extranjera.';
        if(contacto.CURP__c == null && contacto.Nacionalidad__c == 'Mexicano')
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar CURP.';
        if(contacto.CURP__c != null && contacto.CURP__c.length() > 18)
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;CURP no debe tener mas de 18 caractéres.';
        if(contacto.G_nero__c == null)
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Género.';
        if(contacto.Correo_electr_nico__c == null)
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Correo Electrónico.';
        if(textCorreo == null || textCorreo != contacto.Correo_electr_nico__c)
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar de Nuevo Correo Electrónico.';
        if(contacto.PaisDireccionPermanente__c == null && (primeraEv.PaisControlador__c == 'EUA' || primeraEv.PaisControlador__c == 'Otro'))
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar País de dirección permanente.';
        if(contacto.PaisCP__c == null && contacto.PaisDireccionPermanente__c == 'Otro')
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Nombre de País de dirección permanente.';
        if(contacto.Calle__c == null || contacto.Calle__c == '') 
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Calle.';
        if(contacto.NumeroExterior__c == null)
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Número Exterior.';
        //if(contacto.CodigoPostal__c == null && (primeraEv.PaisControlador__c == 'México' || contacto.PaisDireccionPermanente__c == 'México'))
            //correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Código Postal.';
        if(contacto.CodigoPostalTxt__c == null)
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Código Postal.';
        if(contacto.Localidad_Colonia__c == null && (contacto.PaisDireccionPermanente__c == 'México' || primeraEv.PaisControlador__c == 'México'))  
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Colonia.';
        if(contacto.EstadoCPEUA__c == null && contacto.PaisDireccionPermanente__c == 'Estados Unidos')
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Estado.';
        if(contacto.EstadoCPMex__c == null && (contacto.PaisDireccionPermanente__c == 'México' || primeraEv.PaisControlador__c == 'México'))
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Estado.';
        if(contacto.Estado__c == null && contacto.PaisDireccionPermanente__c == 'Otro')
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Estado.';
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
        if(contacto.HablasAlgunaLenguaIndigena__c == null || contacto.HablasAlgunaLenguaIndigena__c == '')
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar si hablas una Lengua Indígena.';
        if(contacto.HablasAlgunaLenguaIndigena__c == 'Sí') {
            if(contacto.LenguaHablada__c == null || contacto.LenguaHablada__c == '')
                correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Lengua Indígena hablada.';
            if(contacto.GradoDominio__c == null || contacto.GradoDominio__c == '')
                correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Grado de Dominio de la Lengua hablada.';
        }
        if(correcto != '') {
            sec1 = '<br/>&nbsp;&nbsp;Seccion Datos Personales:' + correcto;
            correcto = '';
        }
        
        if(primeraEv.Titulo_Universitario_1__c == null)
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Título Universitario.';
        if(primeraEv.Carrera__c == null || primeraEv.Carrera__c == '')
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Carrera de Universidad.';
        if(primeraEv.EstadoUniversidad__c == null && primeraEv.PaisControlador__c != 'Otro')
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Estado de la Universidad.';
        if(primeraEv.PaisUniversidadOtro__c == null && primeraEv.PaisControlador__c == 'Otro')
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Estado de la Universidad.';
        if((idUnivSel == null ||idUnivSel == '' )&& primeraEv.PaisControlador__c != 'Otro')
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Universidad.';
        if(primeraEv.Otra_Universidad_1__c == null && idUnivSel != '' && idUnivSel == 'otro')
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Otra Universidad.';
        if(primeraEv.Otra_Universidad_1__c == null && primeraEv.PaisControlador__c == 'Otro')
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Otra Universidad.';
        if(primeraEv.Promedio_general_de_aprovechamiento_1__c == null || primeraEv.Promedio_general_de_aprovechamiento_1__c == '')
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Promedio general.';
        if(primeraEv.est_s_titulado__c == null)
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Si estas Titulado.';
        if(primeraEv.Fecha_de_egreso_o_titulaci_n__c == null && primeraEv.est_s_titulado__c != 'Si')
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Fecha de Titulación.';
        if(primeraEv.TienesEstudioPosgrado__c == null || primeraEv.TienesEstudioPosgrado__c == null)
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar si tienes estudios de Posgrado.';
        
        if( (primeraEv.NombredelPosgrado__c == null || primeraEv.NombredelPosgrado__c == '') && primeraEv.TienesEstudioPosgrado__c == 'Sí')
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar el Nombre del posgrado.';    
        if( (primeraEv.T_tulo_obtenido__c == null || primeraEv.T_tulo_obtenido__c == '') && primeraEv.TienesEstudioPosgrado__c == 'Sí')
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Titulo obtenido.';
        if( (primeraEv.NombrePostgrado__c == null || primeraEv.NombrePostgrado__c == '') && primeraEv.TienesEstudioPosgrado__c == 'Sí')
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Nombre completo de la Universidad.';
        if((primeraEv.PaisUniversidadPosgrado__c == null || primeraEv.PaisUniversidadPosgrado__c == '' ) && primeraEv.TienesEstudioPosgrado__c == 'Sí')
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar País de Universidad de Posgrado.';
        
        if(correcto != '') {
            sec2 = '<br/>&nbsp;&nbsp;Seccion Datos Académicos:' + correcto;
            correcto = '';
        }
                
        /*if(primeraEv.Areapodriasdesarrollarte__c == null)
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Área en que podrías desarrollarte.';
        if(primeraEv.InglesNivelSecundariaBachillerato__c == null)
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Nivel de Inglés para Secundaria o Bachillerato.';
        if(primeraEv.MatematicasNivelSecundariaBachillerato__c == null)
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Nivel de Matemáticas para Secundaria o Bachillerato.'; */
        /*if(primeraEv.QuimicaFisicaNivelSecundariaBachillerato__c == null)
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
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar disposición de dar clases en Bachillerato.';*/ 
        if(contacto.Biologia__c == null || contacto.Biologia__c == '')
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar algún valor en Biología.';
        if(contacto.Fisica__c == null || contacto.Fisica__c == '')
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar algún valor en Física.';
        if(contacto.Quimica__c == null || contacto.Quimica__c == '')
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar algún valor en Química.';
        if(contacto.CienciasSociales__c == null || contacto.CienciasSociales__c == '')
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar algún valor en Ciencias sociales.';
        if(contacto.Computacion__c == null || contacto.Computacion__c == '')
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar algún valor en Computación.';
        if(contacto.Ingles__c == null || contacto.Ingles__c == '')
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar algún valor en Inglés.';
        if(contacto.Matematicas__c == null || contacto.Matematicas__c == '')
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar algún valor en Matemáticas.';
        if(contacto.OrientacionDesarrolloHumano__c == null || contacto.OrientacionDesarrolloHumano__c == '')
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar algún valor en Orientación y desarrollo humano.';
        if(contacto.Primaria__c == null || contacto.Primaria__c == '')
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar algún valor en Primaria.';
        if(contacto.Secundaria__c == null || contacto.Secundaria__c == '')
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar algún valor en Secundaria.';
        if(contacto.Preparatoria__c == null || contacto.Preparatoria__c == '')
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar algún valor en Preparatoria.';
        if(contacto.Rural__c == null || contacto.Rural__c == '')
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar algún valor en Rural.';
        if(contacto.Urbana__c == null || contacto.Urbana__c == '')
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar algún valor en Urbana.';    
            
        if(correcto != '') {
            sec3 = '<br/>&nbsp;&nbsp;Seccion Enseñanza:' + correcto;
            correcto = '';
        }
        
        /*
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
        
        if(correcto != '') {
            sec4 = '<br/>&nbsp;&nbsp;Seccion Actividades Extracurriculares:' + correcto;
            correcto = '';
        }
        
        if(primeraEv.Describe_un_reto_1__c == null)
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
        }
        
        if(primeraEv.Servicio_como_voluntario__c == null)
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar si has realizado Servicio Voluntario.';
        if(primeraEv.InvolucrasteInstitucionVoluntariado__c == null && primeraEv.Servicio_como_voluntario__c == 'Si')
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar como te involucraste con la Institución de Voluntariado.';
        if(primeraEv.Razones_para_querer_formar_parte_de_ExM__c == null)
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar porque quieres ser parte de EPM.';
        if(primeraEv.problemas_del_sistema_educativo_Mexicano__c == null)
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar Problema principal de México.';
        if(primeraEv.AccionesONG__c == null)
            correcto = correcto + '<br/>&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;&nbsp;Debes ingresar contribución de la ONG a la mejora del País.';
                
        if(correcto != '') {
            sec7 = '<br/>&nbsp;&nbsp;Seccion Tu pefil:' + correcto;
            correcto = '';
        }*/
        
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
                
                return Page.PEEnviada;
            } else {
                return null;
            }
            
        } else {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Revisa los mensajes de error:' + correcto));
            return null;
        }
    }   
}