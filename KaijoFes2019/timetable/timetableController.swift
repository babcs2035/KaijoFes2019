//
//  timetableController.swift
//  KaijoFes2019
//
//  Created by Bwambocos on 2019/04/09.
//  Copyright © 2019 com.babcs2035.kaijofes2019. All rights reserved.
//

import UIKit

class timetableController: UITabBarController, UITabBarControllerDelegate
{
	override func viewDidLoad()
	{
		super.viewDidLoad()
		self.delegate = self
	}
	
	override func didReceiveMemoryWarning()
	{
		super.didReceiveMemoryWarning()
	}
	
	private func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController)
	{
		if viewController is timetableDelegate
		{
			let v = viewController as! timetableDelegate
			v.didSelectTab(timetableDelegate: self)
		}
	}
}
