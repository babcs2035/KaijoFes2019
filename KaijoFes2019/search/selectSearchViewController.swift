//
//  selectSearchViewController.swift
//  KaijoFes2019
//
//  Created by Bwambocos on 2019/08/18.
//  Copyright © 2019 jp.ed.kaijo.KaijoFes2019. All rights reserved.
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
		if segue.identifier == nil { return }
		var param:String = ""
		if segue.identifier == "selectWatch" { param = "watch" }
		if segue.identifier == "selectHear" { param = "hear" }
		if segue.identifier == "selectExpr" { param = "expr" }
		if segue.identifier == "selectLearn" { param = "learn" }
		if segue.identifier == "selectNo1" { param = "1" }
		if segue.identifier == "selectNo2" { param = "2" }
		if segue.identifier == "selectNo3" { param = "3" }
		if segue.identifier == "selectNo4" { param = "4" }
		if segue.identifier == "selectNo5" { param = "5" }
		if param.count == 1
		{
			let nextScene = segue.destination as! floorDetailViewController
			nextScene.param = param
		}
		else
		{
			let nextScene = segue.destination as! searchViewController
			nextScene.param = param
		}
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
