/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class TestMetodos {

	static testMethod void BienvenidaTest() {
		// TO DO: implement unit test
		CtrlBienvenida ctrl = new CtrlBienvenida();
		ctrl.entrarEvaluacion();
	}
	
	static testMethod void WelcomeTest() {
		// TO DO: implement unit test
		CtrlWelcome ctrl = new CtrlWelcome();
		ctrl.entrarEvaluacion();
	}
	
	static testMethod void PrimeraEvaluacionTest() {
		// TO DO: implement unit test
		CodigoPostal__c codP = new CodigoPostal__c();
		codP.Name = '03810';
		insert codP;
		
		CtrlPrimeraEvaluacion ctrl = new CtrlPrimeraEvaluacion();
		ctrl.validaEncabezado();
		ctrl.metodoVacio();
		ctrl.validaArea();
		ctrl.primeraEv.Areapodriasdesarrollarte__c = 'Otro';
		ctrl.primeraEv.PaisControlador__c = 'México';
		ctrl.primeraEv.EstadoUniversidad__c = 'Distrito Federal';
		ctrl.validaArea();
		ctrl.primeraEv.Areapodriasdesarrollarte__c = 'Inglés';
		ctrl.validaArea();
		ctrl.cp = '03810';
		ctrl.cargaCP();
		ctrl.idCPSel = ctrl.lCP[0].Id;
		ctrl.agregaCP();
		ctrl.getUniv();
		ctrl.contacto.Nacionalidad__c = '';
		ctrl.guardaContacto();
		ctrl.contacto.Birthdate = Date.today();
		ctrl.contacto.Nacionalidad__c = 'Extranjero';
		ctrl.primeraEv.PaisControlador__c = 'EUA';
		ctrl.contacto.PaisDireccionPermanente__c = 'Otro';
		ctrl.contacto.HablasAlgunaLenguaIndigena__c = 'Si';
		ctrl.guardaContacto();
	}
	
	static testMethod void PrimeraEvaluacionInglesTest() {
		// TO DO: implement unit test
		CtrlPrimeraEvaluacionIngles ctrl = new CtrlPrimeraEvaluacionIngles();
		ctrl.validaEncabezado();
		ctrl.getUniv();
		ctrl.guardaContacto();
	}
	
	@isTest(seeAllData=true)
	static void Bienvenida2Test() {
		// TO DO: implement unit test
		Prueba_de_pensamiento_cr_tico__c se = [Select Id, Name, Nombre_del_candidato__c from Prueba_de_pensamiento_cr_tico__c 
												where Nombre_del_candidato__c != null limit 1];	
		
		ApexPages.currentPage().getParameters().put('Id',se.Nombre_del_candidato__c);
		CtrlBienvenida2 ctrl = new CtrlBienvenida2();
		ctrl.continuar();
	}
	
	@isTest(seeAllData=true)
	static void RegistroEvaluacionTest() {
		// TO DO: implement unit test
		PRIMERA_REVISI_N__c se = [Select Id, Name, Nombre_del_candidato__c from PRIMERA_REVISI_N__c 
												where Nombre_del_Candidato__c != null limit 1];	
		
		ApexPages.currentPage().getParameters().put('Id',se.Nombre_del_candidato__c);
		CtlrRegistroEvaluacion ctrl = new CtlrRegistroEvaluacion();
		ctrl.guardaContacto();
	}
	
	@isTest(seeAllData=true)
	static void BienvenidaSETest() {
		// TO DO: implement unit test
		Prueba_de_pensamiento_cr_tico__c se = [Select Id, Name, Nombre_del_candidato__c from Prueba_de_pensamiento_cr_tico__c 
												where Nombre_del_candidato__c != null limit 1];	
		
		ApexPages.currentPage().getParameters().put('Id',se.Nombre_del_candidato__c);
		CtrlBienvenidaSE ctrl = new CtrlBienvenidaSE();
		ctrl.enviarSE();
	}
	
	@isTest(seeAllData=true)
	static void SegundaEvaluacionTest() {
		// TO DO: implement unit test
		Prueba_de_pensamiento_cr_tico__c se = [Select Id, Name, Nombre_del_candidato__c from Prueba_de_pensamiento_cr_tico__c 
												where Nombre_del_candidato__c != null limit 1];	
		
		ApexPages.currentPage().getParameters().put('Id',se.Nombre_del_candidato__c);
		CtrlSegundaEvaluacion ctrl = new CtrlSegundaEvaluacion();
		ctrl.guardaInfo();
		ctrl.tiempoAgotado();
	}
	
	@isTest(seeAllData=true)
	static void TerceraEvaluacionTest() {
		// TO DO: implement unit test
		Contact cont = [Select Id, Name from Contact limit 1];	
		
		ApexPages.currentPage().getParameters().put('Id', cont.Id);
		CtrlTerceraEvaluacion ctrl = new CtrlTerceraEvaluacion();
		ctrl.guardaAsistencia();
	}
	
	@isTest(seeAllData=true)
	static void SeleccionPAITest() {
		// TO DO: implement unit test
		Contact cont = [Select Id, Name from Contact limit 1];	
		
		ApexPages.currentPage().getParameters().put('Id', cont.Id);
		CtrlSeleccionPAI ctrl = new CtrlSeleccionPAI();
		ctrl.cambiaPais();
		ctrl.validaEncabezado();
		ctrl.metodoVacio();
		ctrl.validaArea();
		ctrl.cargaCP();
		ctrl.guardaContacto();
	}
}