//
//  tableViewController.swift
//  KaijoFes2019
//
//  Created by Bwambocos on 2019/02/01.
//  Copyright © 2019年 com.babcs2035.kaijofes2019. All rights reserved.
//

import UIKit

class tableViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollView2: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    
    var dataList:[String] = []
    
    //　以下、サイドバーの設定
    //  サイドメニューが表示中かの真偽
    var isDisplayedSideMenu: Bool = false
    
    //  スクリーンサイズを格納するための変数
    var screenWidth: CGFloat = 0
    
    //  storyboard上のサイドメニュー(UIViewController)を格納するためのもの
    var sideMenuVC: UIViewController!
    //　以上、サイドバーの設定
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //　以下、サイドバーの設定
        //  スクリーンの幅を取得して、変数に格納
        screenWidth = getScreenSize().0
        
        //  メインビューにサイドメニューを追加
        addSideMenu()
        
        //　サイドメニューを非表示
        sideMenuVC.view.isHidden = true
        
        let menuButton:UIBarButtonItem = UIBarButtonItem(image: UIImage(named:"naviMenu"), style: .plain, target: self, action: #selector(floorViewController.sideMenu))
        self.tabBarController?.navigationItem.rightBarButtonItem = menuButton
        //　以上、サイドバーの設定

        
        // CSV ファイル読み込み
        do {
            // CSV ファイルのパス名を取得
            let csvPath = Bundle.main.path(forResource: "eventData", ofType: "csv")
            
            // CSV ファイルのデータを取得
            let csvData = try String(contentsOfFile: csvPath!, encoding: String.Encoding.utf8)
            
            // 改行区切りでデータを分割し、配列に格納
            dataList = csvData.components(separatedBy: "\n")
            dataList.removeLast()
        } catch {
            print(error)
        }
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        scrollView.delegate = self
//        scrollView.maximumZoomScale = 8.0
//        scrollView.minimumZoomScale = 1.0
//        scrollView2.delegate = self
//        scrollView2.maximumZoomScale = 8.0
//        scrollView2.minimumZoomScale = 1.0
//    }
    
    //　画面遷移時、サイドメニューが出ていれば閉じる
    override func viewWillDisappear(_ animated: Bool) {
        if isDisplayedSideMenu == true {
            closeSideMenu()
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func sideMenu() {
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
    
    //　以下、サイドバーの設定
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
    //以上、サイドバーの設定
    

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    

    // セグエで詳細ページに移動する際のデータの受け渡し
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        // 移動先のビューコントローラの data プロパティに値を設定する
        (segue.destination as! eventDetailViewController).data = sender as! [String]
    }
    
    @IBAction func bKaijo(_ sender: Any) {
        self.performSegue(withIdentifier: "segueSat", sender: dataList[60].components(separatedBy: ","))
    }
    @IBAction func bTeacher(_ sender: Any) {
        self.performSegue(withIdentifier: "segueSat", sender: dataList[61].components(separatedBy: ","))
    }
    @IBAction func bIntro(_ sender: Any) {
        self.performSegue(withIdentifier: "segueSat", sender: dataList[62].components(separatedBy: ","))
    }
    @IBAction func mMrms(_ sender: Any) {
        self.performSegue(withIdentifier: "segueSat", sender: dataList[63].components(separatedBy: ","))
    }
    @IBAction func bVsfes(_ sender: Any) {
        self.performSegue(withIdentifier: "segueSat", sender: dataList[64].components(separatedBy: ","))
    }
    @IBAction func bKWE(_ sender: Any) {
        self.performSegue(withIdentifier: "segueSat", sender: dataList[65].components(separatedBy: ","))
    }
    @IBAction func bVsboys(_ sender: Any) {
        self.performSegue(withIdentifier: "segueSun", sender: dataList[66].components(separatedBy: ","))
    }
    @IBAction func bIntro2(_ sender: Any) {
        self.performSegue(withIdentifier: "segueSun", sender: dataList[62].components(separatedBy: ","))
    }
    @IBAction func bTalk(_ sender: Any) {
        self.performSegue(withIdentifier: "segueSun", sender: dataList[67].components(separatedBy: ","))
    }
    @IBAction func bMrms(_ sender: Any) {
        self.performSegue(withIdentifier: "segueSun", sender: dataList[63].components(separatedBy: ","))
    }
    @IBAction func bBingo(_ sender: Any) {
        self.performSegue(withIdentifier: "segueSun", sender: dataList[68].components(separatedBy: ","))
    }
    @IBAction func bKWE2(_ sender: Any) {
        self.performSegue(withIdentifier: "segueSun", sender: dataList[65].components(separatedBy: ","))
    }
    @IBAction func bGP(_ sender: Any) {
        self.performSegue(withIdentifier: "segueSun", sender: dataList[69].components(separatedBy: ","))
    }
    
    @IBAction func bBase(_ sender: Any) {
        self.performSegue(withIdentifier: "segueSat", sender: dataList[70].components(separatedBy: ","))
    }
    @IBAction func bLac(_ sender: Any) {
        self.performSegue(withIdentifier: "segueSat", sender: dataList[71].components(separatedBy: ","))
    }
    @IBAction func bSoccer(_ sender: Any) {
        self.performSegue(withIdentifier: "segueSun", sender: dataList[72].components(separatedBy: ","))
    }
    @IBAction func bRocket(_ sender: Any) {
        self.performSegue(withIdentifier: "segueSun", sender: dataList[73].components(separatedBy: ","))
    }
    @IBAction func bTennis(_ sender: Any) {
        self.performSegue(withIdentifier: "segueSat", sender: dataList[74].components(separatedBy: ","))
    }
    @IBAction func bHand(_ sender: Any) {
        self.performSegue(withIdentifier: "segueSun", sender: dataList[75].components(separatedBy: ","))
    }
    @IBAction func bAct(_ sender: Any) {
        self.performSegue(withIdentifier: "segueSat", sender: dataList[76].components(separatedBy: ","))
    }
    @IBAction func bVio(_ sender: Any) {
        self.performSegue(withIdentifier: "segueSat", sender: dataList[77].components(separatedBy: ","))
    }
    @IBAction func bAcca(_ sender: Any) {
        self.performSegue(withIdentifier: "segueSat", sender: dataList[78].components(separatedBy: ","))
    }
    @IBAction func bCourt(_ sender: Any) {
        self.performSegue(withIdentifier: "segueSat", sender: dataList[79].components(separatedBy: ","))
    }
    @IBAction func bYose(_ sender: Any) {
        self.performSegue(withIdentifier: "segueSun", sender: dataList[80].components(separatedBy: ","))
    }
    @IBAction func bVio2(_ sender: Any) {
        self.performSegue(withIdentifier: "segueSun", sender: dataList[77].components(separatedBy: ","))
    }
    @IBAction func bAcca2(_ sender: Any) {
        self.performSegue(withIdentifier: "segueSun", sender: dataList[78].components(separatedBy: ","))
    }
    @IBAction func bAct2(_ sender: Any) {
        self.performSegue(withIdentifier: "segueSun", sender: dataList[76].components(separatedBy: ","))
    }
    @IBAction func bYushu(_ sender: Any) {
        self.performSegue(withIdentifier: "segueSun", sender: dataList[81].components(separatedBy: ","))
    }
    @IBAction func bBad(_ sender: Any) {
        self.performSegue(withIdentifier: "segueSat", sender: dataList[82].components(separatedBy: ","))
    }
    @IBAction func bVolley(_ sender: Any) {
        self.performSegue(withIdentifier: "segueSun", sender: dataList[83].components(separatedBy: ","))
    }
    @IBAction func bBasket(_ sender: Any) {
        self.performSegue(withIdentifier: "segueSun", sender: dataList[84].components(separatedBy: ","))
    }
    
    
    // MARK: - Navigation


}
