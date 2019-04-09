//
//  KeionTableViewController.swift
//  KaijoFes2019
//
//  Created by Bwambocos on 2019/04/09.
//  Copyright © 2019 com.babcs2035.kaijofes2019. All rights reserved.
//

import UIKit

class KeionTableViewController: UIViewController, timetableDelegate
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
		SideBar.initSideBar(view: KeionTableViewController())
		self.tabBarController?.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"naviMenu"), style: .plain, target: self, action: #selector(KeionTableViewController.sideBar))
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
		print("Keion!")
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
	
	@IBAction func bNo1(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueKeion", sender: dataList[85].components(separatedBy: ","))
	}
	@IBAction func bHow1(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueKeion", sender: dataList[86].components(separatedBy: ","))
	}
	@IBAction func bUki1(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueKeion", sender: dataList[87].components(separatedBy: ","))
	}
	@IBAction func bSub1(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueKeion", sender: dataList[88].components(separatedBy: ","))
	}
	@IBAction func bInfe1(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueKeion", sender: dataList[89].components(separatedBy: ","))
	}
	@IBAction func bUma1(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueKeion", sender: dataList[90].components(separatedBy: ","))
	}
	@IBAction func bEnh1(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueKeion", sender: dataList[91].components(separatedBy: ","))
	}
	@IBAction func bSea1(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueKeion", sender: dataList[92].components(separatedBy: ","))
	}
	@IBAction func bElt1(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueKeion", sender: dataList[93].components(separatedBy: ","))
	}
	@IBAction func bRe1(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueKeion", sender: dataList[94].components(separatedBy: ","))
	}
	@IBAction func bToki1(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueKeion", sender: dataList[95].components(separatedBy: ","))
	}
	@IBAction func bMusa1(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueKeion", sender: dataList[96].components(separatedBy: ","))
	}
	@IBAction func bPray1(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueKeion", sender: dataList[97].components(separatedBy: ","))
	}
	@IBAction func bUki2(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueKeion", sender: dataList[87].components(separatedBy: ","))
	}
	@IBAction func bMusa2(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueKeion", sender: dataList[96].components(separatedBy: ","))
	}
	@IBAction func bToki2(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueKeion", sender: dataList[95].components(separatedBy: ","))
	}
	@IBAction func bSea2(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueKeion", sender: dataList[92].components(separatedBy: ","))
	}
	@IBAction func bRe2(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueKeion", sender: dataList[94].components(separatedBy: ","))
	}
	@IBAction func bElt2(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueKeion", sender: dataList[93].components(separatedBy: ","))
	}
	@IBAction func bSub2(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueKeion", sender: dataList[88].components(separatedBy: ","))
	}
	@IBAction func bMusa3(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueKeion", sender: dataList[96].components(separatedBy: ","))
	}
	@IBAction func bUma2(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueKeion", sender: dataList[90].components(separatedBy: ","))
	}
	@IBAction func bLore1(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueKeion", sender: dataList[98].components(separatedBy: ","))
	}
	@IBAction func bPray2(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueKeion", sender: dataList[97].components(separatedBy: ","))
	}
	@IBAction func bEnh2(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueKeion", sender: dataList[91].components(separatedBy: ","))
	}
	@IBAction func bHow2(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueKeion", sender: dataList[86].components(separatedBy: ","))
	}
	@IBAction func bLore2(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueKeion", sender: dataList[98].components(separatedBy: ","))
	}
	@IBAction func bInfe2(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueKeion", sender: dataList[89].components(separatedBy: ","))
	}
	@IBAction func bNo2(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueKeion", sender: dataList[85].components(separatedBy: ","))
	}
	@IBAction func bHow3(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueKeion", sender: dataList[86].components(separatedBy: ","))
	}
	@IBAction func bSea3(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueKeion", sender: dataList[92].components(separatedBy: ","))
	}
	@IBAction func bElt3(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueKeion", sender: dataList[93].components(separatedBy: ","))
	}
}
