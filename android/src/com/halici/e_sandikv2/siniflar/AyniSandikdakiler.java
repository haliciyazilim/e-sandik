package com.halici.e_sandikv2.siniflar;

import java.util.ArrayList;
import java.util.HashMap;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class AyniSandikdakiler {

	private String gelenVeri;
	
	// JSON Nodlarý
	private static String kisiBilgisi="KisiBilgisi";
	private static String tckn="TCKN";
//	private static String ad="Ad";
//	private static String soyad="Soyad";
	private static String il="Il";
	private static String ilce="Ilce";
	private static String mahalle="Mahalle";
	private static String sandikAlani="SandikAlani";
	private static String sandikNo="SandikNo";
	private static String sandikSiraNo="SandikSiraNo";
	
	private static String ayniSandiktakiler="AyniSandiktakiler";
	private static String ad="Ad";
	private static String soyad="Soyad";
	

	public AyniSandikdakiler(String gelenVeri) {
		super();
		this.gelenVeri = gelenVeri;
	}
	
	public ArrayList<String> veriAl(){
		ArrayList<String> bilgiler=new ArrayList<String>();
		
		 
		try {
			JSONObject json= new JSONObject(this.gelenVeri);
			JSONArray sandikBilgisiArray=json.getJSONArray(ayniSandiktakiler);
			
			String isim, soyisim;
			for(int i=0; i<sandikBilgisiArray.length();i++){
				isim=sandikBilgisiArray.getJSONObject(i).getString(ad).toString();
				soyisim=sandikBilgisiArray.getJSONObject(i).getString(soyad).toString();
				
				bilgiler.add(isim+" "+soyisim);
			}
			

			
			System.out.println("Ayni Sandýktakiler"+bilgiler.get(0));
			
			
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return bilgiler;
	}
	
	
}
