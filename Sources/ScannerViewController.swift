//
//  ScannerViewController.swift
//  Demol
//
//  Created by 冯汉栩 on 2017/5/12.
//  Copyright © 2017年 hanxuFeng. All rights reserved.
//

import UIKit
import AVFoundation

public class ScannerViewController: UIViewController,AVCaptureMetadataOutputObjectsDelegate {
  
  public var reultString:((_ result:String?) -> Void)?
  
  //相机显示视图--苹果协议规定是串行队列
  let cameraView = ScannerBackgroundView(frame: UIScreen.main.bounds)
  //1.创建Session
  let captureSession = AVCaptureSession()
  
  public init() {
    super.init(nibName: nil, bundle: nil)
    
  }
  
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    fatalError("init(coder:) has not been implemented")
  }
  
  override public func viewDidLoad() {
    super.viewDidLoad()
    buildUI()
  }
  
  override public func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.tabBarController?.tabBar.isHidden = true
    self.scannerStart()
  }
  
  fileprivate func buildUI() {
    title = "扫一扫"
    view.backgroundColor = UIColor.black
    //添加相机显示视图
    view.addSubview(cameraView)
    buildSubView()
  }
  
  fileprivate func buildSubView(){
    //初始化摄像头--用来获取捕抓数据
    //初始化捕捉设备（AVCaptureDevice），类型AVMdeiaTypeVideo
    let captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
    //2.添加输入
    let input :AVCaptureDeviceInput
    //3.添加output-----创建媒体数据输出流
    let output = AVCaptureMetadataOutput()
    //6.捕捉异常
    do{
      //创建输入流
      input = try AVCaptureDeviceInput(device: captureDevice)
      
      //把输入流添加到会话
      captureSession.addInput(input)
      
      //把输出流添加到会话
      captureSession.addOutput(output)
    }catch {
      print("异常")
    }
    
    /*
     //创建串行队列
     let dispatchQueue = DispatchQueue(label: "queue", attributes: [])
     //设置输出流的代理
     output.setMetadataObjectsDelegate(self, queue: dispatchQueue)
     */
    
    //设置监听输出解析到的数据  ---   设置输出流的代理
    output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
    //设置输出媒体的数据类型
    //// 注意点: 设置数据类型一定要在输出对象添加到会话之后才能设置
    // AVMetadataObjectTypeQRCode 这个属性非常重要，明确规定我们现在需要的数据类型就是二维码。
    /*
     条形码类型
     EAN-13 (AVMetadataObjectTypeEAN13Code)
     EAN-8 (AVMetadataObjectTypeEAN8Code)
     Code 128 (AVMetadataObjectTypeCode128Code)
     UPC-E (AVMetadataObjectTypeUPCECode)
     Code 39 (AVMetadataObjectTypeCode39Code)
     Code 39 mod 43 (AVMetadataObjectTypeCode39Mod43Code)
     Code 93 (AVMetadataObjectTypeCode93Code)
     Aztec (AVMetadataObjectTypeAztecCode)
     PDF417 (AVMetadataObjectTypePDF417Code)
     */
    output.metadataObjectTypes = NSArray(array: [AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code,AVMetadataObjectTypeUPCECode,AVMetadataObjectTypeCode39Code,AVMetadataObjectTypeCode39Mod43Code,AVMetadataObjectTypeCode93Code,AVMetadataObjectTypeAztecCode,AVMetadataObjectTypePDF417Code]) as [AnyObject]
    //创建预览图层
    let videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
    //设置预览图层的填充方式
    videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
    //设置预览图层的frame -- 设置捕抓范围
    videoPreviewLayer?.frame = cameraView.bounds
    //将预览图层添加到预览视图上
    cameraView.layer.insertSublayer(videoPreviewLayer!, at: 0)
    //设置扫描范围
    output.rectOfInterest = CGRect(x: 0.2, y: 0.2, width: 0.6, height: 0.6)
  }
  
}

extension ScannerViewController {
  
  func scannerStart(){
    captureSession.startRunning()
    cameraView.scanning = "start"
  }
  
  func scannerStop() {
    captureSession.stopRunning()
    cameraView.scanning = "stop"
  }
  
  //扫描代理方法 -- 就是视频捕抓到二维码的时候就是进入这个代理方法
  public func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
    //判断获取回来的二维码数组不能为空和数组要大于0，然后解码里面的信息
    if metadataObjects != nil && metadataObjects.count > 0 {
      let metaData : AVMetadataMachineReadableCodeObject = metadataObjects.first as! AVMetadataMachineReadableCodeObject
      //解码出来的一个网络地址
      print(metaData.stringValue)
      
      reultString?(metaData.stringValue)
      
      //创建一个控制器，把网址填进去进行登录。
//      DispatchQueue.main.async(execute: {
//        let resultView = WebViewController()
//        resultView.url = metaData.stringValue
//        self.navigationController?.pushViewController(resultView, animated: true)
//      })
      
      //停止扫描运行
      captureSession.stopRunning()
    }
  }
  
}
