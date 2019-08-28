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
    private var scrollView: UIScrollView!
    private var pageControl: UIPageControl!
    var param:String = ""
	
	// 変数
	var originList:[String] = []		// 全データ
	var displayList:[String] = []       // 表示するデータ
	var SideBar = sideBarCommon()
	var navigationTitles:[String] = []
	var floorIndexs:[Int] = []
	var scrollBeginingPoint: CGPoint!
	
	override func viewDidLoad()
	{
        super.viewDidLoad()
		
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
		
        // scrollView の設定
		let scrollY = self.navigationController!.navigationBar.frame.size.height + 5
		let scrollH:CGFloat = 290
		
		scrollView = UIScrollView(frame: CGRect(x: 0, y: scrollY, width: self.view.frame.size.width, height: scrollH))
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
		
		// pageControl の設定
		pageControl = UIPageControl(frame: CGRect(x: 0, y: scrollY + scrollH + 5, width: self.view.frame.size.width, height: 15))
		pageControl.pageIndicatorTintColor = UIColor.lightGray
		pageControl.currentPageIndicatorTintColor = UIColor.black
		
		// タイトルとフロア画像をセット
		navigationTitles.removeAll()
		floorIndexs.removeAll()
		if param == "1"
		{
			self.navigationItem.title = "１号館２階"
			scrollView.contentSize = CGSize(width: self.view.frame.size.width * 2, height: scrollH)
			pageControl.numberOfPages = 2
			scrollView.addSubview(createImageView(x: 0, y: scrollY, width: self.view.frame.size.width, height: scrollH - scrollY, image: "floor.12"))
			scrollView.addSubview(createImageView(x: self.view.frame.size.width, y: scrollY, width: self.view.frame.size.width, height: scrollH - scrollY, image: "floor.13"))
			navigationTitles.append("１号館２階")
			navigationTitles.append("１号館３階")
			floorIndexs.append(2)
			floorIndexs.append(3)
		}
		if param == "2"
		{
			self.navigationItem.title = "２号館３階"
			scrollView.contentSize = CGSize(width: self.view.frame.size.width * 5, height: scrollH)
			pageControl.numberOfPages = 5
			scrollView.addSubview(createImageView(x: 0, y: scrollY, width: self.view.frame.size.width, height: scrollH, image: "floor.23"))
			scrollView.addSubview(createImageView(x: self.view.frame.size.width, y: scrollY, width: self.view.frame.size.width, height: scrollH, image: "floor.24"))
			scrollView.addSubview(createImageView(x: self.view.frame.size.width * 2, y: scrollY, width: self.view.frame.size.width, height: scrollH, image: "floor.26"))
			scrollView.addSubview(createImageView(x: self.view.frame.size.width * 3, y: scrollY, width: self.view.frame.size.width, height: scrollH, image: "floor.27"))
			scrollView.addSubview(createImageView(x: self.view.frame.size.width * 4, y: scrollY, width: self.view.frame.size.width, height: scrollH, image: "floor.28"))
			navigationTitles.append("２号館３階")
			navigationTitles.append("２号館４階")
			navigationTitles.append("２号館６階")
			navigationTitles.append("２号館７階")
			navigationTitles.append("２号館８階")
			floorIndexs.append(3)
			floorIndexs.append(4)
			floorIndexs.append(6)
			floorIndexs.append(7)
			floorIndexs.append(8)
		}
		if param == "4"
		{
			self.navigationItem.title = "４号館１階"
			scrollView.contentSize = CGSize(width: self.view.frame.size.width * 3, height: scrollH)
			pageControl.numberOfPages = 3
			scrollView.addSubview(createImageView(x: 0, y: scrollY, width: self.view.frame.size.width, height: scrollH, image: "floor.41"))
			scrollView.addSubview(createImageView(x: self.view.frame.size.width, y: scrollY, width: self.view.frame.size.width, height: scrollH, image: "floor.42"))
			scrollView.addSubview(createImageView(x: self.view.frame.size.width * 2, y: scrollY, width: self.view.frame.size.width, height: scrollH, image: "floor.43"))
			navigationTitles.append("４号館１階")
			navigationTitles.append("４号館２階")
			navigationTitles.append("４号館３階")
			floorIndexs.append(1)
			floorIndexs.append(2)
			floorIndexs.append(3)
		}
		if param == "5"
		{
			self.navigationItem.title = "５号館１階"
			scrollView.contentSize = CGSize(width: self.view.frame.size.width * 4, height: scrollH)
			pageControl.numberOfPages = 4
			scrollView.addSubview(createImageView(x: 0, y: scrollY, width: self.view.frame.size.width, height: scrollH, image: "floor.51"))
			scrollView.addSubview(createImageView(x: self.view.frame.size.width, y: scrollY, width: self.view.frame.size.width, height: scrollH, image: "floor.52"))
			scrollView.addSubview(createImageView(x: self.view.frame.size.width * 2, y: scrollY, width: self.view.frame.size.width, height: scrollH, image: "floor.53"))
			scrollView.addSubview(createImageView(x: self.view.frame.size.width * 3, y: scrollY, width: self.view.frame.size.width, height: scrollH, image: "floor.54"))
			navigationTitles.append("５号館１階")
			navigationTitles.append("５号館２階")
			navigationTitles.append("５号館３階")
			navigationTitles.append("５号館４階")
			floorIndexs.append(1)
			floorIndexs.append(2)
			floorIndexs.append(3)
			floorIndexs.append(4)
		}
		self.view.addSubview(scrollView)
		self.view.addSubview(pageControl)
		
		displayList.removeAll()
		for list in originList
		{
			let details = list.components(separatedBy: ",")
			if (details[6].prefix(2) == param + String(floorIndexs[Int(scrollView.contentOffset.x / scrollView.frame.size.width)]))
			{
				displayList.append(list)
			}
		}
		eventTable.reloadData()
		
		// サイドバーの設定
		SideBar.sideBarVC = storyboard?.instantiateViewController(withIdentifier: "sideBar")
		self.addChild(SideBar.sideBarVC)
		self.view.addSubview(SideBar.sideBarVC.view)
		SideBar.initSideBar(view: floorDetailViewController())
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
	
	// UIImageView を生成
	func createImageView(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, image: String) -> UIImageView
	{
		let imageView = UIImageView(frame: CGRect(x: x, y: y, width: width, height: height))
		let image = UIImage(named:  image)
		imageView.image = image
		imageView.contentMode = UIView.ContentMode.scaleAspectFit
		return imageView
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
	
	@IBAction func buttonDetail(_ sender: Any)
	{
		SideBar.performSideBar()
	}
}

// scrollView のページ移動に合わせて pageControl の表示も移動
extension floorDetailViewController: UIScrollViewDelegate
{
	
	func scrollViewWillBeginDragging(_ scrollView: UIScrollView)
	{
		scrollBeginingPoint = scrollView.contentOffset;
	}
	func scrollViewDidEndDecelerating(_ scrollView: UIScrollView)
	{
		let currentPoint = scrollView.contentOffset;
		if scrollBeginingPoint.x != currentPoint.x
		{
			pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
			self.navigationItem.title = navigationTitles[pageControl.currentPage]
			displayList.removeAll()
			for list in originList
			{
				let details = list.components(separatedBy: ",")
				if (details[6].prefix(2) == param + String(floorIndexs[pageControl.currentPage]))
				{
					displayList.append(list)
				}
			}
			eventTable.reloadData()
		}
	}
}
