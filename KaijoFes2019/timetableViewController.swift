//
//  timetableViewController.swift
//  KaijoFes2019
//
//  Created by Bwambocos on 2019/09/01.
//  Copyright © 2019 jp.ed.kaijo.KaijoFes2019. All rights reserved.
//

import UIKit

class timetableViewController: UIViewController
{
	// 変数
	var dataList:[String] = []		// 全データ
	var SideBar = sideBarCommon()
	
    override func viewDidLoad()
	{
        super.viewDidLoad()
		
		// サイドバーの設定
		SideBar.sideBarVC = storyboard?.instantiateViewController(withIdentifier: "sideBar")
		self.addChild(SideBar.sideBarVC)
		self.view.addSubview(SideBar.sideBarVC.view)
		SideBar.initSideBar(view: searchViewController())
		
		// CSV ファイル読み込み
		do
		{
			// CSV ファイルのデータを取得
			let csvData = try String(contentsOfFile: Bundle.main.path(forResource: "eventData", ofType: "csv")!, encoding: String.Encoding.utf8)
			
			// 改行区切りでデータを分割し，配列に格納
			dataList = csvData.components(separatedBy: "*\n")
			dataList.removeLast()
		}
		catch { print(error) }
		
		// "" を削除
		for i in 0 ... (dataList.count - 1) { dataList[i] = dataList[i].replacingOccurrences(of: "\"", with: "") }
    }
	
	//　画面遷移時，サイドバーが出ていれば閉じる
	override func viewWillDisappear(_ animated: Bool)
	{
		if !SideBar.sideBarVC.view.isHidden
		{
			SideBar.closeSideBar()
		}
	}
	
	@IBAction func buttonTimetable(_ sender: Any)
	{
		SideBar.performSideBar()
	}
	
	@objc func sideBar()
	{
		SideBar.performSideBar()
	}
	
	// セグエで詳細ページに移動する際のデータの受け渡し
	override func prepare(for segue: UIStoryboardSegue, sender: Any?)
	{
		// 移動先のビューコントローラの data プロパティに値を設定する
		if segue.identifier != nil
		{
			(segue.destination as! eventDetailViewController).data = sender as! [String]
		}
	}
	
	@IBAction func keion1(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueKeion", sender: dataList[56].components(separatedBy: ","))
	}
	@IBAction func keion2(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueKeion", sender: dataList[42].components(separatedBy: ","))
	}
	@IBAction func keion3(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueKeion", sender: dataList[47].components(separatedBy: ","))
	}
	@IBAction func keion4(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueKeion", sender: dataList[51].components(separatedBy: ","))
	}
	@IBAction func keion5(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueKeion", sender: dataList[45].components(separatedBy: ","))
	}
	@IBAction func keion6(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueKeion", sender: dataList[44].components(separatedBy: ","))
	}
	@IBAction func keion7(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueKeion", sender: dataList[49].components(separatedBy: ","))
	}
	@IBAction func keion8(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueKeion", sender: dataList[59].components(separatedBy: ","))
	}
	@IBAction func keion9(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueKeion", sender: dataList[48].components(separatedBy: ","))
	}
	@IBAction func keion10(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueKeion", sender: dataList[46].components(separatedBy: ","))
	}
	@IBAction func keion11(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueKeion", sender: dataList[43].components(separatedBy: ","))
	}
	@IBAction func keion12(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueKeion", sender: dataList[52].components(separatedBy: ","))
	}
	@IBAction func keion13(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueKeion", sender: dataList[53].components(separatedBy: ","))
	}
	@IBAction func keion14(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueKeion", sender: dataList[50].components(separatedBy: ","))
	}
	@IBAction func keion15(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueKeion", sender: dataList[57].components(separatedBy: ","))
	}
	@IBAction func keion16(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueKeion", sender: dataList[57].components(separatedBy: ","))
	}
	@IBAction func keion17(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueKeion", sender: dataList[46].components(separatedBy: ","))
	}
	@IBAction func keion18(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueKeion", sender: dataList[52].components(separatedBy: ","))
	}
	@IBAction func keion19(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueKeion", sender: dataList[53].components(separatedBy: ","))
	}
	@IBAction func keion20(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueKeion", sender: dataList[50].components(separatedBy: ","))
	}
	@IBAction func keion21(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueKeion", sender: dataList[48].components(separatedBy: ","))
	}
	@IBAction func keion22(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueKeion", sender: dataList[43].components(separatedBy: ","))
	}
	@IBAction func keion23(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueKeion", sender: dataList[51].components(separatedBy: ","))
	}
	@IBAction func keion24(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueKeion", sender: dataList[45].components(separatedBy: ","))
	}
	@IBAction func keion25(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueKeion", sender: dataList[47].components(separatedBy: ","))
	}
	@IBAction func keion26(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueKeion", sender: dataList[44].components(separatedBy: ","))
	}
	@IBAction func keion27(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueKeion", sender: dataList[59].components(separatedBy: ","))
	}
	@IBAction func keion28(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueKeion", sender: dataList[49].components(separatedBy: ","))
	}
	@IBAction func keion29(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueKeion", sender: dataList[42].components(separatedBy: ","))
	}
	@IBAction func stage1(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueStage", sender: dataList[103].components(separatedBy: ","))
	}
	@IBAction func stage2(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueStage", sender: dataList[28].components(separatedBy: ","))
	}
	@IBAction func stage3(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueStage", sender: dataList[31].components(separatedBy: ","))
	}
	@IBAction func stage4(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueStage", sender: dataList[26].components(separatedBy: ","))
	}
	@IBAction func stage5(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueStage", sender: dataList[25].components(separatedBy: ","))
	}
	@IBAction func stage6(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueStage", sender: dataList[23].components(separatedBy: ","))
	}
	@IBAction func stage7(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueStage", sender: dataList[24].components(separatedBy: ","))
	}
	@IBAction func stage8(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueStage", sender: dataList[35].components(separatedBy: ","))
	}
	@IBAction func stage9(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueStage", sender: dataList[30].components(separatedBy: ","))
	}
	@IBAction func stage10(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueStage", sender: dataList[22].components(separatedBy: ","))
	}
	@IBAction func stage11(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueStage", sender: dataList[25].components(separatedBy: ","))
	}
	@IBAction func stage12(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueStage", sender: dataList[26].components(separatedBy: ","))
	}
	@IBAction func stage13(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueStage", sender: dataList[23].components(separatedBy: ","))
	}
	@IBAction func stage14(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueStage", sender: dataList[27].components(separatedBy: ","))
	}
	@IBAction func stage15(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueStage", sender: dataList[35].components(separatedBy: ","))
	}
	@IBAction func sport1(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueSport", sender: dataList[104].components(separatedBy: ","))
	}
	@IBAction func sport2(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueSport", sender: dataList[92].components(separatedBy: ","))
	}
	@IBAction func sport3(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueSport", sender: dataList[67].components(separatedBy: ","))
	}
	@IBAction func sport4(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueSport", sender: dataList[91].components(separatedBy: ","))
	}
	@IBAction func sport5(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueSport", sender: dataList[20].components(separatedBy: ","))
	}
	@IBAction func sport6(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueSport", sender: dataList[80].components(separatedBy: ","))
	}
	@IBAction func sport7(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueSport", sender: dataList[19].components(separatedBy: ","))
	}
	@IBAction func sport8(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueSport", sender: dataList[18].components(separatedBy: ","))
	}
	@IBAction func sport9(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueSport", sender: dataList[79].components(separatedBy: ","))
	}
	@IBAction func sport10(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueSport", sender: dataList[91].components(separatedBy: ","))
	}
	@IBAction func sport11(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueSport", sender: dataList[17].components(separatedBy: ","))
	}
	@IBAction func hall1(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueHall", sender: dataList[32].components(separatedBy: ","))
	}
	@IBAction func hall2(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueHall", sender: dataList[61].components(separatedBy: ","))
	}
	@IBAction func hall3(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueHall", sender: dataList[64].components(separatedBy: ","))
	}
	@IBAction func hall4(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueHall", sender: dataList[36].components(separatedBy: ","))
	}
	@IBAction func hall5(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueHall", sender: dataList[65].components(separatedBy: ","))
	}
	@IBAction func hall6(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueHall", sender: dataList[61].components(separatedBy: ","))
	}
	@IBAction func hall7(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueHall", sender: dataList[32].components(separatedBy: ","))
	}
	@IBAction func hall8(_ sender: Any)
	{
		self.performSegue(withIdentifier: "segueHall", sender: dataList[105].components(separatedBy: ","))
	}
}
