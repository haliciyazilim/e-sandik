package com.halici.e_sandikv2;


import java.util.ArrayList;
import java.util.HashMap;

import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.LinearLayout;
import android.widget.ListView;
import android.widget.SimpleAdapter;


/**
 * @author mwho
 *
 */
public class BinaBilgisi extends Fragment {

	
	ArrayList<HashMap<String, String>> binaBilgisi;
	
	View view;
	ListView liste;
	
	
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
		
		view=(LinearLayout)inflater.inflate(R.layout.bina_bilgisi_layout, container, false);
		binaBilgisi=((Sonuclar)getActivity()).binaBilgisi;
		String[] sutunIsim ={"isim","kapiNo"};
		//System.out.println("Bina BÝlgisi: "+binaBilgisi.size());
		
		for(int i=0; i<binaBilgisi.size();i++){
			HashMap<String,String> map = binaBilgisi.get(i);
			System.out.println("bina Bilgisi tekil isim: "+map.get("isim")+map.get("kapiNo"));
			ArrayList<HashMap<String, String>> mylistData =new ArrayList<HashMap<String, String>>();
		}
//		for(int i=0; i<binaBilgisi.size(); i++){
//			HashMap<String,String> map = new HashMap<String, String>();
//			map.put(sutunIsim[0], binaBilgisi.get("isim"));
//			map.put(sutunIsim[1], binaBilgisi.get("kapiNo"));
//			
//			mylistData.add(map);
//		}
		
		
		int[] sutunNo = new int[] {R.id.column1, R.id.column2};
		
		liste=(ListView)view.findViewById(R.id.listBina);
		SimpleAdapter adapter=new SimpleAdapter(getActivity(),binaBilgisi, R.layout.bina_listesi,sutunIsim,sutunNo);
		liste.setAdapter(adapter);
		return view;
	}
}

