//
//  ViewController.swift
//  FHXScannerVC
//
//  Created by fenghanxu on 10/18/2018.
//  Copyright (c) 2018 fenghanxu. All rights reserved.
//

import UIKit
import FHXScannerVC
import AVFoundation

class ViewController: UIViewController {
  


    override func viewDidLoad() {
        super.viewDidLoad()
      view.backgroundColor = UIColor.white
      
      let vc = ScannerViewController()
      
      vc.reultString = {  (_ name:String?) -> Void in
        print("resultString = \(String(describing: name))")
      }
      
      navigationController?.pushViewController(vc, animated: true)
      
    }

}




