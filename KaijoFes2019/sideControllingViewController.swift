//
//  sideControllingViewController.swift
//  KaijoFes2019
//
//  Created by Bwambocos on 2019/02/01.
//  Copyright © 2019年 com.babcs2035.kaijofes2019. All rights reserved.
//

import UIKit

class sideControllingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func goHome(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    @IBAction func goSearch(_ sender: Any) {
        performSegue(withIdentifier: "goHome", sender: nil)
        let history = self.navigationController?.viewControllers
        let newHistory = history?.last
        if let okHistory = newHistory {
            print(okHistory)
            self.navigationController?.setViewControllers([okHistory], animated: false)
        }
        self.performSegue(withIdentifier: "goSearch", sender: nil)
    }
    @IBAction func goMap(_ sender: Any) {
        performSegue(withIdentifier: "goHome", sender: nil)
        let history = self.navigationController?.viewControllers
        let newHistory = history?.last
        if let okHistory = newHistory {
            print(okHistory)
            self.navigationController?.setViewControllers([okHistory], animated: false)
        }
        self.performSegue(withIdentifier: "goMap", sender: nil)
    }
    @IBAction func goShop(_ sender: Any) {
        performSegue(withIdentifier: "goHome", sender: nil)
        let history = self.navigationController?.viewControllers
        let newHistory = history?.last
        if let okHistory = newHistory {
            print(okHistory)
            self.navigationController?.setViewControllers([okHistory], animated: false)
        }
        self.performSegue(withIdentifier: "goShop", sender: nil)
    }
    @IBAction func goBook(_ sender: Any) {
        performSegue(withIdentifier: "goHome", sender: nil)
        let history = self.navigationController?.viewControllers
        let newHistory = history?.last
        if let okHistory = newHistory {
            print(okHistory)
            self.navigationController?.setViewControllers([okHistory], animated: false)
        }
        self.performSegue(withIdentifier: "goBook", sender: nil)
    }
    @IBAction func goTime(_ sender: Any) {
        performSegue(withIdentifier: "goHome", sender: nil)
        let history = self.navigationController?.viewControllers
        let newHistory = history?.last
        if let okHistory = newHistory {
            print(okHistory)
            self.navigationController?.setViewControllers([okHistory], animated: false)
        }
        self.performSegue(withIdentifier: "goTime", sender: nil)
    }

    @IBAction func goOther(_ sender: Any) {
        performSegue(withIdentifier: "goHome", sender: nil)
        let history = self.navigationController?.viewControllers
        let newHistory = history?.last
        if let okHistory = newHistory {
            print(okHistory)
            self.navigationController?.setViewControllers([okHistory], animated: false)
        }
        self.performSegue(withIdentifier: "goOther", sender: nil)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
