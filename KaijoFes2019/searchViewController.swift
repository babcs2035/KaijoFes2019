//
//  SeResultViewController.swift
//  KaijoFes2019
//
//  Created by Bwambocos on 2019/02/01.
//  Copyright © 2019年 com.babcs2035.kaijofes2019. All rights reserved.
//

import UIKit

class searchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate
{
    // アウトレット接続
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableField: UITableView!
    
    // 変数宣言
    var originEvent = [""]             // 全データ（企画名）
    var originOrgan = [""]             // 全データ（団体名）
    var originDetail = [""]             // 全データ（説明文）
    var displayEvent = [""]            // 表示するデータ（企画名）
    var displayOrgan = [""]            // 表示するデータ（団体名）
    var displayDetail = [""]            // 表示するデータ（説明文）
    var dataList:[String] = []
    var displayList:[String] = []      // 画面遷移時のデータリスト
	
	var SideBar = sideBarCommon()
	
    // 初期化処理
    override func viewDidLoad()
    {
        super.viewDidLoad()
		
		// サイドバーの設定
		SideBar.sideBarVC = storyboard?.instantiateViewController(withIdentifier: "sideBar")
		self.addChild(SideBar.sideBarVC)
		self.view.addSubview(SideBar.sideBarVC.view)
		SideBar.initSideBar(view: searchViewController())
		
		let gradientLayer:CAGradientLayer = CAGradientLayer()
		let startColor = UIColor(red: 255/255.0, green: 247/255.0, blue: 99/255.0, alpha: 0.8).cgColor
		let endColor = UIColor(red: 255/255.0, green: 186/255.0, blue: 36/255.0, alpha: 0.8).cgColor
		gradientLayer.colors = [startColor, endColor]
		gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.0)
		gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
		gradientLayer.frame = view.bounds
		view.layer.insertSublayer(gradientLayer, at: 0)
	
        // デリゲート先の設定
        searchBar.delegate = self
        tableField.delegate = self
        tableField.dataSource = self
        
        // 何も入力されていなくても検索キーを押せるようにする
        searchBar.enablesReturnKeyAutomatically = false
        
        // CSV ファイル読み込み
        do {
            // CSV ファイルのパス名を取得
            let csvPath = Bundle.main.path(forResource: "eventData", ofType: "csv")
            
            // CSV ファイルのデータを取得
            let csvData = try String(contentsOfFile: csvPath!, encoding: String.Encoding.utf8)
            
            // 改行区切りでデータを分割し，配列に格納
            dataList = csvData.components(separatedBy: "*")
            dataList.removeLast()
        }
		catch
		{
            print(error)
        }
        
        // カンマ区切りでデータを分裂し，配列に格納
        var index = 0;
        while index < dataList.count
        {
			// 改行コードを削除
			dataList[index] = dataList[index].replacingOccurrences(of: "\r\n", with: "")
			
			// "" を削除
			dataList[index] = dataList[index].replacingOccurrences(of: "\"", with: "")
			
            var dataDetail = dataList[index].components(separatedBy: ",")
            originEvent.insert(dataDetail[1], at: index);
            originOrgan.insert(dataDetail[0], at: index);
            originDetail.insert(dataDetail[4], at:index);
            index += 1
        }
        
        originEvent.removeLast()
        originOrgan.removeLast()
        originDetail.removeLast()
        
        // 表示用配列の初期化（最初は origin をコピーして全て表示する）
        displayEvent = originEvent
        displayOrgan = originOrgan
        displayDetail = originDetail
        
        // 画面遷移準備（初期設定）
        displayList = dataList
        
        // テーブル再表示
        tableField.reloadData()
    }
    
    //　画面遷移時，サイドバーが出ていれば閉じる
    override func viewWillDisappear(_ animated: Bool)
	{
		if !SideBar.sideBarVC.view.isHidden
		{
			SideBar.closeSideBar()
		}
    }
	
    // テーブルの行数を指定する
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        // 表示用配列の要素数 + 1（件数表示行）を返す
        return displayEvent.count + 1
    }
    
    // Cell に値を設定する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
	{
        // セルのスタイルを指定する
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "myCell")
        
        // 最終行かそうでないかで分岐
        if indexPath.row == displayEvent.count
        {
            // 最終行の場合は検索結果件数を表示
            cell.textLabel?.textColor = UIColor.lightGray
            cell.textLabel?.text = "\(displayEvent.count)件の検索結果"
            
            // 選択不可にする
            cell.selectionStyle = .none
        }
        else
        {
            // 企画名
            cell.textLabel?.text = displayEvent[indexPath.row]
            // 団体名
            cell.detailTextLabel?.text = displayOrgan[indexPath.row]
        }
		
        // セルのアクセサリを設定
        cell.accessoryType = .none
		
        return cell
    }
    
    // 最終行を選択不可にする
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath?
    {
        // 最終行の件数セルは選択不可
        if indexPath.row >= displayEvent.count { return nil }
        else { return indexPath }
    }
    
    // サーチバーで検索ボタンが押された時の処理
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        // キーボードをしまう
        searchBar.resignFirstResponder()
        
        if searchBar.text == ""
        {
            // 空文字列の場合は全表示
            displayEvent = originEvent
            displayOrgan = originOrgan
            displayDetail = originDetail
        }
        else
        {
            // 表示用・伝達用配列を初期化
            displayEvent = []
            displayOrgan = []
            displayDetail = []
            displayList = []
            
            // 処理中のインデックス
            var index = 0
            
            // 検索モードにより分岐
            if searchBar.selectedScopeButtonIndex == 0
            {
                // 「全て」が選択されている場合
                for event in originEvent
                {
                    // 検索対象文字を含んでいれば表示用配列（企画名＆団体名＆説明文）に追加
                    if (event.range(of: searchBar.text!) != nil)||(originOrgan[index].range(of: searchBar.text!) != nil)||(originDetail[index].range(of: searchBar.text!) != nil)
                    {
                        displayEvent.append(event)
                        displayOrgan.append(originOrgan[index])
                        displayDetail.append(originDetail[index])
                        displayList.append(dataList[index])
                        
                    }
                    index += 1
                }
                
            }
			else if searchBar.selectedScopeButtonIndex == 1
            {
                // 「企画名から」が選択されている場合
                for event in originEvent
                {
                    // 検索対象文字を含んでいれば表示用配列（企画名）に追加
                    if event.range(of: searchBar.text!) != nil
                    {
                        displayEvent.append(event)
                        displayOrgan.append(originOrgan[index])
                        displayDetail.append(originDetail[index])
                        displayList.append(dataList[index])
                        
                    }
                    index += 1
                }
                
            }
            else
            {
                // 「団体名から」が選択されている場合
                for organ in originOrgan
                {
                    // 検索対象文字を含んでいれば表示用配列（団体名）に追加
                    if organ.range(of: searchBar.text!) != nil
                    {
                        displayOrgan.append(organ)
                        displayEvent.append(originEvent[index])
                        displayDetail.append(originDetail[index])
                        displayList.append(dataList[index])
                    }
                    index += 1
                }
            }
        }
        
        // テーブル再表示
        tableField.reloadData()
    }
    
    // サーチバーのキャンセルボタンが押された時の処理
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar)
    {
        // サーチバーの中身を空にする
        searchBar.text = ""
        
        // キーボードをしまう
        searchBar.resignFirstResponder()
        
        // 表示用配列を元の配列と同じにする
        displayEvent = originEvent
        displayOrgan = originOrgan
        displayDetail = originDetail
        displayList = dataList
        
        // テーブル再表示
        tableField.reloadData()
    }
    
    // Cell が選択された時の処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        // セルの選択解除
        tableView.deselectRow(at: indexPath, animated: true)
        
        // 指定した ID の Segue を初期化
        self.performSegue(withIdentifier: "showDetail", sender: displayList[(indexPath as NSIndexPath).row].components(separatedBy: ","))
    }
    
    // セグエで詳細ページに移動する際のデータの受け渡し
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        // セグエが showDetail の時の処理
        if segue.identifier == "showDetail"
        {
            // 移動先のビューコントローラの data プロパティに値を設定する
            (segue.destination as! eventDetailViewController).data = sender as! [String]
        }
    }
	
    @IBAction func buttonSearchWord(_ sender: Any)
	{
		SideBar.performSideBar()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}