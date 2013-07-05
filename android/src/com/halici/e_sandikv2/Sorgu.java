package com.halici.e_sandikv2;



import java.util.ArrayList;
import java.util.HashMap;

import org.json.JSONException;
import org.json.JSONObject;

import com.halici.e_sandikv2.siniflar.AyniBinadakiler;
import com.halici.e_sandikv2.siniflar.AyniSandikdakiler;
import com.halici.e_sandikv2.siniflar.BaglantiKontrolu;
import com.halici.e_sandikv2.siniflar.KisiBilgileri;
import com.halici.e_sandikv2.siniflar.Sorgulama;

import android.app.Activity;
import android.app.AlertDialog;
import android.app.ProgressDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.text.InputFilter;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

public class Sorgu extends Activity {
	public String secimYili, eskiListe, isim, muhtarlik, sandikAlani, sandikNumarasi, sandikSirasi;
	public Boolean loginDurumu;
	
	private String userName, password, tckn;
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		super.onCreate(savedInstanceState);
		setContentView(R.layout.sorgu);
		
		Intent intent=getIntent();
		userName=intent.getStringExtra("userName");
		password=intent.getStringExtra("sifre");
		tckn=intent.getStringExtra("tckn");
		
		final EditText editSorgu=(EditText) findViewById(R.id.editSorgu);
		InputFilter[] FilterArray = new InputFilter[1];
		FilterArray[0] = new InputFilter.LengthFilter(11);
		editSorgu.setFilters(FilterArray);
		
		editSorgu.setText(tckn);
		
		Button btnSorgu=(Button) findViewById(R.id.btnSorgula);
        
        btnSorgu.setOnClickListener(new View.OnClickListener() {
			
			public void onClick(View v) {
				if(editSorgu.getText().length()==0){
					kimlikNoYokUyarisi();
					
				}
				else if(editSorgu.getText().length()!=11){
					kimlikNoHaneUyarisi();
					editSorgu.setText("");
				}
				else{
					
					String tckn=editSorgu.getText().toString();
					
					boolean baglanti=new BaglantiKontrolu(Sorgu.this).kontrolEt();
					
					if(baglanti==true){
						System.out.println("******Sorgu: "+userName+", "+tckn+", "+password);
						new Servis().execute(userName,tckn,password);
					}
					else if(baglanti==false){
						Toast.makeText(getApplicationContext(), "İnternet bağlantınız ile ilgili bir sorun var; lütfen kontrol ediniz.",  Toast.LENGTH_LONG).show();
					}	
				}
			}
		});
    }
	
	public void kimlikNoHaneUyarisi(){
    	Toast.makeText(getApplicationContext(), "Kimlik numaranızı 11 hane olarak giriniz!",  Toast.LENGTH_LONG).show();
    }
	
	public void kimlikNoYokUyarisi(){
    	Toast.makeText(getApplicationContext(), "Lütfen Kimlik Numaranızı Giriniz.",  Toast.LENGTH_LONG).show();
    }
	
	
	
	@Override
	public void onBackPressed() {
		super.onBackPressed();
		
	}



	public class Servis extends AsyncTask<String, Void, String>{
		private ProgressDialog dialog = new ProgressDialog(Sorgu.this);
		 EditText editSorgu=(EditText) findViewById(R.id.editSorgu);
		@Override
		protected String doInBackground(String... params) {
			Sorgulama sorgu=new Sorgulama(params[0],params[1], params[2]);
			String sonuc=sorgu.bilgileriAl();
			
			System.out.println("Sonuclar sonuc: "+sonuc);
			return sonuc;
		}

		@Override
		protected void onPostExecute(String string) {
			dialog.dismiss();
			
			
			KisiBilgileri bilgiler=new KisiBilgileri(string);
			HashMap<String, String> kisiBilgisi=bilgiler.veriAl();
			
			
			
			
			// Künye için gerekli bilgiler isim,muhtarlik, sandikAlani, sandikNumarasi, sandikSirasi;
			
			
			loginDurumu=Boolean.valueOf(kisiBilgisi.get("loginDurumu"));
			
			
			//System.out.println("Sorgu kunye: "+kunye[0]);
			
			if(loginDurumu){
				System.out.println("Login TRUE");
			
				AyniSandikdakiler bilgiler1=new AyniSandikdakiler(string);
				ArrayList<String> sandikBilgisi=bilgiler1.veriAl();
				
				AyniBinadakiler bilgiler2=new AyniBinadakiler(string);
				ArrayList<HashMap<String, String>> binaBilgisi=bilgiler2.veriAl();
				
				isim=(kisiBilgisi.get("isim")+" "+kisiBilgisi.get("soyisim"));
				muhtarlik=(kisiBilgisi.get("il")+" "+kisiBilgisi.get("ilce")+" "+kisiBilgisi.get("mahalle"));
				sandikAlani=(kisiBilgisi.get("sandikAlani"));
				sandikNumarasi=(kisiBilgisi.get("sandikNo"));
				sandikSirasi=(kisiBilgisi.get("sandikSiraNo"));
				
				secimYili=(kisiBilgisi.get("secimYili"));
				eskiListe=(kisiBilgisi.get("eskiListe"));
				
				String[] kunye={isim,muhtarlik,sandikAlani,sandikNumarasi, sandikSirasi, secimYili, eskiListe};
				
				
				if(kisiBilgisi.get("isim")==null){
					
					JSONObject hataBilgisi;
					try {
						hataBilgisi = new JSONObject(string);
						new AlertDialog.Builder(Sorgu.this)
						.setTitle("Bilgi")
						.setMessage(hataBilgisi.getString("HataAciklamasi").toString())
						.setNeutralButton("Tamam",  new DialogInterface.OnClickListener() {
							   public void onClick(DialogInterface dialog, int which) {
								   editSorgu.setText("");
								   }
								}).show();
						
					} catch (JSONException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					
					
					
				}
				else{
					Intent intent= new Intent("com.halici.e_sandikv2.SONUCLAR_LAYOUT");
					intent.putExtra("kunye", kunye);
					intent.putStringArrayListExtra("sandikBilgisi", sandikBilgisi);
					intent.putExtra("binaBilgisi", binaBilgisi);
					startActivity(intent);
					editSorgu.setText("");
				}
			}
			else{
				Toast.makeText(getApplicationContext(), "Üyelik bilgileriniz ile ilgili bir hata oluştu. Lütfen tekrar giriş yapınız.",  Toast.LENGTH_LONG).show();
				Intent intent=new Intent(Sorgu.this,Giris.class);
				startActivity(intent);
			}
				
		}

		@Override
		protected void onPreExecute() {
			 //dialog=ProgressDialog.show(SecmenKunye.this, "Baslik", "Mesaj-Calculating",true);
			
			dialog.setMessage("Lütfen bekleyiniz; seçmen bilgileriniz yükleniyor.");
			dialog.show();
		}

		@Override
		protected void onProgressUpdate(Void... values) {
			
		}
		
	}

	
	
		
		
	

	
}
