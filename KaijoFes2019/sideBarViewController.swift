//
//  sideBarViewController.swift
//  KaijoFes2019
//
//  Created by Bwambocos on 2019/02/01.
//  Copyright © 2019年 com.babcs2035.kaijofes2019. All rights reserved.
//

import UIKit

class sideBarViewController: UIViewController
{
    // サイドメニューが表示中かの真偽
    var isDisplayedSideBar: Bool = false
    
    // スクリーンサイズ
    var screenWidth: CGFloat = 0
    
    // storyboard 上のサイドメニュー (UIViewController) を格納
    var sideBarVC: UIViewController!
	
    override func viewDidLoad()
	{
        super.viewDidLoad()
        
        // スクリーンの幅を取得して、変数に格納
        screenWidth = getScreenSize().0
        
        // メインビューにサイドメニューを追加
        addSideBar()
        
        // サイドメニューを非表示
        sideBarVC.view.isHidden = true
        
        // グラデーション処理
        let gradientLayer:CAGradientLayer = CAGradientLayer()
        let startColor = UIColor(red: 255 / 255.0, green: 247 / 255.0, blue: 99 / 255.0, alpha: 0.8).cgColor
        let endColor = UIColor(red: 255 / 255.0, green: 186 / 255.0, blue: 36 / 255.0, alpha: 0.8).cgColor
        // view の右上から左下へ
        gradientLayer.colors = [startColor, endColor]
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    // 画面遷移時，サイドメニューが出ていれば閉じる
    override func viewWillDisappear(_ animated: Bool)
	{
        if isDisplayedSideBar
		{
            closeSideBar()
        }
    }
	
    @IBAction func barButtonFinish(_ sender: Any)
	{
        self.navigationController?.popToRootViewController(animated: true)
    }
	
	func performSideBar()
	{
		if !isDisplayedSideBar
		{
			displaySideBar()
		}
		else
		{
			closeSideBar()
		}
	}
	
    @IBAction func buttonSearch(_ sender: Any)
	{
		performSideBar()
    }
    
	@IBAction func buttonTable(_ sender: Any)
	{
		performSideBar()
    }
    
    @IBAction func buttonSearchMap(_ sender: Any)
	{
		performSideBar()
    }
    
    @IBAction func buttonOther(_ sender: Any)
	{
		performSideBar()
    }
    
    @IBAction func buttonCredit(_ sender: Any)
	{
		performSideBar()
    }
	
    // スクリーンのサイズを取得
    func getScreenSize() -> (CGFloat, CGFloat)
	{
        // スクリーンサイズを取得
        let screenSize = UIScreen.main.bounds.size
        
        // スクリーンの幅と高さを変数に格納
        let width: CGFloat = screenSize.width
        let height: CGFloat = screenSize.height
        
        return (width, height)
    }
    
    // サイドメニューをメインビューに追加
    func addSideBar()
	{
        // サイドメニューをメインビューに追加
        sideBarVC = (storyboard?.instantiateViewController(withIdentifier: "sideBar"))! as UIViewController
        self.addChild(sideBarVC)
        self.view.addSubview(sideBarVC.view)
        sideBarVC.didMove(toParent: self)
        
        // 画面外に追加したサイドメニューを移動
        sideBarVC.view.transform = CGAffineTransform(translationX: (screenWidth * -1), y: 0)
    }
    
    // サイドメニューをメインビューに出す
    func displaySideBar()
	{
        // サイドメニューを表示
        sideBarVC.view.isHidden = false
		
        // サイドメニューをアニメーション付きで移動
        UIView.animate(withDuration: 0.2, animations: { () -> Void in
            self.sideBarVC.view.transform = CGAffineTransform(translationX: (self.screenWidth * -1/2), y: 0)
        })
        
        // サイドメニューが表示されていることにする
        isDisplayedSideBar = true
    }
    
    // サイドメニューを格納
    func closeSideBar()
	{
        // サイドメニューをアニメーション付きで移動
        UIView.animate(withDuration: 0.2, animations: { () -> Void in
            self.sideBarVC.view.transform = CGAffineTransform(translationX: (self.screenWidth * -1), y: 0)
        })
        
        // サイドメニューが表示されていることにする
        isDisplayedSideBar = false
        
        // サイドメニューを非表示
        sideBarVC.view.isHidden = true
    }
}
