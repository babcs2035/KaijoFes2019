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
    @IBOutlet weak var bookEnable: UIButton!
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var organName: UILabel!
    @IBOutlet weak var detailText: UITextView!
    @IBOutlet weak var placeCode: UILabel!
    @IBOutlet weak var placeName: UILabel!
    @IBOutlet weak var bookedLabel: UILabel!
	
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
		
        let gradientLayer:CAGradientLayer = CAGradientLayer()
        let startColor = UIColor(red: 255/255.0, green: 247/255.0, blue: 99/255.0, alpha: 0.8).cgColor
        let endColor = UIColor(red: 255/255.0, green: 186/255.0, blue: 36/255.0, alpha: 0.8).cgColor
        gradientLayer.colors = [startColor, endColor]
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
		
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
                bookmarkNums.insert(bookmarkDetail[0], at: index);
                index += 1
            }
        }
		catch
		{
            print(error)
        }
        
        for nums in bookmarkNums
		{
            if String(nums) == String(data[0])
			{
                bookedLabel.text = "ブックマーク登録済み"
                bookEnable.isEnabled = false
                break
            }
			else
			{
                bookedLabel.text = "ブックマーク未登録"
                bookEnable.isEnabled = true
            }
        }
		
		circleCut.image = UIImage(named: String(data[6]))
		eventName.text = "   " + String(data[1])
		organName.text = data[0]
		placeCode.text = "コード：" + String(data[6])
		placeName.text = "場所：" + String(data[7])
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
		detailText.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
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
        bookedLabel.text = "ブックマーク登録済み"
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
