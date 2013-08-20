package com.halici.e_sandikv2;



import java.util.HashMap;


//import com.halici.e_sandikv2.SecmenKunye.Servis;
import com.halici.e_sandikv2.R;
import com.halici.e_sandikv2.SecmenKunye;
import com.halici.e_sandikv2.R.id;
import com.halici.e_sandikv2.R.layout;
import com.halici.e_sandikv2.siniflar.Sorgulama;

import android.app.ProgressDialog;
import android.os.AsyncTask;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentActivity;
import android.util.DisplayMetrics;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.animation.Animation;
import android.view.animation.TranslateAnimation;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.ScrollView;
import android.widget.TextView;


/**
 * @author Abdullah Karacabey
 *
 */
public class SecmenKunye extends Fragment {
	TextView secimBilgisi, txtKimlikNo;
	TextView txtIsim, txtIl, txtIlce, txtMahalle, txtSandikAlani, txtSandikNo, txtSandikSiraNo;
	String secimYili, eskiListe, kimlikNo, isim,muhtarlik, sandikAlani, sandikNumarasi, sandikSirasi;
	View view;
	
	Animation animationAsagi;
	RelativeLayout rlSecimBilgisi;
	ScrollView kunyeListesi;
	public View onCreateView(LayoutInflater inflater, ViewGroup container,
			Bundle savedInstanceState) {
		if (container == null) {
            // We have different layouts, and in one of them this
            // fragment's containing frame doesn't exist.  The fragment
            // may still be created from its saved state, but there is
            // no reason to try to create its view hierarchy because it
            // won't be displayed.  Note this is not needed -- we could
            // just run the code below, where we would create and return
            // the view hierarchy; it would just never be used.
            return null;
        }
		
		
		

	        
		//kimlikNo=((Sonuclar)getActivity()).tckn;
		
		eskiListe=((Sonuclar)getActivity()).eskiListe;
		secimYili=((Sonuclar)getActivity()).secimYili;
		
		isim=((Sonuclar)getActivity()).isim;
		muhtarlik=((Sonuclar)getActivity()).muhtarlik;
		kimlikNo=((Sonuclar)getActivity()).tckn;
		sandikAlani=((Sonuclar)getActivity()).sandikAlani;
		sandikNumarasi=((Sonuclar)getActivity()).sandikNumarasi;
		sandikSirasi=((Sonuclar)getActivity()).sandikSirasi;
		
		System.out.println("Se�men K�nye: "+secimYili+", "+eskiListe);
		
	        
	    //new Servis().execute(kimlikNo);
		
		//isim, muhtarlik, SandikAlani, sandikNumarasi, sandikSirasi;
	        
		view=(RelativeLayout)inflater.inflate(R.layout.kimlik_bilgileri_layout, container, false);
		rlSecimBilgisi=(RelativeLayout)view.findViewById(R.id.rlSecimBilgisi);
		secimBilgisi=(TextView)view.findViewById(R.id.txtSecimBilgisi);
		
		if(!eskiListe.equals(null) && eskiListe.equals("1")){
			
			secimBilgisi.setText("Yeni seçmen bilgileri açıklanmadığı için "+secimYili+" seçimlerine dair bilgiler görüntülenmektedir.");
			
//			secimBilgisi.setText("Bilgiler "+secimYili+" seçimlerine aittir.");
			
			DisplayMetrics metrics=getResources().getDisplayMetrics();
			System.out.println("DPI: "+metrics.density);
			float dpi=metrics.density;
			
			RelativeLayout sayfaBasi=(RelativeLayout)view.findViewById(R.id.rlBaslikKunye);
			sayfaBasi.bringToFront();
			
			animationAsagi = new TranslateAnimation(0,0,0,60*dpi);
			animationAsagi.setDuration(2000);
			animationAsagi.setFillAfter(true);
			rlSecimBilgisi.startAnimation(animationAsagi);
			int sbHeight=secimBilgisi.getHeight();
			
			System.out.println("Heingt: "+sbHeight);
//			
			int indirmeDegeri;
			
			if(dpi==0.75)
				indirmeDegeri=40;
			else
				indirmeDegeri=30;
			
			kunyeListesi=(ScrollView)view.findViewById(R.id.svKunyeBilgileri);
			animationAsagi = new TranslateAnimation(0,0,0,indirmeDegeri*dpi);
			animationAsagi.setDuration(2000);
			animationAsagi.setFillAfter(true);
			animationAsagi.setFillEnabled(true);
			kunyeListesi.startAnimation(animationAsagi);
		}
		
		txtIsim=(TextView)view.findViewById(R.id.txtIsim);
		txtIsim.setText(isim);

		
		txtMahalle=(TextView)view.findViewById(R.id.txtMuhtarlik);
		txtMahalle.setText(muhtarlik);
		
		txtSandikAlani=(TextView)view.findViewById(R.id.txtSandikAlani);
		txtSandikAlani.setText(sandikAlani);
		
		txtSandikNo=(TextView)view.findViewById(R.id.txtSandikNumara);
		txtSandikNo.setText(sandikNumarasi+" / "+sandikSirasi);
		
		
//		TextView txt= (TextView) view.findViewById(R.id.txt);
//		txt.setText(metin);
		return view;
	}
	
	
//	public class Servis extends AsyncTask<String, Void, String>{
//		private ProgressDialog dialog = new ProgressDialog(((Sonuclar)getActivity()));
//		@Override
//		protected String doInBackground(String... params) {
//			Sorgulama sorgu=new Sorgulama(params[0]);
//			String sonuc=sorgu.baglan();
//			return sonuc;
//		}
//
//		@Override
//		protected void onPostExecute(String string) {
//			dialog.dismiss();
//			
//			
//			KisiBilgileri bilgiler=new KisiBilgileri(string);
//			HashMap<String, String> kisiBilgisi=bilgiler.veriAl();
//			
//			txtIsim=(TextView)view.findViewById(R.id.txtIsim);
//			txtIsim.setText(kisiBilgisi.get("isim")+" "+kisiBilgisi.get("soyisim"));
//			//txtIsim.setText("Abdullah Karacabey");
//			System.out.println("��k�tt���: "+kisiBilgisi.get("isim")+" "+kisiBilgisi.get("soyisim"));
//			
//			txtMahalle=(TextView)view.findViewById(R.id.txtMuhtarlik);
//			txtMahalle.setText(kisiBilgisi.get("il")+" "+kisiBilgisi.get("ilce")+" "+kisiBilgisi.get("mahalle"));
//			
//			txtSandikAlani=(TextView)view.findViewById(R.id.txtSandikAlani);
//			txtSandikAlani.setText(kisiBilgisi.get("sandikAlani"));
//			
//			txtSandikNo=(TextView)view.findViewById(R.id.txtSandikNumara);
//			txtSandikNo.setText(kisiBilgisi.get("sandikNo"));
//			
//			txtSandikSiraNo=(TextView)view.findViewById(R.id.txtSandikSirasi);
//			txtSandikSiraNo.setText(kisiBilgisi.get("sandikSiraNo"));
//			
//			
//			
//		}
//
//		@Override
//		protected void onPreExecute() {
//			 //dialog=ProgressDialog.show(SecmenKunye.this, "Baslik", "Mesaj-Calculating",true);
//			
//			dialog.setMessage("BA�lan�yor..");
//			dialog.show();
//		}
//
//		@Override
//		protected void onProgressUpdate(Void... values) {
//			
//		}
//		
//	}
	
	
}

