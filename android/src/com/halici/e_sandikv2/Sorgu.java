package com.halici.e_sandikv2;



import java.util.ArrayList;
import java.util.HashMap;

import com.halici.e_sandikv2.siniflar.AyniBinadakiler;
import com.halici.e_sandikv2.siniflar.AyniSandikdakiler;
import com.halici.e_sandikv2.siniflar.KisiBilgileri;
import com.halici.e_sandikv2.siniflar.Sorgulama;

import android.R.bool;
import android.app.Activity;
import android.app.AlertDialog;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.net.ConnectivityManager;
import android.os.AsyncTask;
import android.os.Bundle;
import android.text.InputFilter;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

public class Sorgu extends Activity {
	public String secimYili, eskiListe, isim, muhtarlik, sandikAlani, sandikNumarasi, sandikSirasi;
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		super.onCreate(savedInstanceState);
		setContentView(R.layout.sorgu);
		
		final EditText editSorgu=(EditText) findViewById(R.id.editSorgu);
		InputFilter[] FilterArray = new InputFilter[1];
		FilterArray[0] = new InputFilter.LengthFilter(11);
		editSorgu.setFilters(FilterArray);
		
		editSorgu.setText("");
		
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
					
					boolean baglanti=baglantiKuntrolu();
					
					if(baglanti==true)
						new Servis().execute(tckn);
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
		
		//android.os.Process.killProcess(android.os.Process.myPid());
		//System.exit(0);
		//finish();
		moveTaskToBack(true);
	}



	public class Servis extends AsyncTask<String, Void, String>{
		private ProgressDialog dialog = new ProgressDialog(Sorgu.this);
		 EditText editSorgu=(EditText) findViewById(R.id.editSorgu);
		@Override
		protected String doInBackground(String... params) {
			Sorgulama sorgu=new Sorgulama(params[0]);
			String sonuc=sorgu.baglan();
			
			System.out.println("Sonuclar sonuc: "+sonuc);
			return sonuc;
		}

		@Override
		protected void onPostExecute(String string) {
			dialog.dismiss();
			
			
			KisiBilgileri bilgiler=new KisiBilgileri(string);
			HashMap<String, String> kisiBilgisi=bilgiler.veriAl();
			
			AyniSandikdakiler bilgiler1=new AyniSandikdakiler(string);
			ArrayList<String> sandikBilgisi=bilgiler1.veriAl();
			
			AyniBinadakiler bilgiler2=new AyniBinadakiler(string);
			ArrayList<HashMap<String, String>> binaBilgisi=bilgiler2.veriAl();
			
			
			// Künye için gerekli bilgiler isim,muhtarlik, sandikAlani, sandikNumarasi, sandikSirasi;
			
			

			isim=(kisiBilgisi.get("isim")+" "+kisiBilgisi.get("soyisim"));
			muhtarlik=(kisiBilgisi.get("il")+" "+kisiBilgisi.get("ilce")+" "+kisiBilgisi.get("mahalle"));
			sandikAlani=(kisiBilgisi.get("sandikAlani"));
			sandikNumarasi=(kisiBilgisi.get("sandikNo"));
			sandikSirasi=(kisiBilgisi.get("sandikSiraNo"));
			
			secimYili=(kisiBilgisi.get("secimYili"));
			eskiListe=(kisiBilgisi.get("eskiListe"));
			
			String[] kunye={isim,muhtarlik,sandikAlani,sandikNumarasi, sandikSirasi, secimYili, eskiListe};
			
			//System.out.println("Sorgu kunye: "+kunye[0]);
			
			if(kisiBilgisi.get("isim")==null){
				
				new AlertDialog.Builder(Sorgu.this)
					.setTitle("Bilgi")
					.setMessage("Girdiğiniz TC kimlik numarasına ait bir kayıt bulunamadı.")
					.setNeutralButton("Tamam",  new DialogInterface.OnClickListener() {
						   public void onClick(DialogInterface dialog, int which) {
							   editSorgu.setText("");
							   }
							}).show();
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

	
	public boolean baglantiKuntrolu() {
        final ConnectivityManager conMgr = (ConnectivityManager) getSystemService (Context.CONNECTIVITY_SERVICE);
        if (conMgr.getActiveNetworkInfo() != null && conMgr.getActiveNetworkInfo().isAvailable() &&    conMgr.getActiveNetworkInfo().isConnected()) {
        	System.out.println("İnternet Baplantısı var");
        	return true;
        } else {
              System.out.println("İnternet Baplantısı yok");
            return false;
        }
     }
		
		
	

	
}
