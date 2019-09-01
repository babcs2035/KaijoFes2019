//
//  eventDetailViewController.swift
//  KaijoFes2019
//
//  Created by Bwambocos on 2019/02/01.
//  Copyright © 2019年 com.babcs2035.kaijofes2019. All rights reserved.
//

import UIKit

class eventDetailViewController: UIViewController
{
    @IBOutlet weak var circleCut: UIImageView!
	@IBOutlet weak var eventName: UILabel!
	@IBOutlet weak var organName: UILabel!
	@IBOutlet weak var placeName: UILabel!
	@IBOutlet weak var eventCategory: UILabel!
	@IBOutlet weak var detailText: UITextView!
	@IBOutlet weak var bookEnable: UIButton!
	@IBOutlet weak var bookLabel: UILabel!
	
    var dataList:[String] = []
    var bookmarkList:[String] = []
    var bookmarkNums:[String] = []
    var userPath:String!	// CSV ファイルの保存先
    let fileManager = FileManager()
    var data:[String] = []	// 検索画面からのデータ受け取り
	var SideBar = sideBarCommon()
	
    override func viewDidLoad()
	{
        super.viewDidLoad()
		
		// サイドバー初期化
		SideBar.sideBarVC = storyboard?.instantiateViewController(withIdentifier: "sideBar")
		self.addChild(SideBar.sideBarVC)
		self.view.addSubview(SideBar.sideBarVC.view)
		SideBar.initSideBar(view: self)
		
        // CSV ファイル読み込み
        do
		{
            // ユーザーが保存した CSV ファイルのパス
            userPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] + "/bookmarks.csv"
            
            var path = userPath
            if !fileManager.fileExists(atPath: path!)
			{
                // ユーザーが保存した CSV ファイルが無い場合は，初期 CSV ファイルから読み込む
                path = Bundle.main.path(forResource: "bookmarks", ofType: "csv")
                let csvData2 = try String(contentsOfFile: path!, encoding: String.Encoding.utf8)
                bookmarkList = csvData2.components(separatedBy: "*\n")
                bookmarkList.removeLast()
            }
			else
			{
                // ユーザーが保存した CSV ファイルのデータを取得する
                let csvData = try String(contentsOfFile: path!, encoding: String.Encoding.utf8)
                bookmarkList = csvData.components(separatedBy: "*\n")
            }
			
            // カンマ区切りでデータを分裂し，配列に格納
            var index = 0;
            while index < bookmarkList.count
            {
                let bookmarkDetail = bookmarkList[index].components(separatedBy: ",")
                bookmarkNums.insert(bookmarkDetail[6], at: index);
                index += 1
            }
        }
		catch
		{
            print(error)
        }
        
        for nums in bookmarkNums
		{
            if String(nums) == String(data[6])
			{
                bookLabel.text = "ブックマーク登録済み"
                bookEnable.isEnabled = false
                break
            }
			else
			{
                bookLabel.text = "ブックマーク未登録"
                bookEnable.isEnabled = true
            }
        }
		
		circleCut.image = UIImage(named: String(data[6]))
		eventName.text = "   " + String(data[1])
		organName.text = data[0]
		if data[3] == "classroom"
		{
			placeName.text = "場所：" + String(data[6]) + "（" + String(data[7]) + "）"
		}
		else if data[7] == "keion"
		{
			placeName.text = "場所はタイムスケジュールをご覧ください"
		}
		else
		{
			placeName.text = "場所：" + String(data[7])
		}
		if data[2] == "expr"
		{
			eventCategory.text = "体験する"
			eventCategory.backgroundColor = UIColor.init(red: 20 / 255, green: 255 / 255, blue: 20 / 255, alpha: 1)
		}
		if data[2] == "learn"
		{
			eventCategory.text = "学ぶ"
			eventCategory.backgroundColor = UIColor.init(red: 20 / 255, green: 20 / 255, blue: 255 / 255, alpha: 1)
		}
		if data[2] == "watch"
		{
			eventCategory.text = "観る"
			eventCategory.backgroundColor = UIColor.init(red: 255 / 255, green: 20 / 255, blue: 20 / 255, alpha: 1)
		}
		if data[2] == "hear"
		{
			eventCategory.text = "聞く"
			eventCategory.backgroundColor = UIColor.init(red: 200 / 255, green: 200 / 255, blue: 120 / 255, alpha: 1)
		}
		if data[2] == "food"
		{
			eventCategory.text = "食品"
			eventCategory.backgroundColor = UIColor.init(red: 100 / 255, green: 100 / 255, blue: 100 / 255, alpha: 1)
		}
		eventCategory.textColor = UIColor.white
		eventCategory.layer.cornerRadius = 5
		eventCategory.clipsToBounds = true
		detailText.text = data[4]
		if !data[5].isEmpty
		{
			detailText.text += "\n\nリンク\n" + String(data[5])
		}
    }
	
	override func didReceiveMemoryWarning()
	{
		super.didReceiveMemoryWarning()
	}
	
	override func viewDidLayoutSubviews()
	{
		super.viewDidLayoutSubviews()
		detailText.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
	}
	
	//　画面遷移時，サイドメニューが出ていれば閉じる
	override func viewWillDisappear(_ animated: Bool)
	{
		if !SideBar.sideBarVC.view.isHidden
		{
			SideBar.closeSideBar()
		}
	}
	
	@IBAction func buttonDetail(_ sender: Any)
	{
		SideBar.performSideBar()
	}
	
    @IBAction func booking(_ sender: Any)
	{
        let dataStr = data.joined(separator: ",")
        bookmarkList.append(dataStr)
        saveCSV()
        bookEnable.isEnabled = false
        bookLabel.text = "ブックマーク登録済み"
        bookedAlert()
    }
    
    // CSV ファイル保存メソッド
    func saveCSV()
	{
        // 改行区切りで部活配列を連結
        let outputStr = bookmarkList.joined(separator: "*\n")
        
        do
		{
            if outputStr == ""
			{
                // 部活配列が空の場合はユーザーが保存した CSV ファイルを削除する
                try fileManager.removeItem(atPath: userPath)
            }
			else
			{
                // ファイルを出力する
                try outputStr.write(toFile: userPath, atomically: false, encoding: String.Encoding.utf8 )
            }
        }
		catch
		{
            print(error)
        }
    }
    
    // ブックマーク登録完了のアラート表示
    func bookedAlert()
	{
        let alert = UIAlertController(title: "ブックマーク登録しました", message: "ホーム画面からいつでもアクセス可能です。", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "完了", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
}
