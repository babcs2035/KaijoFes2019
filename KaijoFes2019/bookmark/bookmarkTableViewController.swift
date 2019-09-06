//
//  bookmarkTableViewController.swift
//  KaijoFes2019
//
//  Created by Bwambocos on 2019/02/01.
//  Copyright © 2019年 jp.ed.kaijo.KaijoFes2019. All rights reserved.
//

import UIKit

class bookmarkTableViewController: UITableViewController
{
    @IBOutlet var bookmarkTable: UITableView!
    
    var bookmarkList:[String] = []        // ブックマーク配列
    var userPath:String!                  // CSVファイルの保存先
    let fileManager = FileManager()

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // CSV ファイル読み込み
        do
        {
            // ユーザーが保存した CSV ファイルのパス
            userPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] + "/bookmarks.csv"
            
            var path = userPath
            
            // ユーザーが保存した CSV ファイルが無い場合
            if (fileManager.fileExists(atPath: path!) == false)
            {
                // 初期 CSV ファイルから読込
                path = Bundle.main.path(forResource: "bookmarks", ofType: "csv")
                let csvData = try String(contentsOfFile: path!, encoding: String.Encoding.utf8)
                let temp = csvData.components(separatedBy: "*\n")
                bookmarkList = temp
                // 原因不明のバグを直すための調整
                bookmarkList.removeLast()
            }
                // ユーザーが保存した CSV ファイルがある場合
            else
            {
                // ユーザーが保存した CSV ファイルのデータを取得
                let csvData = try String(contentsOfFile: path!, encoding: String.Encoding.utf8)
                bookmarkList = csvData.components(separatedBy: "*\n")
            }
            
            // 編集ボタン作成
            navigationItem.rightBarButtonItem = editButtonItem
            
        } catch { print(error) }
    }
    
    // テーブルのセクション数を設定
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    // テーブルの行数を設定
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return bookmarkList.count
    }
    
    // テーブルのセルを設定
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
		let cell = self.bookmarkTable.dequeueReusableCell(withIdentifier: "bookmarkCell", for: indexPath) as? bookmarkTableViewCell
		let details = bookmarkList[indexPath.row].components(separatedBy: ",")
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
		if details[2] == "food"
		{
			cell?.eventCategory.text = "食品"
			cell?.eventCategory.backgroundColor = UIColor.init(red: 100 / 255, green: 100 / 255, blue: 100 / 255, alpha: 1)
		}
		cell?.eventCategory.textColor = UIColor.white
		cell?.eventCategory.layer.cornerRadius = 5
		cell?.eventCategory.clipsToBounds = true
		return cell!
    }
	
	// Cell 選択時の処理
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
	{
		tableView.deselectRow(at: indexPath, animated: true)
		if (bookmarkList.count > 0)
		{
			// 指定した ID の Segue を初期化
			self.performSegue(withIdentifier: "showDetail", sender: bookmarkList[(indexPath as NSIndexPath).row].components(separatedBy: ","))
		}
	}
	
	// 編集モードを設定
	override func setEditing(_ editing: Bool, animated: Bool)
	{
		super.setEditing(editing, animated: animated)
		tableView.isEditing = editing
	}
	
	// テーブルビューを編集
	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
	{
		if (editingStyle == .delete)
		{
			bookmarkList.remove(at: indexPath.row)
			tableView.deleteRows(at: [indexPath], with: .fade)
		}
		
		// 改行区切りで団体配列を連結
		let outputStr = bookmarkList.joined(separator: "*\n")
		
		do
		{
			// 団体配列が空の場合
			if (outputStr == "")
			{
				// ユーザーが保存した CSV ファイルを削除
				try fileManager.removeItem(atPath: userPath)
			}
			else
			{
				// ファイルを出力
				try outputStr.write(toFile: userPath, atomically: false, encoding: String.Encoding.utf8)
			}
		} catch { print(error) }
	}
	
	// Segue で詳細ページに移動する際のデータの受け渡し
	override func prepare(for segue: UIStoryboardSegue, sender: Any?)
	{
		// Segue が showDetail の時の処理
		if segue.identifier == "showDetail"
		{
			// 移動先のビューコントローラの data プロパティに値を設定する
			(segue.destination as! eventDetailViewController).data = sender as! [String]
		}
	}
	
	override func didReceiveMemoryWarning()
	{
		super.didReceiveMemoryWarning()
	}
}
