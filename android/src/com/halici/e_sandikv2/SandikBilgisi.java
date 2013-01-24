package com.halici.e_sandikv2;


import java.util.ArrayList;


import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.LinearLayout;
import android.widget.ListView;
import android.widget.TextView;


/**
 * @author Abdullah Karacabey
 *
 */
public class SandikBilgisi extends Fragment {

	ArrayList<String> sandikBilgisi;
	View view;
	ListView liste;
	TextView txtSandikNo, txtSecmenSayisi;
	String sandikNo;
	
	
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
		
		view=(LinearLayout)inflater.inflate(R.layout.sandik_bilgisi_layout, container, false);
		sandikBilgisi=((Sonuclar)getActivity()).sandikBilgisi;
		sandikNo=((Sonuclar)getActivity()).sandikNumarasi;
		
		txtSandikNo=(TextView)view.findViewById(R.id.txtSandikNo);
		txtSecmenSayisi=(TextView)view.findViewById(R.id.txtSecmenSayisi);
		
		txtSandikNo.setText("Sandik No: "+sandikNo);
		txtSecmenSayisi.setText("Seçmen Sayısı: "+sandikBilgisi.size());
		
		liste=(ListView)view.findViewById(R.id.listSandik);
		ArrayAdapter<String> adapter=new ArrayAdapter<String>(getActivity(),R.layout.sandik_listesi, R.id.sandikSatir,sandikBilgisi);
		liste.setAdapter(adapter);
		return view;
	}
}

