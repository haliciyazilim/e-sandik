package com.halici.e_sandikv2;

import android.os.Bundle;
import android.app.Activity;
import android.content.Intent;

public class Splash extends Activity {

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.splash);
		
	    new Thread() {
            public void run() {
                try{
                   
                    sleep(1500);
                } catch (Exception e) {
                }
              
                new Thread() {
                    public void run() {
                   
                   Intent sorguyaGec=new Intent(Splash.this, Sorgu.class);
                   startActivity(sorguyaGec);
                   
                    }
                }.start();
            }
        }.start();  
	    
	   
	}

	
}