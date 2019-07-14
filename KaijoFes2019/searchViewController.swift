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
    
    // 変数
    var originList:[String] = []		// 全データ
    var displayList:[String] = []       // 表示するデータ
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
		
        // 表示用配列を初期化
        displayList = originList
        
        // テーブル再表示
        tableField.reloadData()
    }
	
    // テーブルの行数を指定する
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        // 表示用配列の要素数 + 1（件数表示行）を返す
        return displayList.count + 1
    }
    
    // Cell に値を設定する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
	{
        // セルのスタイルを指定する
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "myCell")
		
		if indexPath.row == displayList.count
        {
            // 最終行の場合は検索結果件数を表示
            cell.textLabel?.textColor = UIColor.lightGray
            cell.textLabel?.text = "\(displayList.count) 件の検索結果"
            
            // 選択不可にする
            cell.selectionStyle = .none
        }
        else
        {
			let details = displayList[indexPath.row].components(separatedBy: ",")
            cell.textLabel?.text = details[1]
            cell.detailTextLabel?.text = details[0]
        }
		
        // セルのアクセサリを設定
        cell.accessoryType = .none
		
        return cell
    }
    
    // 最終行を選択不可にする
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath?
    {
        // 最終行の件数セルは選択不可
        if indexPath.row >= displayList.count { return nil }
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
			displayList = originList
        }
        else
        {
            // 表示用・伝達用配列を初期化
            displayList = []
			
			for list in originList
			{
				if (searchBar.selectedScopeButtonIndex == 0 && list.range(of: searchBar.text!) != nil)
					|| (searchBar.selectedScopeButtonIndex == 1 && list.components(separatedBy: ",")[1].range(of: searchBar.text!) != nil)
					|| (searchBar.selectedScopeButtonIndex == 2 && list.components(separatedBy: ",")[0].range(of: searchBar.text!) != nil)
				{
					displayList.append(list)
				}
			}
        }
        
        // テーブル再表示
        tableField.reloadData()
    }
    
    // サーチバーのキャンセルボタンが押された時の処理
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar)
    {
		// キーボードをしまう
		searchBar.resignFirstResponder()
		
        // サーチバーの中身を空にする
        searchBar.text = ""
		
        // 全表示
        displayList = originList
        
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
	
	//　画面遷移時，サイドバーが出ていれば閉じる
	override func viewWillDisappear(_ animated: Bool)
	{
		if !SideBar.sideBarVC.view.isHidden
		{
			SideBar.closeSideBar()
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
