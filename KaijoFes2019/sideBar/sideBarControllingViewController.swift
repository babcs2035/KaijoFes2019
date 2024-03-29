//
//  sideControllingViewController.swift
//  KaijoFes2019
//
//  Created by Bwambocos on 2019/02/01.
//  Copyright © 2019年 jp.ed.kaijo.KaijoFes2019. All rights reserved.
//

import UIKit

class sideBarControllingViewController: UIViewController
{
    override func viewDidLoad()
	{
        super.viewDidLoad()
    }

    @IBAction func goHome(_ sender: Any)
	{
		performSegue(withIdentifier: "goHome", sender: nil)
    }
	
    @IBAction func goSearch(_ sender: Any)
	{
        self.performSegue(withIdentifier: "goSearch", sender: nil)
    }
	
	@IBAction func goBook(_ sender: Any)
	{
		self.performSegue(withIdentifier: "goBook", sender: nil)
	}
	
    @IBAction func goShop(_ sender: Any)
	{
        self.performSegue(withIdentifier: "goShop", sender: nil)
    }
	
    @IBAction func goTime(_ sender: Any)
	{
        self.performSegue(withIdentifier: "goTimetable", sender: nil)
    }

    @IBAction func goOther(_ sender: Any)
	{
        self.performSegue(withIdentifier: "goOther", sender: nil)
    }
    
    override func didReceiveMemoryWarning()
	{
        super.didReceiveMemoryWarning()
    }
}
