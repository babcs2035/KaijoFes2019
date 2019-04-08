//
//  sideBarViewController.swift
//  KaijoFes2019
//
//  Created by Bwambocos on 2019/02/01.
//  Copyright © 2019年 com.babcs2035.kaijofes2019. All rights reserved.
//

import UIKit

class sideBarCommon
{
	// スクリーンサイズ
	var screenWidth: CGFloat = 0
	
	// storyboard 上のサイドバー (UIViewController) を格納
	var sideBarVC: UIViewController!
	
	// サイドバーを初期化
	func initSideBar(view: UIViewController)
	{
		// スクリーンの幅を取得
		screenWidth = getScreenSize().0
		
		// メインビューにサイドバーを追加
		addSideBar(view: view)
		
		// サイドバーを非表示
		closeSideBar()
	}
	
	// スクリーンのサイズを取得
	func getScreenSize() -> (CGFloat, CGFloat)
	{
		return (UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height)
	}
	
	// サイドバーをメインビューに追加
	func addSideBar(view: UIViewController)
	{
		// 画面外に追加したサイドバーを移動
		sideBarVC.didMove(toParent: view)
		sideBarVC.view.transform = CGAffineTransform(translationX: (screenWidth * -1), y: 0)
	}
	
	// サイドバーをメインビューに出す
	func displaySideBar()
	{
		// サイドバーを表示
		sideBarVC.view.isHidden = false
		
		// サイドバーをアニメーション付きで移動
		UIView.animate(withDuration: 0.2, animations: { () -> Void in
			self.sideBarVC.view.transform = CGAffineTransform(translationX: (self.screenWidth * -1/2), y: 0)
		})
	}
	
	// サイドバーを格納
	func closeSideBar()
	{
		// サイドバーをアニメーション付きで移動
		UIView.animate(withDuration: 0.2, animations: { () -> Void in
			self.sideBarVC.view.transform = CGAffineTransform(translationX: (self.screenWidth * -1), y: 0)
		})
		
		// サイドバーを非表示
		sideBarVC.view.isHidden = true
	}
	
	func performSideBar()
	{
		if sideBarVC.view.isHidden
		{
			displaySideBar()
		}
		else
		{
			closeSideBar()
		}
	}
}

class sideBarViewController: UIViewController
{
	var SideBar = sideBarCommon()
	
    override func viewDidLoad()
	{
        super.viewDidLoad()
		SideBar.sideBarVC = storyboard?.instantiateViewController(withIdentifier: "sideBar")
		self.addChild(SideBar.sideBarVC)
		self.view.addSubview(SideBar.sideBarVC.view)
		SideBar.initSideBar(view: sideBarViewController())
        
        // グラデーション処理
        let gradientLayer:CAGradientLayer = CAGradientLayer()
        let startColor = UIColor(red: 255 / 255.0, green: 247 / 255.0, blue: 99 / 255.0, alpha: 0.8).cgColor
        let endColor = UIColor(red: 255 / 255.0, green: 186 / 255.0, blue: 36 / 255.0, alpha: 0.8).cgColor
        gradientLayer.colors = [startColor, endColor]
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    // 画面遷移時，サイドバーが出ていれば閉じる
    override func viewWillDisappear(_ animated: Bool)
	{
        if SideBar.sideBarVC.view.isHidden
		{
            SideBar.closeSideBar()
        }
    }
	
    @IBAction func barButtonFinish(_ sender: Any)
	{
        self.navigationController?.popToRootViewController(animated: true)
    }
	
    @IBAction func buttonSearch(_ sender: Any)
	{
		SideBar.performSideBar()
    }
    
	@IBAction func buttonTable(_ sender: Any)
	{
		SideBar.performSideBar()
    }
    
    @IBAction func buttonSearchMap(_ sender: Any)
	{
		SideBar.performSideBar()
    }
    
    @IBAction func buttonOther(_ sender: Any)
	{
		SideBar.performSideBar()
    }
    
    @IBAction func buttonCredit(_ sender: Any)
	{
		SideBar.performSideBar()
    }
}
