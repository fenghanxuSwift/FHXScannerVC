//
//  ScannerViewController.swift
//  Demol
//
//  Created by 冯汉栩 on 2018/17/10.
//  Copyright © 2018年 hanxuFeng. All rights reserved.
//

import UIKit


struct EmptyPageAsserts{

  static let loading = (0...14).map { (index) -> UIImage in
    return Asserts.findImages(named: "loading logo-\(index)")!
  }
  
}


class Asserts {
  
  static func findImages(named: String) -> UIImage? {
    guard let path = Bundle(for: Asserts.self).path(forResource: "Asserts", ofType: "bundle") else { return nil }
    guard let bundle = Bundle(path: path) else { return nil }
    guard let image = UIImage(named: named, in: bundle, compatibleWith: nil) else { return nil }
    return image
  }
}
