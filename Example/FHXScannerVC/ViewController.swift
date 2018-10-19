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
  
  let views = ScannerView(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()
      view.backgroundColor = UIColor.white
      
      view.addSubview(views)
      
      views.frame = view.bounds
      
      views.delegate = self
      
    }

}

extension ViewController:ScannerViewDelegate {
  
  func scannerView(view: ScannerView, returnScanner resultString: String) {
    print("retult = \(resultString)")
  }
}


