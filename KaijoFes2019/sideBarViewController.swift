//
//  sideBarViewController.swift
//  KaijoFes2019
//
//  Created by Bwambocos on 2019/02/01.
//  Copyright © 2019年 com.babcs2035.kaijofes2019. All rights reserved.
//

import UIKit

class sideBarViewController: UIViewController {

    //  サイドメニューが表示中かの真偽
    var isDisplayedSideMenu: Bool = false
    
    //  スクリーンサイズを格納するための変数
    var screenWidth: CGFloat = 0
    
    //  storyboard上のサイドメニュー(UIViewController)を格納するためのもの
    var sideMenuVC: UIViewController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //  スクリーンの幅を取得して、変数に格納
        screenWidth = getScreenSize().0
        
        //  メインビューにサイドメニューを追加
        addSideMenu()
        
        //　サイドメニューを非表示
        sideMenuVC.view.isHidden = true
        
        //以下、グラデーション
            let gradientLayer:CAGradientLayer = CAGradientLayer()
            let startColor = UIColor(red: 255/255.0, green: 247/255.0, blue: 99/255.0, alpha: 0.8).cgColor
            let endColor = UIColor(red: 255/255.0, green: 186/255.0, blue: 36/255.0, alpha: 0.8).cgColor
            // viewの右上から左下へ
            gradientLayer.colors = [startColor, endColor]
            gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
            gradientLayer.frame = view.bounds
            view.layer.insertSublayer(gradientLayer, at: 0)
        //以上、グラデーション
    }
    
    //　画面遷移時、サイドメニューが出ていれば閉じる
    override func viewWillDisappear(_ animated: Bool) {
        if isDisplayedSideMenu == true {
            closeSideMenu()
        }
    }
    
 
    @IBAction func barButtonFinish(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    

    
    @IBAction func buttonSearch(_ sender: Any) {
        //  サイドメニューが表示されていない時
        if isDisplayedSideMenu == false {
            //  サイドメニューを出す
            displaySideMenu()
        }
            //  サイドメニューが表示されている時
        else {
            //  サイドメニューを閉じる
            closeSideMenu()
        }
    }
    
    @IBAction func buttonTable(_ sender: Any) {
        if isDisplayedSideMenu == false {
            displaySideMenu()
        }
        else {
            closeSideMenu()
        }
    }
    
    @IBAction func buttonSearchMap(_ sender: Any) {
        if isDisplayedSideMenu == false {
            displaySideMenu()
        }
        else {
            closeSideMenu()
        }
    }
    
    @IBAction func buttonOther(_ sender: Any) {
        if isDisplayedSideMenu == false {
            displaySideMenu()
        }
        else {
            closeSideMenu()
        }
    }
    
    @IBAction func buttonCredit(_ sender: Any) {
        if isDisplayedSideMenu == false {
            displaySideMenu()
        }
        else {
            closeSideMenu()
        }
    }
    
    
    /*
     *  メソッド
     */
    // スクリーンのサイズを取得するためのメソッド
    func getScreenSize() -> (CGFloat, CGFloat) {
        
        //  スクリーンサイズを取得
        let screenSize = UIScreen.main.bounds.size
        
        //  スクリーンの幅と高さを変数に格納
        let width: CGFloat = screenSize.width
        let height: CGFloat = screenSize.height
        
        return (width, height)
    }
    
    //  サイドメニューをメインビューに追加するためのメソッド
    func addSideMenu() {
        
        //  サイドメニューをメインビューに追加
        sideMenuVC = (storyboard?.instantiateViewController(withIdentifier: "sideBar"))! as UIViewController
        self.addChild(sideMenuVC)
        self.view.addSubview(sideMenuVC.view)
        sideMenuVC.didMove(toParent: self)
        
        //  画面外に追加したサイドメニューを移動
        sideMenuVC.view.transform = CGAffineTransform(translationX: (screenWidth * -1), y: 0)
    }
    
    //  サイドメニューをメインビューに出すためのメソッド
    func displaySideMenu() {
        
        //　サイドメニューを表示
        sideMenuVC.view.isHidden = false
        //  サイドメニューをアニメーション付きで移動させる
        UIView.animate(withDuration: 0.2, animations: { () -> Void in
            self.sideMenuVC.view.transform = CGAffineTransform(translationX: (self.screenWidth * -1/2), y: 0)
        })
        
        //  サイドメニューが表示されていることにする
        isDisplayedSideMenu = true
    }
    
    //  サイドメニューを格納するためのメソッド
    func closeSideMenu() {
        
        //  サイドメニューをアニメーション付きで移動させる
        UIView.animate(withDuration: 0.2, animations: { () -> Void in
            self.sideMenuVC.view.transform = CGAffineTransform(translationX: (self.screenWidth * -1), y: 0)
        })
        
        //  サイドメニューが表示されていることにする
        isDisplayedSideMenu = false
        
        //　サイドメニューを非表示
        sideMenuVC.view.isHidden = true
    }
    
    
    
}
