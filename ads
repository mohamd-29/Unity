using UnityEngine;
using GoogleMobileAds.Api;
using System;
using UnityEngine.SceneManagement;
using UnityEngine.UI; 

//AdsManager.Instance.ShowInterstitial(); za druge skripte call
//AdsManager.Instance.ShowVideoReward();  za druge skripte call

public class AdsManager : MonoBehaviour
{
	public Text noofbbbt;
	public static  bool failedToload; 
	public Button k; 
	public GameObject es;
	public GameObject fg;
	public GameObject fg2;
	private ScoreC thesc;
	//public enemySpawner es;
	public GameObject player; public GameObject er; 
	public string scene;
	public  AdPosition af;
	public bool ac;
	#region AdMob
	[Header("Admob")]
	private string adMobAppID = "ca-app-pub-6799806859439255~5201629675"; //HERE
	private string videoAdMobId = "ca-app-pub-3940256099942544/5224354917";
	private BannerView bannerView;
	private RewardedAd rewardedAd;
	InterstitialAd interstitialAdMob;
	//private RewardBasedVideoAd rewardBasedAdMobVideo;
	AdRequest requestAdMobInterstitial, AdMobVideoRequest;
	#endregion
	[Space(15)]
	private bool load = false;
	private bool load2 = false;


	static AdsManager instance;
	public static AdsManager Instance
	{
		get
		{
			if (instance == null)
				instance = GameObject.FindObjectOfType(typeof(AdsManager)) as AdsManager;

			return instance;
		}
	}
	void Update()
    {
		if(load==true)
        {
			SceneManager.LoadScene(scene);
			PlayerMovment.health = 100;
			atatck.noofb = 10;
			load = false;
        }
		if (load2 == true)
		{
			er.SetActive(false);

			player.SetActive(true);
			es.SetActive(true);
			k.gameObject.SetActive(false);
			fg.gameObject.SetActive(true); fg2.gameObject.SetActive(true);
			PlayerMovment.health = 50;
			thesc.scoreInc = true;
			atatck.noofb = 2;
			noofbbbt.text = "" + atatck.noofb;
			load2 = false; 
		}
	}

	void Awake()
	{
		gameObject.name = this.GetType().Name;
		thesc = FindObjectOfType<ScoreC>();
		InitializeAds();
	}

	public void ShowInterstitial()
	{
		ShowAdMob();
	}



	private void RequestInterstitial()
	{
		// Initialize an InterstitialAd.
		interstitialAdMob = new InterstitialAd("ca-app-pub-6799806859439255/8990214338");

		// Called when an ad request has successfully loaded.
		interstitialAdMob.OnAdLoaded += HandleOnAdLoaded;
		// Called when an ad request failed to load.
		interstitialAdMob.OnAdFailedToLoad += HandleOnAdFailedToLoad;
		// Called when an ad is shown.
		interstitialAdMob.OnAdOpening += HandleOnAdOpened;
		// Called when the ad is closed.
		interstitialAdMob.OnAdClosed += HandleOnAdClosed;
		// Called when the ad click caused the user to leave the application.
	//	interstitialAdMob.OnAdLeavingApplication += HandleOnAdLeavingApplication;

		// Create an empty ad request.
		requestAdMobInterstitial = new AdRequest.Builder().Build();
		// Load the interstitial with the request.
		interstitialAdMob.LoadAd(requestAdMobInterstitial);
	}

	public void ShowAdMob()
	{
		if (interstitialAdMob.IsLoaded())
		{
			interstitialAdMob.Show();
		}
		else
		{
			interstitialAdMob.LoadAd(requestAdMobInterstitial);

		}
	}
	public void h ()
    {
		Invoke("g", 0.3f); 
    }
	public void g ()
    {
		if (load ==false)
        {
			SceneManager.LoadScene(scene);
			PlayerMovment.health = 100;
			atatck.noofb = 10;
		}
    }
		public void HandleOnAdLoaded(object sender, EventArgs args)
		{
			MonoBehaviour.print("HandleAdLoaded event received");

		}

		public void HandleOnAdFailedToLoad(object sender, AdFailedToLoadEventArgs args)
		{
			
			MonoBehaviour.print("HandleFailedToReceiveAd event received with message: ");
		
		}

		public void HandleOnAdOpened(object sender, EventArgs args)
		{
			MonoBehaviour.print("HandleAdOpened event received");
		}

		public void HandleOnAdClosed(object sender, EventArgs args)
		{
		
			MonoBehaviour.print("HandleAdClosed event received");
		//interstitialAdMob.LoadAd(requestAdMobInterstitial);
		load = true;
		
		interstitialAdMob.Destroy();
		}

		public void HandleOnAdLeavingApplication(object sender, EventArgs args)
		{
			MonoBehaviour.print("HandleAdLeftApplication event received");
		}
	
	

	void InitializeAds()
	{
		MobileAds.Initialize(initStatus => { });
		if (ac)
		{
			this.RequestBanner();
		}
	//	this.rewardBasedAdMobVideo = RewardBasedVideoAd.Instance;
	//	this.RequestRewardedVideo();
		RequestInterstitial();
		RequestReward();
	}


	void AdMobShowVideo()
	{
	//	rewardBasedAdMobVideo.Show();
	}




	private void RequestBanner()
	{
		// Create a 320x50 banner at the top of the screen.
		bannerView = new BannerView("ca-app-pub-6799806859439255/5213237962", AdSize.Banner, af);

		// Called when an ad request has successfully loaded.
		bannerView.OnAdLoaded += HandleBannerOnAdLoaded;
		// Called when an ad request failed to load.
		bannerView.OnAdFailedToLoad += HandleBannerOnAdFailedToLoad;
		// Called when an ad is clicked.
		bannerView.OnAdOpening += HandleBannerOnAdOpened;
		// Called when the user returned from the app after an ad click.
		bannerView.OnAdClosed += HandleBannerOnAdClosed;
		// Called when the ad click caused the user to leave the application.
	//	bannerView.OnAdLeavingApplication += HandleBannerOnAdLeavingApplication;

		// Create an empty ad request.
		AdRequest request = new AdRequest.Builder().Build();

		// Load the banner with the request.
		bannerView.LoadAd(request);
	}
	public void RequestReward ()
    {
		this.rewardedAd = new RewardedAd("ca-app-pub-6799806859439255/6750423172");
		// Called when an ad request has successfully loaded.
		this.rewardedAd.OnAdLoaded += HandleRewardedAdLoaded;
		// Called when an ad request failed to load.
		this.rewardedAd.OnAdFailedToLoad += HandleRewardedAdFailedToLoad;
		// Called when an ad is shown.
		this.rewardedAd.OnAdOpening += HandleRewardedAdOpening;
		// Called when an ad request failed to show.
		this.rewardedAd.OnAdFailedToShow += HandleRewardedAdFailedToShow;
		// Called when the user should be rewarded for interacting with the ad.
		this.rewardedAd.OnUserEarnedReward += HandleUserEarnedReward;
		// Called when the ad is closed.
		this.rewardedAd.OnAdClosed += HandleRewardedAdClosed;
		AdRequest request = new AdRequest.Builder().Build();
		// Load the rewarded ad with the request.
		this.rewardedAd.LoadAd(request);
	}
	public void UserChoseToWatchAd()
	{
		if (this.rewardedAd.IsLoaded())
		{
			this.rewardedAd.Show();
		}
	}
	public void HandleRewardedAdLoaded(object sender, EventArgs args)
	{
		MonoBehaviour.print("HandleRewardedAdLoaded event received");
		failedToload = false; 
	}

	public void HandleRewardedAdFailedToLoad(object sender, AdFailedToLoadEventArgs args)
	{
		MonoBehaviour.print("HandleRewardedAdFailedToLoad event received with message: ");
		failedToload = true; 
	}

	public void HandleRewardedAdOpening(object sender, EventArgs args)
	{
		MonoBehaviour.print("HandleRewardedAdOpening event received");
	}

	public void HandleRewardedAdFailedToShow(object sender, AdErrorEventArgs args)
	{
		MonoBehaviour.print(
			"HandleRewardedAdFailedToShow event received with message: "
							);
	}

	public void HandleRewardedAdClosed(object sender, EventArgs args)
	{
		MonoBehaviour.print("HandleRewardedAdClosed event received");
	

	}

	public void HandleUserEarnedReward(object sender, Reward args)
	{
	/*	GameObject a = Instantiate(player) as GameObject;
		a.transform.position = new Vector2(gameObject.transform.position.x, gameObject.transform.position.y);*/
		string type = args.Type;
		double amount = args.Amount;
		MonoBehaviour.print(
			"HandleRewardedAdRewarded event received for "
						+ amount.ToString() + " " + type);
		load2 = true;
	}
	public void HandleBannerOnAdLoaded(object sender, EventArgs args)
	{
		MonoBehaviour.print("HandleAdLoaded event received");
		//bannerView.Show();
	}

	public void HandleBannerOnAdFailedToLoad(object sender, AdFailedToLoadEventArgs args)
	{
		MonoBehaviour.print("HandleFailedToReceiveAd event received with message: "
			);
	}

	public void HandleBannerOnAdOpened(object sender, EventArgs args)
	{
		MonoBehaviour.print("HandleAdOpened event received");
	}

	public void HandleBannerOnAdClosed(object sender, EventArgs args)
	{
		MonoBehaviour.print("HandleAdClosed event received");
		
	}

	public void HandleBannerOnAdLeavingApplication(object sender, EventArgs args)
	{
		MonoBehaviour.print("HandleAdLeftApplication event received");
	}
	
}
//AdsManager.Instance.ShowInterstitial(); za druge skripte call
//AdsManager.Instance.ShowVideoReward();  za druge skripte call
