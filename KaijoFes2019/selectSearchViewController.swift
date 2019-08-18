//
//  selectSearchViewController.swift
//  KaijoFes2019
//
//  Created by Bwambocos on 2019/08/18.
//  Copyright © 2019 com.babcs2035.kaijofes2019. All rights reserved.
//

import UIKit

class selectSearchViewController: UIViewController
{
	var SideBar = sideBarCommon()
	
	override func viewDidLoad()
	{
        super.viewDidLoad()
		
		// サイドバーの設定
		SideBar.sideBarVC = storyboard?.instantiateViewController(withIdentifier: "sideBar")
		self.addChild(SideBar.sideBarVC)
		self.view.addSubview(SideBar.sideBarVC.view)
		SideBar.initSideBar(view: selectSearchViewController())
    }
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?)
	{
		if segue.identifier == "selectMap" { return }
		let nextScene = segue.destination as! searchViewController
		var param:String = ""
		if segue.identifier == "selectWatch" { param = "watch" }
		if segue.identifier == "selectHear" { param = "hear" }
		if segue.identifier == "selectExpr" { param = "expr" }
		if segue.identifier == "selectLearn" { param = "learn" }
		nextScene.param = param
	}
	
	//　サイドバー管理
	override func viewWillDisappear(_ animated: Bool)
	{
		if !SideBar.sideBarVC.view.isHidden
		{
			SideBar.closeSideBar()
		}
	}
	@IBAction func sideBarButton(_ sender: Any)
	{
		SideBar.performSideBar()
	}
}
