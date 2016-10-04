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
private class TestTriggers {
	static testMethod void PrimeraRevisionTest() {
		// TO DO: implement unit test
		Contact c = new Contact();
		c.LastName = 'Test';
		insert c;
		
		PRIMERA_REVISI_N__c pRev = new PRIMERA_REVISI_N__c();
		pRev.Nombre_del_Candidato__c = c.Id;
		pRev.Niveles_de_impacto__c = 'Bajo impacto';
		pRev.Niveles_de_resultados__c = 'Sin resultados ó resultados por debajo de la expectativa';
		pRev.Niveles_de_esfuerzo__c = 'Disminuye el esfuerzo o renuncia';
		pRev.Niveles_de_actitud__c = 'Actitud negativa';
		pRev.Niveles_de_compromiso__c = 'No mantiene permanencia y constancia';
		pRev.Niveles_de_responsabilidad__c = 'No cumple en tiempo y forma';
		pRev.Tipos_de_compromiso_con_la_misi_n__c = 'No conoce la misión de Enseña de Enseña por México';
		
		insert pRev;
		
		pRev.est_s_titulado__c = 'Si';
		update pRev;
	}
	
	static testMethod void PruebaPensamientoTest() {
		// TO DO: implement unit test
		Contact c = new Contact();
		c.LastName = 'Test';
		insert c;
		
		Prueba_de_pensamiento_cr_tico__c pPens = new Prueba_de_pensamiento_cr_tico__c();
		pPens.Nombre_del_Candidato__c = c.Id;
		pPens.X1_preguntas_para_el_profesor_Ugarte__c = 'B';
		pPens.X2_El_aumento_de_participaci_n_en_clases__c = 'C';
		pPens.Niveles_de_generalizaciones_negativas__c = '3 ó más generalizaciones neg';
		
		insert pPens;
		
		pPens.Fecha_del_d_a_de_evaluaci_n__c = Date.today();
		update pPens;
	}
	
	static testMethod void DiaEntrevistaTest() {
		// TO DO: implement unit test
		Contact c = new Contact();
		c.LastName = 'Test';
		insert c;
		
		Dia_de_Entrevista__c dEnt = new Dia_de_Entrevista__c();
		dEnt.Nombre__c = c.Id;
		dEnt.Niveles_de_impacto__c = 'Bajo impacto';
		dEnt.Niveles_de_resultados__c = 'Sin resultados ó resultados por debajo de la expectativa';
		dEnt.Liderazgo_1a_revisi_n__c = '1';
		dEnt.Niveles_de_esfuerzo__c = 'Disminuye el esfuerzo o renuncia';
		dEnt.Niveles_de_actitud__c = 'Actitud negativa';
		dEnt.Perseverancia__c = '1';
		dEnt.Niveles_de_organizaci_n__c = '2';
		dEnt.Niveles_de_alertas__c = '2';
		dEnt.Habilidades_organizacionales_1__c = '3';
		dEnt.Influencia_y_Motivaci_n__c = '1';
		dEnt.Planeaci_n_con_inter_s__c = '1';
		dEnt.Saber_escuchar_saber_responder__c = '1';
		dEnt.ACTIVIDAD_GRUPAL__c = '1';
		dEnt.Presencia_y_madurez__c = '1';	
		dEnt.Saber_escuchar_saber_reponder__c = '1';
		dEnt.Comunicaci_n_JR__c = '1';
		dEnt.Presencia_y_Madurez_JR__c = '1';
		dEnt.Saber_escuchar_saber_responder_JR__c = '1';
		dEnt.Considera_los_intereses_de_la_audiencia__c = '1';
		dEnt.Niveles_de_compromiso_con_la_misi_n__c = '2';
		dEnt.Niveles_de_logros_acad_micos_esperados__c = '2';
		dEnt.Niveles_de_deseo_de_participar_en_reto__c = '3';
		dEnt.Niveles_de_compromiso__c = 'No mantiene permanencia y constancia';
		dEnt.Niveles_de_responsabilidad__c = 'No cumple en tiempo y forma';
		dEnt.Firmeza_de_caracter_1a_revisi_n__c = '1';
		
		insert dEnt;
		
		dEnt.alerta_actividad_grupal__c = false;
		update dEnt;
	}
}