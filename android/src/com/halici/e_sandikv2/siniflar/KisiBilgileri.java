package com.halici.e_sandikv2.siniflar;

import java.util.HashMap;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class KisiBilgileri {

	private String gelenVeri;
	
	// JSON Nodlar�
	private static String kisiBilgisi="KisiBilgisi";
	private static String tckn="TCKN";
	private static String ad="Ad";
	private static String soyad="Soyad";
	private static String il="Il";
	private static String ilce="Ilce";
	private static String mahalle="Mahalle";
	private static String sandikAlani="SandikAlani";
	private static String sandikNo="SandikNo";
	private static String sandikSiraNo="SandikSiraNo";
	private static String loginDurumu="LoginDurumu";

	private static String eskiListe="EskiListe";
	private static String secimYili="SecimYili";
	
	public KisiBilgileri(String gelenVeri) {
		super();
		this.gelenVeri = gelenVeri;
	}
	
	public HashMap<String, String> veriAl(){
		HashMap<String, String> map=new HashMap<String, String>();
		
		 
		try {
			JSONObject json= new JSONObject(this.gelenVeri);
			JSONObject kisiBilgileri=json.getJSONObject(kisiBilgisi);
			
//			veriler[0]=kisiBilgileri.getString(ad);
//			veriler[1]=kisiBilgileri.getString(soyad);
//			veriler[2]=kisiBilgileri.getString(il);
//			veriler[3]=kisiBilgileri.getString(ilce);
//			veriler[4]=kisiBilgileri.getString(mahalle)
//			veriler[5]=kisiBilgileri.getString(sandikAlani);
//			veriler[6]=kisiBilgileri.getString(sandikSiraNo);
//			veriler[7]=kisiBilgileri.getString(il);
//			veriler[8]=kisiBilgileri.getString(ilce);
			
			
			
			map.put("loginDurumu", String.valueOf(json.getBoolean(loginDurumu)));
			map.put("isim", kisiBilgileri.getString(ad));
			map.put("soyisim", kisiBilgileri.getString(soyad));
			map.put("tckn", kisiBilgileri.getString(tckn));
			map.put("il", kisiBilgileri.getString(il));
			map.put("ilce", kisiBilgileri.getString(ilce));
			map.put("mahalle", kisiBilgileri.getString(mahalle));
			map.put("sandikAlani", kisiBilgileri.getString(sandikAlani));
			map.put("sandikNo", kisiBilgileri.getString(sandikNo));
			map.put("sandikSiraNo", kisiBilgileri.getString(sandikSiraNo));
			
			map.put("eskiListe", json.getString(eskiListe));
			map.put("secimYili", json.getString(secimYili));
			
//			System.out.println("Kişi bilgileri, eski liste"+json.getString(eskiListe)+", secim Yili: "+json.getString(secimYili));
			
			
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return map;
	}
	
	
}
