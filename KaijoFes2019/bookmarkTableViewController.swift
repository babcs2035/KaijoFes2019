//
//  bookmarkTableViewController.swift
//  KaijoFes2019
//
//  Created by Bwambocos on 2019/02/01.
//  Copyright © 2019年 com.babcs2035.kaijofes2019. All rights reserved.
//

import UIKit

class bookmarkTableViewController: UITableViewController
{

    @IBOutlet var testTableView: UITableView!
    
	
    var bookmarkList:[String] = []		// ブックマーク配列
    var userPath:String!				// CSVファイルの保存先
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
                let temp = csvData.components(separatedBy: "\n")
				bookmarkList = temp
                // 原因不明のバグを直すための調整
                bookmarkList.removeLast()
            }
			// ユーザーが保存した CSV ファイルがある場合
			else
			{
                // ユーザーが保存した CSV ファイルのデータを取得
                let csvData = try String(contentsOfFile: path!, encoding: String.Encoding.utf8)
                bookmarkList = csvData.components(separatedBy: "\n")
            }
            
            // CSV ファイルの出力先を確認
            print(userPath)
            
            // 編集ボタン作成
            navigationItem.rightBarButtonItem = editButtonItem
            
		} catch { print(error) }
    }

    override func didReceiveMemoryWarning()
	{
        super.didReceiveMemoryWarning()
    }
	
	// 行数を取得
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
        return bookmarkList.count + 1
    }

    // セル情報を取得
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
	{
        let cell = tableView.dequeueReusableCell(withIdentifier: "TestCell", for: indexPath)
		
		if (bookmarkList.count > 0)
		{
			// 普通の行
			if (indexPath.row < bookmarkList.count)
			{
				// カンマでデータを分割して配列に格納
				let bookmarkDetail = bookmarkList[indexPath.row].components(separatedBy: ",")
				
				// セルのラベルに企画名，団体名を設定
				cell.textLabel?.text = bookmarkDetail[2]
				cell.detailTextLabel?.text = bookmarkDetail[1]
				cell.backgroundColor = UIColor.white
			}
			// 最終行
			else
			{
				// リセットボタン
				cell.textLabel?.text = "ブックマークをリセットする"
				cell.detailTextLabel?.text = ""
				cell.textLabel?.textColor = UIColor.red
				cell.backgroundColor = UIColor.white
			}
		}
		else
		{
			cell.textLabel?.text = "何もブックマーク登録されていません"
			cell.detailTextLabel?.text = ""
			cell.backgroundColor = UIColor.white
		}
		
        return cell
    }
    
    // 編集可能か取得
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
	{
        return indexPath.row < bookmarkList.count
    }
    
    // 編集モードを設定
    override func setEditing(_ editing: Bool, animated: Bool)
	{
        super.setEditing(editing, animated: animated)
        tableView.isEditing = editing
    }
	
	// CSV ファイルに保存
	func saveToCSV()
	{
		
		// 改行区切りで団体配列を連結
		let outputStr = bookmarkList.joined(separator: "\n")
		
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
	
    // テーブルビューを編集
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
	{
        if (editingStyle == .delete)
		{
            bookmarkList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        // テーブルの再読込
        tableView.reloadData()
        
        // CSV ファイルにデータを保存
        saveToCSV()
    }
	
    
    // Cell 選択時の処理
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
		tableView.deselectRow(at: indexPath, animated: true)
		if (bookmarkList.count > 0)
		{
			if (indexPath.row == bookmarkList.count)
			{
				showAlert()
			}
			else
			{
				// 指定した ID の Segue を初期化
				self.performSegue(withIdentifier: "showDetail", sender: bookmarkList[(indexPath as NSIndexPath).row].components(separatedBy: ","))
			}
		}
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
    
    func showAlert()
	{
        
        // アラートを作成
        let alert = UIAlertController(
            title: "注意",
            message: "本当にブックマークを削除しますか？（この処理は取り消せません）",
            preferredStyle: .alert)
        
        // アラートにボタンを設定
        alert.addAction(UIAlertAction(title: "削除", style: .default, handler: { action in self.bookmarkRemove()}))
        alert.addAction(UIAlertAction(title: "キャンセル", style: .cancel))
        
        // アラートを表示
        self.present(alert, animated: true, completion: nil)
    }
    
    func bookmarkRemove()
	{
        if (bookmarkList.count != 0)
		{
            bookmarkList.removeAll()
			
            // テーブルの再読み込み
            tableView.reloadData()
            
            // CSV ファイルにデータを保存
            saveToCSV()
        }
    }
}
