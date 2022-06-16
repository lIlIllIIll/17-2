//
//  ViewController.swift
//  Sketch
//
//  Created by 203a on 2022/06/03.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var imgView: UIImageView!
    
    var lastPoint: CGPoint! // 바로 전에 터치하거나 이동한 위치
    var lineSize: CGFloat = 2.0 // 선의 두께를 2로 지정
    var lineColor = UIColor.blue.cgColor    // 선 색상을 파란색으로 설정
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first! as UITouch   // 현재 발생한 터치 이벤트를 갖고 옴
        
        lastPoint = touch.location(in: imgView)
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIGraphicsBeginImageContext(imgView.frame.size) // 그림을 그리기 위한 콘텍스트 생성
        UIGraphicsGetCurrentContext()?.setStrokeColor(lineColor) // 선 색상을 설정
        UIGraphicsGetCurrentContext()?.setLineCap(CGLineCap.round) // 선 끝 모양을 라운드로 설정
        UIGraphicsGetCurrentContext()?.setLineWidth(lineSize)   // 선 두께를 설정
        
        let touch = touches.first! as UITouch   //현재 발생한 터치 이벤트를 갖고 옴
        let currPoint = touch.location(in: imgView) // 터치된 좌표를 currpoint로 갖고 옴
        
        imgView.image?.draw(in: CGRect(x: 0, y: 0, width: imgView.frame.size.width, height: imgView.frame.size.height)) // 현재 imgview에 있는 전체 이미지를 imgview크기로 바꿈
        
        UIGraphicsGetCurrentContext()?.move(to: CGPoint(x: lastPoint.x, y: lastPoint.y))
        // lastPoint위치에서 시작 위치로 이동
        UIGraphicsGetCurrentContext()?.addLine(to: CGPoint(x: currPoint.x, y: currPoint.y))
        // lastPoint에서 currPoint까지 선을 추가
        UIGraphicsGetCurrentContext()?.strokePath()
        // 추가한 선을 콘텍스트에 그림
        imgView.image = UIGraphicsGetImageFromCurrentImageContext()
        //현재 콘텍스트에 그려진 이미지를 갖고 와서 이미지 뷰에 할당
        UIGraphicsEndImageContext()
        // 그림 그리기를 끝냄
        
        lastPoint = currPoint // 현재 터치된 위치를 lastPoint라는 변수에 할당
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIGraphicsBeginImageContext(imgView.frame.size)
        UIGraphicsGetCurrentContext()?.setStrokeColor(lineColor)
        UIGraphicsGetCurrentContext()?.setLineCap(CGLineCap.round)
        UIGraphicsGetCurrentContext()?.setLineWidth(lineSize)
        
        imgView.image?.draw(in: CGRect(x: 0, y: 0, width: imgView.frame.size.width, height: imgView.frame.size.height))
        
        UIGraphicsGetCurrentContext()?.move(to: CGPoint(x: lastPoint.x, y: lastPoint.y))
        UIGraphicsGetCurrentContext()?.addLine(to: CGPoint(x: lastPoint.x, y: lastPoint.y))
        UIGraphicsGetCurrentContext()?.strokePath()
        
        imgView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            imgView.image = nil
        }
    }
    
    @IBAction func clearImageView(_ sender: UIButton) {
        imgView.image = nil // 이미지 뷰의 이미지를 삭제
    }
    
}

