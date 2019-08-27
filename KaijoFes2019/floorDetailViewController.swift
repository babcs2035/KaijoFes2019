//
//  floorDetailViewController
//  KaijoFes2019
//
//  Created by Bwambocos on 2019/02/01.
//  Copyright © 2019年 com.babcs2035.kaijofes2019. All rights reserved.
//

import UIKit

class floorDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
	@IBOutlet weak var eventTable: UITableView!
	var param:String = ""
	
	// 変数
	var originList:[String] = []		// 全データ
	var displayList:[String] = []       // 表示するデータ
	var SideBar = sideBarCommon()
	
    override func viewDidLoad()
	{
        super.viewDidLoad()
		
		// サイドバーの設定
		SideBar.sideBarVC = storyboard?.instantiateViewController(withIdentifier: "sideBar")
		self.addChild(SideBar.sideBarVC)
		self.view.addSubview(SideBar.sideBarVC.view)
		SideBar.initSideBar(view: floorDetailViewController())
		
		// タイトルをセット
		if param == "1" { self.navigationItem.title = "１号館" }
		if param == "2" { self.navigationItem.title = "２号館" }
		if param == "3" { self.navigationItem.title = "３号館" }
		if param == "4" { self.navigationItem.title = "４号館" }
		if param == "5" { self.navigationItem.title = "５号館" }
		if param == "6" { self.navigationItem.title = "６号館" }
		
		// デリゲート先の設定
		eventTable.delegate = self
		eventTable.dataSource = self
		
        // CSV ファイル読み込み
        do
		{
			// CSV ファイルのデータを取得
			let csvData = try String(contentsOfFile: Bundle.main.path(forResource: "eventData", ofType: "csv")!, encoding: String.Encoding.utf8)
			
			// 改行区切りでデータを分割し，配列に格納
			originList = csvData.components(separatedBy: "*\n")
			originList.removeLast()
        }
		catch { print(error) }
		
		// "" を削除
		for i in 0 ... (originList.count - 1) { originList[i] = originList[i].replacingOccurrences(of: "\"", with: "") }
		
		for list in originList
		{
			let details = list.components(separatedBy: ",")
			if (details[6].prefix(1) == param)
			{
				displayList.append(list)
			}
		}
		originList = displayList
		
		// テーブル再表示
		eventTable.reloadData()
    }
	
	// テーブルのセクション数を設定
	func numberOfSections(in tableView: UITableView) -> Int
	{
		return 1
	}
	
	// テーブルの行数を設定
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		return displayList.count
	}
	
	// テーブルのセルを設定
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
	{
		let cell = self.eventTable.dequeueReusableCell(withIdentifier: "eventCellOnFloorDetail", for: indexPath) as? eventTableViewCell
		let details = displayList[indexPath.row].components(separatedBy: ",")
		cell?.eventName.text = details[1]
		cell?.eventDetail.text = details[4]
		cell?.eventOrgan.text = details[0]
		cell?.eventImage.image = UIImage(named: String(details[6]))
		cell?.eventImage.layer.cornerRadius = 10
		if details[2] == "expr"
		{
			cell?.eventCategory.text = "体験する"
			cell?.eventCategory.backgroundColor = UIColor.init(red: 20 / 255, green: 255 / 255, blue: 20 / 255, alpha: 1)
		}
		if details[2] == "learn"
		{
			cell?.eventCategory.text = "学ぶ"
			cell?.eventCategory.backgroundColor = UIColor.init(red: 20 / 255, green: 20 / 255, blue: 255 / 255, alpha: 1)
		}
		if details[2] == "watch"
		{
			cell?.eventCategory.text = "観る"
			cell?.eventCategory.backgroundColor = UIColor.init(red: 255 / 255, green: 20 / 255, blue: 20 / 255, alpha: 1)
		}
		if details[2] == "hear"
		{
			cell?.eventCategory.text = "聞く"
			cell?.eventCategory.backgroundColor = UIColor.init(red: 200 / 255, green: 200 / 255, blue: 120 / 255, alpha: 1)
		}
		cell?.eventCategory.textColor = UIColor.white
		cell?.eventCategory.layer.cornerRadius = 5
		cell?.eventCategory.clipsToBounds = true
		return cell!
	}
	
	// Cell が選択された時の処理
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
	{
		// セルの選択解除
		tableView.deselectRow(at: indexPath, animated: true)
		
		// 指定した ID の Segue を初期化
		self.performSegue(withIdentifier: "showDetailFromFloor", sender: displayList[(indexPath as NSIndexPath).row].components(separatedBy: ","))
	}
	
	// セグエで詳細ページに移動する際のデータの受け渡し
	override func prepare(for segue: UIStoryboardSegue, sender: Any?)
	{
		// セグエが showDetailFromFloor の時の処理
		if segue.identifier == "showDetailFromFloor"
		{
			// 移動先のビューコントローラの data プロパティに値を設定する
			(segue.destination as! eventDetailViewController).data = sender as! [String]
		}
	}
	
    //　画面遷移時，サイドバーが出ていれば閉じる
    override func viewWillDisappear(_ animated: Bool)
	{
		if !SideBar.sideBarVC.view.isHidden
		{
			SideBar.closeSideBar()
		}
    }
	
    override func didReceiveMemoryWarning()
	{
        super.didReceiveMemoryWarning()
    }
	
    @objc func sideBar()
	{
        // サイドメニューが表示されていない時
        if SideBar.sideBarVC.view.isHidden
		{
            // サイドメニューを出す
            SideBar.displaySideBar()
        }
		// サイドメニューが表示されている時
        else
		{
            // サイドメニューを閉じる
            SideBar.closeSideBar()
        }
    }
}
