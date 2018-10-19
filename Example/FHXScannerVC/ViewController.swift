//
//  ViewController.swift
//  FHXScannerVC
//
//  Created by fenghanxu on 10/18/2018.
//  Copyright (c) 2018 fenghanxu. All rights reserved.
//

import UIKit
import FHXScannerVC

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      view.backgroundColor = UIColor.white
      
      let scanBtn = UIButton()
      view.addSubview(scanBtn)
      scanBtn.setTitle("扫一扫", for: .normal)
      scanBtn.setTitleColor(UIColor.blue, for: .normal)
      scanBtn.layer.cornerRadius = 10
      scanBtn.layer.masksToBounds = true
      scanBtn.layer.borderWidth = 0.6
      scanBtn.layer.borderColor = UIColor.red.cgColor
      scanBtn.addTarget(self, action: #selector(scanBtnClick), for: .touchUpInside)
      scanBtn.frame = CGRect(x: 150, y: 300, width: 50, height: 50)
    }

  @objc func scanBtnClick(){
    let vc = ScannerViewController()
    navigationController?.pushViewController(vc, animated: true)
//    navigationController?.pushViewController(WebViewController(), animated: true)
  }

}

