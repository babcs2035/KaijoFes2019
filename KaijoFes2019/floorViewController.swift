//
//  floorViewController.swift
//  KaijoFes2019
//
//  Created by Bwambocos on 2019/02/01.
//  Copyright © 2019年 com.babcs2035.kaijofes2019. All rights reserved.
//

import UIKit

class floorViewController: UIViewController {

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
    
    
    @objc func sideMenu() {
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
    

    
    
    @IBAction func b1201(_ sender: Any) {
        self.performSegue(withIdentifier: "segue12", sender: dataList[0].components(separatedBy: ","))
    }
    @IBAction func b1202(_ sender: Any) {
        self.performSegue(withIdentifier: "segue12", sender: dataList[1].components(separatedBy: ","))
    }
    @IBAction func b1203(_ sender: Any) {
        self.performSegue(withIdentifier: "segue12", sender: dataList[2].components(separatedBy: ","))
    }
    @IBAction func b1204(_ sender: Any) {
        self.performSegue(withIdentifier: "segue12", sender: dataList[3].components(separatedBy: ","))
    }
    @IBAction func b1205(_ sender: Any) {
        self.performSegue(withIdentifier: "segue12", sender: dataList[4].components(separatedBy: ","))
    }
    
    
    @IBAction func b1301(_ sender: Any) {
        self.performSegue(withIdentifier: "segue13", sender: dataList[5].components(separatedBy: ","))
    }
    @IBAction func b1302(_ sender: Any) {
        self.performSegue(withIdentifier: "segue13", sender: dataList[6].components(separatedBy: ","))
    }
    @IBAction func b1303(_ sender: Any) {
        self.performSegue(withIdentifier: "segue13", sender: dataList[7].components(separatedBy: ","))
    }
    @IBAction func b1304(_ sender: Any) {
        self.performSegue(withIdentifier: "segue13", sender: dataList[8].components(separatedBy: ","))
    }
    @IBAction func b1305(_ sender: Any) {
        self.performSegue(withIdentifier: "segue13", sender: dataList[9].components(separatedBy: ","))
    }

    @IBAction func b2301(_ sender: Any) {
        self.performSegue(withIdentifier: "segue23", sender: dataList[10].components(separatedBy: ","))
    }
    @IBAction func b2302(_ sender: Any) {
        self.performSegue(withIdentifier: "segue23", sender: dataList[11].components(separatedBy: ","))
    }
    @IBAction func b2303(_ sender: Any) {
        self.performSegue(withIdentifier: "segue23", sender: dataList[12].components(separatedBy: ","))
    }
    @IBAction func b2304(_ sender: Any) {
        self.performSegue(withIdentifier: "segue23", sender: dataList[13].components(separatedBy: ","))
    }
    @IBAction func b2305(_ sender: Any) {
        self.performSegue(withIdentifier: "segue23", sender: dataList[14].components(separatedBy: ","))
    }
    @IBAction func b2306(_ sender: Any) {
        self.performSegue(withIdentifier: "segue23", sender: dataList[15].components(separatedBy: ","))
    }
    @IBAction func b2307(_ sender: Any) {
        self.performSegue(withIdentifier: "segue23", sender: dataList[16].components(separatedBy: ","))
    }
    @IBAction func b2308(_ sender: Any) {
        self.performSegue(withIdentifier: "segue23", sender: dataList[17].components(separatedBy: ","))
    }
    
    @IBAction func b2401(_ sender: Any) {
        self.performSegue(withIdentifier: "segue24", sender: dataList[18].components(separatedBy: ","))
    }
    @IBAction func b2402(_ sender: Any) {
        self.performSegue(withIdentifier: "segue24", sender: dataList[19].components(separatedBy: ","))
    }
    @IBAction func b2403(_ sender: Any) {
        self.performSegue(withIdentifier: "segue24", sender: dataList[20].components(separatedBy: ","))
    }
    @IBAction func b2404(_ sender: Any) {
        self.performSegue(withIdentifier: "segue24", sender: dataList[21].components(separatedBy: ","))
    }
    @IBAction func b2405(_ sender: Any) {
        self.performSegue(withIdentifier: "segue24", sender: dataList[22].components(separatedBy: ","))
    }
    
    @IBAction func b2601(_ sender: Any) {
        self.performSegue(withIdentifier: "segue26", sender: dataList[23].components(separatedBy: ","))
    }
    @IBAction func b2602(_ sender: Any) {
        self.performSegue(withIdentifier: "segue26", sender: dataList[24].components(separatedBy: ","))
    }
    @IBAction func b2603(_ sender: Any) {
        self.performSegue(withIdentifier: "segue26", sender: dataList[25].components(separatedBy: ","))
    }
    @IBAction func b2604(_ sender: Any) {
        self.performSegue(withIdentifier: "segue26", sender: dataList[26].components(separatedBy: ","))
    }
    @IBAction func b2605(_ sender: Any) {
        self.performSegue(withIdentifier: "segue26", sender: dataList[27].components(separatedBy: ","))
    }
    @IBAction func b2606(_ sender: Any) {
        self.performSegue(withIdentifier: "segue26", sender: dataList[28].components(separatedBy: ","))
    }
    @IBAction func b2607(_ sender: Any) {
        self.performSegue(withIdentifier: "segue26", sender: dataList[29].components(separatedBy: ","))
    }
    @IBAction func b2608(_ sender: Any) {
        self.performSegue(withIdentifier: "segue26", sender: dataList[30].components(separatedBy: ","))
    }
    
    @IBAction func b2701(_ sender: Any) {
        self.performSegue(withIdentifier: "segue27", sender: dataList[31].components(separatedBy: ","))
    }
    @IBAction func b2702(_ sender: Any) {
        self.performSegue(withIdentifier: "segue27", sender: dataList[32].components(separatedBy: ","))
    }
    @IBAction func b2703(_ sender: Any) {
        self.performSegue(withIdentifier: "segue27", sender: dataList[33].components(separatedBy: ","))
    }
    @IBAction func b2704(_ sender: Any) {
        self.performSegue(withIdentifier: "segue27", sender: dataList[34].components(separatedBy: ","))
    }
    @IBAction func b2705(_ sender: Any) {
        self.performSegue(withIdentifier: "segue27", sender: dataList[35].components(separatedBy: ","))
    }
    @IBAction func b2706(_ sender: Any) {
        self.performSegue(withIdentifier: "segue27", sender: dataList[36].components(separatedBy: ","))
    }
    @IBAction func b2707(_ sender: Any) {
        self.performSegue(withIdentifier: "segue27", sender: dataList[37].components(separatedBy: ","))
    }

    @IBAction func b28011(_ sender: Any) {
        self.performSegue(withIdentifier: "segue28", sender: dataList[38].components(separatedBy: ","))
    }
    @IBAction func b28012(_ sender: Any) {
        self.performSegue(withIdentifier: "segue28", sender: dataList[39].components(separatedBy: ","))
    }
    @IBAction func b2802(_ sender: Any) {
        self.performSegue(withIdentifier: "segue28", sender: dataList[40].components(separatedBy: ","))
    }
    @IBAction func b2803(_ sender: Any) {
        self.performSegue(withIdentifier: "segue28", sender: dataList[41].components(separatedBy: ","))
    }
    @IBAction func b2804(_ sender: Any) {
        self.performSegue(withIdentifier: "segue28", sender: dataList[42].components(separatedBy: ","))
    }
    
    @IBAction func b3101(_ sender: Any) {
        self.performSegue(withIdentifier: "segue31", sender: dataList[43].components(separatedBy: ","))
    }
    @IBAction func b3201(_ sender: Any) {
        self.performSegue(withIdentifier: "segue32", sender: dataList[44].components(separatedBy: ","))
    }
    @IBAction func b3301(_ sender: Any) {
        self.performSegue(withIdentifier: "segue33", sender: dataList[45].components(separatedBy: ","))
    }
    @IBAction func b3302(_ sender: Any) {
        self.performSegue(withIdentifier: "segue33", sender: dataList[46].components(separatedBy: ","))
    }
    
    @IBAction func b4101(_ sender: Any) {
        self.performSegue(withIdentifier: "segue41", sender: dataList[47].components(separatedBy: ","))
    }

    @IBAction func b4201(_ sender: Any) {
        self.performSegue(withIdentifier: "segue42", sender: dataList[48].components(separatedBy: ","))
    }
    @IBAction func b4202(_ sender: Any) {
        self.performSegue(withIdentifier: "segue42", sender: dataList[49].components(separatedBy: ","))
    }
    @IBAction func b4203(_ sender: Any) {
        self.performSegue(withIdentifier: "segue42", sender: dataList[50].components(separatedBy: ","))
    }
    @IBAction func b4204(_ sender: Any) {
        self.performSegue(withIdentifier: "segue42", sender: dataList[51].components(separatedBy: ","))
    }
    
    @IBAction func b4301(_ sender: Any) {
        self.performSegue(withIdentifier: "segue43", sender: dataList[52].components(separatedBy: ","))
    }
    @IBAction func b4302(_ sender: Any) {
        self.performSegue(withIdentifier: "segue43", sender: dataList[53].components(separatedBy: ","))
    }
    @IBAction func b4303(_ sender: Any) {
        self.performSegue(withIdentifier: "segue43", sender: dataList[54].components(separatedBy: ","))
    }
    @IBAction func b4304(_ sender: Any) {
        self.performSegue(withIdentifier: "segue43", sender: dataList[55].components(separatedBy: ","))
    }
    
    @IBAction func b5101(_ sender: Any) {
        self.performSegue(withIdentifier: "segue51", sender: dataList[56].components(separatedBy: ","))
    }

    @IBAction func b5201(_ sender: Any) {
        self.performSegue(withIdentifier: "segue52", sender: dataList[57].components(separatedBy: ","))
    }
    
    @IBAction func b5301(_ sender: Any) {
        self.performSegue(withIdentifier: "segue53", sender: dataList[58].components(separatedBy: ","))
    }
    @IBAction func b53012(_ sender: Any) {
        self.performSegue(withIdentifier: "segue53", sender: dataList[58].components(separatedBy: ","))
    }
    
    @IBAction func b5401(_ sender: Any) {
        self.performSegue(withIdentifier: "segue54", sender: dataList[59].components(separatedBy: ","))
    }
    

    @IBAction func bNo1(_ sender: Any) {
        self.performSegue(withIdentifier: "segueKeion", sender: dataList[85].components(separatedBy: ","))
    }
    @IBAction func bHow1(_ sender: Any) {
        self.performSegue(withIdentifier: "segueKeion", sender: dataList[86].components(separatedBy: ","))
    }
    @IBAction func bUki1(_ sender: Any) {
        self.performSegue(withIdentifier: "segueKeion", sender: dataList[87].components(separatedBy: ","))
    }
    @IBAction func bSub1(_ sender: Any) {
        self.performSegue(withIdentifier: "segueKeion", sender: dataList[88].components(separatedBy: ","))
    }
    @IBAction func bInfe1(_ sender: Any) {
        self.performSegue(withIdentifier: "segueKeion", sender: dataList[89].components(separatedBy: ","))
    }
    @IBAction func bUma1(_ sender: Any) {
        self.performSegue(withIdentifier: "segueKeion", sender: dataList[90].components(separatedBy: ","))
    }
    @IBAction func bEnh1(_ sender: Any) {
        self.performSegue(withIdentifier: "segueKeion", sender: dataList[91].components(separatedBy: ","))
    }
    @IBAction func bSea1(_ sender: Any) {
        self.performSegue(withIdentifier: "segueKeion", sender: dataList[92].components(separatedBy: ","))
    }
    @IBAction func bElt1(_ sender: Any) {
        self.performSegue(withIdentifier: "segueKeion", sender: dataList[93].components(separatedBy: ","))
    }
    @IBAction func bRe1(_ sender: Any) {
        self.performSegue(withIdentifier: "segueKeion", sender: dataList[94].components(separatedBy: ","))
    }
    @IBAction func bToki1(_ sender: Any) {
        self.performSegue(withIdentifier: "segueKeion", sender: dataList[95].components(separatedBy: ","))
    }
    @IBAction func bMusa1(_ sender: Any) {
        self.performSegue(withIdentifier: "segueKeion", sender: dataList[96].components(separatedBy: ","))
    }
    @IBAction func bPray1(_ sender: Any) {
        self.performSegue(withIdentifier: "segueKeion", sender: dataList[97].components(separatedBy: ","))
    }
    @IBAction func bUki2(_ sender: Any) {
        self.performSegue(withIdentifier: "segueKeion", sender: dataList[87].components(separatedBy: ","))
    }
    @IBAction func bMusa2(_ sender: Any) {
        self.performSegue(withIdentifier: "segueKeion", sender: dataList[96].components(separatedBy: ","))
    }
    @IBAction func bToki2(_ sender: Any) {
        self.performSegue(withIdentifier: "segueKeion", sender: dataList[95].components(separatedBy: ","))
    }
    @IBAction func bSea2(_ sender: Any) {
        self.performSegue(withIdentifier: "segueKeion", sender: dataList[92].components(separatedBy: ","))
    }
    @IBAction func bRe2(_ sender: Any) {
        self.performSegue(withIdentifier: "segueKeion", sender: dataList[94].components(separatedBy: ","))
    }
    @IBAction func bElt2(_ sender: Any) {
        self.performSegue(withIdentifier: "segueKeion", sender: dataList[93].components(separatedBy: ","))
    }
    @IBAction func bSub2(_ sender: Any) {
        self.performSegue(withIdentifier: "segueKeion", sender: dataList[88].components(separatedBy: ","))
    }
    @IBAction func bMusa3(_ sender: Any) {
        self.performSegue(withIdentifier: "segueKeion", sender: dataList[96].components(separatedBy: ","))
    }
    @IBAction func bUma2(_ sender: Any) {
        self.performSegue(withIdentifier: "segueKeion", sender: dataList[90].components(separatedBy: ","))
    }
    @IBAction func bLore1(_ sender: Any) {
        self.performSegue(withIdentifier: "segueKeion", sender: dataList[98].components(separatedBy: ","))
    }
    @IBAction func bPray2(_ sender: Any) {
        self.performSegue(withIdentifier: "segueKeion", sender: dataList[97].components(separatedBy: ","))
    }
    @IBAction func bEnh2(_ sender: Any) {
        self.performSegue(withIdentifier: "segueKeion", sender: dataList[91].components(separatedBy: ","))
    }
    @IBAction func bHow2(_ sender: Any) {
        self.performSegue(withIdentifier: "segueKeion", sender: dataList[86].components(separatedBy: ","))
    }
    @IBAction func bLore2(_ sender: Any) {
        self.performSegue(withIdentifier: "segueKeion", sender: dataList[98].components(separatedBy: ","))
    }
    @IBAction func bInfe2(_ sender: Any) {
        self.performSegue(withIdentifier: "segueKeion", sender: dataList[89].components(separatedBy: ","))
    }
    @IBAction func bNo2(_ sender: Any) {
        self.performSegue(withIdentifier: "segueKeion", sender: dataList[85].components(separatedBy: ","))
    }
    @IBAction func bHow3(_ sender: Any) {
        self.performSegue(withIdentifier: "segueKeion", sender: dataList[86].components(separatedBy: ","))
    }
    @IBAction func bSea3(_ sender: Any) {
        self.performSegue(withIdentifier: "segueKeion", sender: dataList[92].components(separatedBy: ","))
    }
    @IBAction func bElt3(_ sender: Any) {
        self.performSegue(withIdentifier: "segueKeion", sender: dataList[93].components(separatedBy: ","))
    }

    @IBAction func bKeb(_ sender: Any) {
        self.performSegue(withIdentifier: "segueFood", sender: dataList[101].components(separatedBy: ","))
    }
    @IBAction func bKent(_ sender: Any) {
        self.performSegue(withIdentifier: "segueFood", sender: dataList[38].components(separatedBy: ","))
    }
    @IBAction func bBaku(_ sender: Any) {
        self.performSegue(withIdentifier: "segueFood", sender: dataList[102].components(separatedBy: ","))
    }
    @IBAction func bTai(_ sender: Any) {
        self.performSegue(withIdentifier: "segueFood", sender: dataList[103].components(separatedBy: ","))
    }
    @IBAction func bLot(_ sender: Any) {
        self.performSegue(withIdentifier: "segueFood", sender: dataList[39].components(separatedBy: ","))
    }
    @IBAction func bCot(_ sender: Any) {
        self.performSegue(withIdentifier: "segueFood", sender: dataList[104].components(separatedBy: ","))
    }
    @IBAction func bTwin(_ sender: Any) {
        self.performSegue(withIdentifier: "segueFood", sender: dataList[105].components(separatedBy: ","))
    }
    @IBAction func bDrink(_ sender: Any) {
        self.performSegue(withIdentifier: "segueFood", sender: dataList[106].components(separatedBy: ","))
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
    

    
    // セグエで詳細ページに移動する際のデータの受け渡し
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        // 移動先のビューコントローラの data プロパティに値を設定する
        (segue.destination as! eventDetailViewController).data = sender as! [String]
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
