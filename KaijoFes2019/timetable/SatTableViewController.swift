//
//  SatTableViewController.swift
//  KaijoFes2019
//
//  Created by Bwambocos on 2019/04/09.
//  Copyright © 2019 com.babcs2035.kaijofes2019. All rights reserved.
//

import UIKit

class SatTableViewController: UIViewController, timetableDelegate
{
	@IBOutlet weak var scrollView: UIScrollView!
	@IBOutlet weak var imageView: UIImageView!
	
	var dataList:[String] = []
	var SideBar = sideBarCommon()
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		
		// サイドバー初期化
		SideBar.sideBarVC = storyboard?.instantiateViewController(withIdentifier: "sideBar")
		self.addChild(SideBar.sideBarVC)
		self.view.addSubview(SideBar.sideBarVC.view)
		SideBar.initSideBar(view: SatTableViewController())
		self.tabBarController?.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"naviMenu"), style: .plain, target: self, action: #selector(SatTableViewController.sideBar))
		SideBar.closeSideBar()
		
		// CSV ファイル読み込み
		do
		{
			// CSV ファイルのパス名を取得
			let csvPath = Bundle.main.path(forResource: "eventData", ofType: "csv")
			
			// CSV ファイルのデータを取得
			let csvData = try String(contentsOfFile: csvPath!, encoding: String.Encoding.utf8)
			
			// 改行区切りでデータを分割し，配列に格納
			dataList = csvData.components(separatedBy: "\n")
			dataList.removeLast()
		}
		catch
		{
			print(error)
		}
	}
	
	override func didReceiveMemoryWarning()
	{
		super.didReceiveMemoryWarning()
	}
	
	//　画面遷移時，サイドバーが出ていれば閉じる
	override func viewWillDisappear(_ animated: Bool)
	{
		if !SideBar.sideBarVC.view.isHidden
		{
			SideBar.closeSideBar()
		}
	}
	
	func didSelectTab(timetableDelegate: timetableController)
	{
		print("Sat!")
	}
	
	@objc func sideBar()
	{
		SideBar.performSideBar()
	}
	
	func viewForZooming(in scrollView: UIScrollView) -> UIView?
	{
		return imageView
	}
	
	// セグエで詳細ページに移動する際のデータの受け渡し
	override func prepare(for segue: UIStoryboardSegue, sender: Any?)
	{
		// 移動先のビューコントローラの data プロパティに値を設定する
		(segue.destination as! eventDetailViewController).data = sender as! [String]
	}
	
	@IBAction func bKaijo(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueSat", sender: dataList[60].components(separatedBy: ","))
	}
	@IBAction func bTeacher(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueSat", sender: dataList[61].components(separatedBy: ","))
	}
	@IBAction func bIntro(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueSat", sender: dataList[62].components(separatedBy: ","))
	}
	@IBAction func mMrms(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueSat", sender: dataList[63].components(separatedBy: ","))
	}
	@IBAction func bVsfes(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueSat", sender: dataList[64].components(separatedBy: ","))
	}
	@IBAction func bKWE(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueSat", sender: dataList[65].components(separatedBy: ","))
	}
	@IBAction func bBase(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueSat", sender: dataList[70].components(separatedBy: ","))
	}
	@IBAction func bLac(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueSat", sender: dataList[71].components(separatedBy: ","))
	}
	@IBAction func bTennis(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueSat", sender: dataList[74].components(separatedBy: ","))
	}
	@IBAction func bAct(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueSat", sender: dataList[76].components(separatedBy: ","))
	}
	@IBAction func bVio(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueSat", sender: dataList[77].components(separatedBy: ","))
	}
	@IBAction func bAcca(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueSat", sender: dataList[78].components(separatedBy: ","))
	}
	@IBAction func bCourt(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueSat", sender: dataList[79].components(separatedBy: ","))
	}
	@IBAction func bBad(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueSat", sender: dataList[82].components(separatedBy: ","))
	}
}
