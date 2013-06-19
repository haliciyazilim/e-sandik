package com.halici.e_sandikv2.siniflar;

import org.ksoap2.SoapEnvelope;
import org.ksoap2.serialization.SoapObject;
import org.ksoap2.serialization.SoapPrimitive;
import org.ksoap2.serialization.SoapSerializationEnvelope;
import org.ksoap2.transport.HttpTransportSE;

import android.util.Log;

public class Sorgulama {
	String telNo_TCKN;
	Long tckn;
	String sifre;
	public Sorgulama(String telNo_TCKN, String tckn, String sifre) {
		this.telNo_TCKN=telNo_TCKN;
		this.sifre=sifre;
		this.tckn=Long.valueOf(tckn);
	}
	
	public Sorgulama(String telNo_TCKN, String sifre) {
		this.telNo_TCKN=telNo_TCKN;
		this.sifre=sifre;
	}

	// webServisin yeri
	final static String NAMESPACE="http://tempuri.org/";
			 
	// kullanılan metot
	final static String METHOD_NAME_LOGIN="ESANDIK_Login";
	final static String METHOD_NAME_SANDIK_YERI="SandikYeriSorgula";
			 
	// soap_action
	final static String SOAP_ACTION_LOGIN="http://tempuri.org/ESANDIK_Login";
	final static String SOAP_ACTION_SANDIK_YERI="http://tempuri.org/SandikYeriSorgula";
			 
	// webservise ait url tanimlaması
	final static String URL = "http://bilisim.chp.org.tr/MobilService.asmx";
	
	
	public String sifreGonder(){
		String sonuc = null;
		// soap nesnesi
		SoapObject request = new SoapObject(NAMESPACE, METHOD_NAME_LOGIN);
					
		// requeste bilgi ekleniyor.
		request.addProperty("telNo_TCKN", this.telNo_TCKN);
		request.addProperty("Sifre",this.sifre);
					
		//Web servisin versiyonunu bildiriyoruz.
		SoapSerializationEnvelope soapEnvelope = new SoapSerializationEnvelope(SoapEnvelope.VER12);
					
		//don.net ile hazırlandığı için
		soapEnvelope.dotNet = true;
					
		//requesti zarfa koyuoyoruz.
		soapEnvelope.setOutputSoapObject(request);
					
		//transfer değeri oluşturuyoruz
		HttpTransportSE aht = new HttpTransportSE(URL);
		aht.debug=true;
					
		try {
			System.out.println("try içindeiym.");
			
			// Ve son olarak isteğimizi gönderiyoruz.
			aht.call(SOAP_ACTION_LOGIN, soapEnvelope);
			aht.setXmlVersionTag("<?xml version=\"1.0\" encoding=\"utf-8\"?>");
			aht.debug=true;
					
			System.out.println("try sonu");
		} 
		catch (Exception e) {
			Log.i("hata",e.toString());
				e.printStackTrace();
		} 
		
		try {
			// Cevap olarak basit bir veri tipi beklediğimiz için,
			// cevabı SoapPrimitive nesnesi olarak alıyoruz.
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

	
	public String bilgileriAl(){
		String sonuc = null;
		// soap nesnesi
		SoapObject request = new SoapObject(NAMESPACE, METHOD_NAME_SANDIK_YERI);
		
		System.out.println("******Sorgulama: "+this.telNo_TCKN+", "+this.tckn+", "+this.sifre);
		
		// requeste bilgi ekleniyor.
		request.addProperty("tckn", Long.valueOf(this.tckn));
		request.addProperty("telNo_TCKN", this.telNo_TCKN);
		request.addProperty("Sifre", this.sifre);
					
		//Web servisin versiyonunu bildiriyoruz.
		SoapSerializationEnvelope soapEnvelope = new SoapSerializationEnvelope(SoapEnvelope.VER12);
					
		//don.net ile hazırlandığı için
		soapEnvelope.dotNet = true;
					
		//requesti zarfa koyuoyoruz.
		soapEnvelope.setOutputSoapObject(request);
					
		//transfer değeri oluşturuyoruz
		HttpTransportSE aht = new HttpTransportSE(URL);
		aht.debug=true;
					
		try {
			System.out.println("try içindeiym.");
			
			// Ve son olarak isteğimizi gönderiyoruz.
			aht.call(SOAP_ACTION_SANDIK_YERI, soapEnvelope);
			aht.setXmlVersionTag("<?xml version=\"1.0\" encoding=\"utf-8\"?>");
			aht.debug=true;
					
			System.out.println("try sonu");
		} 
		catch (Exception e) {
			Log.i("hata",e.toString());
				e.printStackTrace();
		} 
		
		try {
			// Cevap olarak basit bir veri tipi beklediğimiz için,
			// cevabı SoapPrimitive nesnesi olarak alıyoruz.
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
