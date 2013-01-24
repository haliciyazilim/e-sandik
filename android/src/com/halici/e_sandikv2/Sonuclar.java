package com.halici.e_sandikv2;


import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;


import android.app.ProgressDialog;
import android.content.Context;
import android.content.res.Resources;
import android.os.AsyncTask;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentActivity;
import android.support.v4.app.FragmentTransaction;
import android.view.View;
import android.widget.EditText;
import android.widget.TabHost;
import android.widget.TextView;
import android.widget.TabHost.TabContentFactory;


/**
 * @author Abdullah Karacabey
 *
 */
public class Sonuclar extends FragmentActivity implements TabHost.OnTabChangeListener, Serializable {

	private TabHost mTabHost;
	private HashMap mapTabInfo = new HashMap();
	private TabInfo mLastTab = null;
	
	public String secimYili, eskiListe,kunye, tckn, isim, muhtarlik, sandikAlani, sandikNumarasi, sandikSirasi;
	public ArrayList<String> sandikBilgisi;
	public ArrayList<HashMap<String, String>> binaBilgisi;
	
	

	private class TabInfo {
		 private String tag;
         private Class clss;
         private Bundle args;
         private Fragment fragment;
         TabInfo(String tag, Class clazz, Bundle args) {
        	 this.tag = tag;
        	 this.clss = clazz;
        	 this.args = args;
         }

	}

	class TabFactory implements TabContentFactory {

		private final Context mContext;

	    /**
	     * @param context
	     */
	    public TabFactory(Context context) {
	        mContext = context;
	    }

	    /** (non-Javadoc)
	     * @see android.widget.TabHost.TabContentFactory#createTabContent(java.lang.String)
	     */
	    public View createTabContent(String tag) {
	        View v = new View(mContext);
	        v.setMinimumWidth(0);
	        v.setMinimumHeight(0);
	        return v;
	    }

	}
	/** (non-Javadoc)
	 * @see android.support.v4.app.FragmentActivity#onCreate(android.os.Bundle)
	 */
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		
		
		
		// Künye Bilgileri
		String[] kunyeBilgisi=getIntent().getStringArrayExtra("kunye");
		
		//System.out.println("Sonu�lar K�nye: "+gelenVeri[0]);
		
		//String[] kunye={isim,muhtarlik,sandikAlani,sandikNumarasi, sandikSirasi};
		
		isim=kunyeBilgisi[0];
		muhtarlik=kunyeBilgisi[1];
		sandikAlani=kunyeBilgisi[2];
		sandikNumarasi=kunyeBilgisi[3];
		sandikSirasi=kunyeBilgisi[4];
		secimYili=kunyeBilgisi[5]==null?"":kunyeBilgisi[5];
		eskiListe=kunyeBilgisi[6]==null?"":kunyeBilgisi[6];
		
		// Ayn� Sand�ktakiler Bilgisi
		sandikBilgisi=getIntent().getStringArrayListExtra("sandikBilgisi");
		
		// Ayn� Binadakilerin Bilgisi
		binaBilgisi=(ArrayList<HashMap<String, String>>)getIntent().getSerializableExtra("binaBilgisi");
		System.out.println("Sonuclar B�na Bilgisi: "+binaBilgisi.size());
		//System.out.println("Sonuclar: "+sandikBilgisi.get(0));
		
		// Step 1: Inflate layout
		setContentView(R.layout.sonuclar_layout);
		// Step 2: Setup TabHost
		initialiseTabHost(savedInstanceState);
		if (savedInstanceState != null) {
            mTabHost.setCurrentTabByTag(savedInstanceState.getString("tab")); //set the tab as per the saved state
        }
		
		
		
		 
	}

	/** (non-Javadoc)
     * @see android.support.v4.app.FragmentActivity#onSaveInstanceState(android.os.Bundle)
     */
    protected void onSaveInstanceState(Bundle outState) {
        outState.putString("tab", mTabHost.getCurrentTabTag()); //save the tab selected
        super.onSaveInstanceState(outState);
    }

	/**
	 * Step 2: Setup TabHost
	 */
	private void initialiseTabHost(Bundle args) {
		mTabHost = (TabHost)findViewById(android.R.id.tabhost);
        mTabHost.setup();
        TabInfo tabInfo = null;
        Sonuclar.addTab(this, this.mTabHost, this.mTabHost.newTabSpec("Tab1").setIndicator("Künye", getResources().getDrawable(R.drawable.icon_kisi_bilgisi)), ( tabInfo = new TabInfo("Tab1", SecmenKunye.class, args)));
        this.mapTabInfo.put(tabInfo.tag, tabInfo);
        Sonuclar.addTab(this, this.mTabHost, this.mTabHost.newTabSpec("Tab2").setIndicator("Bina Bilgisi",getResources().getDrawable(R.drawable.icon_bina_bilgisi)), ( tabInfo = new TabInfo("Tab2", BinaBilgisi.class, args)));
        this.mapTabInfo.put(tabInfo.tag, tabInfo);
        Sonuclar.addTab(this, this.mTabHost, this.mTabHost.newTabSpec("Tab3").setIndicator("Sandık Bilgisi",getResources().getDrawable(R.drawable.icon_sandik_bilgisi)), ( tabInfo = new TabInfo("Tab3", SandikBilgisi.class, args)));
        this.mapTabInfo.put(tabInfo.tag, tabInfo);
        // Default to first tab
        this.onTabChanged("Tab1");
        //
        mTabHost.setOnTabChangedListener(this);
	}

	/**
	 * @param activity
	 * @param tabHost
	 * @param tabSpec
	 * @param clss
	 * @param args
	 */
	private static void addTab(Sonuclar activity, TabHost tabHost, TabHost.TabSpec tabSpec, TabInfo tabInfo) {
		// Attach a Tab view factory to the spec
		tabSpec.setContent(activity.new TabFactory(activity));
        String tag = tabSpec.getTag();

        // Check to see if we already have a fragment for this tab, probably
        // from a previously saved state.  If so, deactivate it, because our
        // initial state is that a tab isn't shown.
        tabInfo.fragment = activity.getSupportFragmentManager().findFragmentByTag(tag);
        if (tabInfo.fragment != null && !tabInfo.fragment.isDetached()) {
            FragmentTransaction ft = activity.getSupportFragmentManager().beginTransaction();
            ft.detach(tabInfo.fragment);
            ft.commit();
            activity.getSupportFragmentManager().executePendingTransactions();
        }

        tabHost.addTab(tabSpec);
	}

	/** (non-Javadoc)
	 * @see android.widget.TabHost.OnTabChangeListener#onTabChanged(java.lang.String)
	 */
	public void onTabChanged(String tag) {
		TabInfo newTab = (TabInfo) this.mapTabInfo.get(tag);
		if (mLastTab != newTab) {
			FragmentTransaction ft = this.getSupportFragmentManager().beginTransaction();
            if (mLastTab != null) {
                if (mLastTab.fragment != null) {
                	ft.detach(mLastTab.fragment);
                }
            }
            if (newTab != null) {
                if (newTab.fragment == null) {
                    newTab.fragment = Fragment.instantiate(this,
                            newTab.clss.getName(), newTab.args);
                    ft.add(R.id.realtabcontent, newTab.fragment, newTab.tag);
                } else {
                    ft.attach(newTab.fragment);
                }
            }

            mLastTab = newTab;
            ft.commit();
            this.getSupportFragmentManager().executePendingTransactions();
		}
    }

	@Override
	public void onBackPressed() {
		// TODO Auto-generated method stub
		super.onBackPressed();
		
	}

	
}
