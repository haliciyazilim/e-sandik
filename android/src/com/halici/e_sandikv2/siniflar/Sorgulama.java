package com.halici.e_sandikv2.siniflar;

import org.ksoap2.SoapEnvelope;
import org.ksoap2.serialization.SoapObject;
import org.ksoap2.serialization.SoapPrimitive;
import org.ksoap2.serialization.SoapSerializationEnvelope;
import org.ksoap2.transport.HttpTransportSE;

import android.util.Log;

public class Sorgulama {
	String tckn;
	public Sorgulama(String tckn) {
		this.tckn=tckn;
	}

	// webServisin yeri
	final static String NAMESPACE="http://tempuri.org/";
			 
	// kullanýlan metot
	final static String METHOD_NAME="SandikYeriSorgula";
			 
	// soap_action
	final static String SOAP_ACTION="http://tempuri.org/SandikYeriSorgula";
			 
	// webservise ait url tanimlamasý
	final static String URL = "http://bilisim.chp.org.tr/MobilService.asmx";
	
	
	public String baglan(){
		String sonuc = null;
		// soap nesnesi
		SoapObject request = new SoapObject(NAMESPACE, METHOD_NAME);
					
		// requeste bilgi ekleniyor.
		request.addProperty("tckn", Long.valueOf(this.tckn));
					
		//Web servisin versiyonunu bildiriyoruz.
		SoapSerializationEnvelope soapEnvelope = new SoapSerializationEnvelope(SoapEnvelope.VER11);
					
		//don.net ile hazýrlandýðý için
		soapEnvelope.dotNet = true;
					
		//requesti zarfa koyuoyoruz.
		soapEnvelope.setOutputSoapObject(request);
					
		//transfer deðeri oluþturuyoruz
		HttpTransportSE aht = new HttpTransportSE(URL);
		aht.debug=true;
					
		try {
			System.out.println("try içindeiym.");
			
			// Ve son olarak isteðimizi gönderiyoruz.
			aht.call(SOAP_ACTION, soapEnvelope);
			aht.setXmlVersionTag("<?xml version=\"1.0\" encoding=\"utf-8\"?>");
			aht.debug=true;
					
			System.out.println("try sonu");
		} 
		catch (Exception e) {
			Log.i("hata",e.toString());
				e.printStackTrace();
		} 
		
		try {
			// Cevap olarak basit bir veri tipi beklediðimiz için,
			// cevabý SoapPrimitive nesnesi olarak alýyoruz.
			SoapPrimitive sonucSoap = (SoapPrimitive) soapEnvelope.getResponse();
			sonuc=sonucSoap.toString();
					
				
			System.out.println("Gelen Veri: ");
			System.out.println(sonuc);
		} 
		catch (Exception e) {
			System.out.println("Hata: "+e.toString());
			e.printStackTrace();
		}
		
		return sonuc;
	}
}
