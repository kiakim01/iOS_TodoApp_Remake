//
//  ViewController.swift
//  iOS_Todo_App_OneMore
//
//  Created by kiakim on 2023/09/02.
//

import UIKit

class ViewController: UIViewController {

    //MARK: Property
    
    //segmentedControl_step3: 클로저를 사용한 함수로, 버튼 선택시 보여줄 스크린을 설정해줍니다.
    var shouldHideTodoView: Bool?{
        didSet{
            guard let shouldHideTodoView = self.shouldHideTodoView else{return}
            self.toDoView.isHidden = shouldHideTodoView
            self.doneView.isHidden = !self.doneView.isHidden
        }
    }
    
    let segmentedControl : UISegmentedControl = {
        let controler = UISegmentedControl(items: ["Todo","Done"])
        let font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.bold)
        let attributes = [NSAttributedString.Key.font:font]
        controler.setTitleTextAttributes(attributes, for: UIControl.State.normal)
        controler.translatesAutoresizingMaskIntoConstraints = false
        return controler
    }()
    
    let toDoView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.gray.cgColor
        view.backgroundColor = UIColor.gray
        view.layer.borderWidth = 0.5
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let doneView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.blue.cgColor
        view.backgroundColor = UIColor.blue
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setLayout()
    }


}

//MARK: Method
extension ViewController{
    @objc private func screenChange(segment: UISegmentedControl){
//        segmentedControl_step4:
//        self.shouldHideTodoView = segment.selectedSegmentIndex != 0
        //shouldHideTodoView가 true이면,SegmentIndex == 1을 보여줍니다
        self.shouldHideTodoView = segment.selectedSegmentIndex == 1
    }
}



//MARK: UI
extension ViewController{
    func configureUI(){
        self.view.addSubview(segmentedControl)
        self.view.addSubview(self.toDoView)
        self.view.addSubview(self.doneView)
        //segmentedControl_step1: controller의 items를 선택했을 때 동작할 액션 setting
        self.segmentedControl.addTarget(self, action: #selector(screenChange(segment: )), for: .valueChanged)
        // segmentedControl_step2: contorller의 초기 화면을 설정함 (with: self.shouldHideTodoView)
        self.segmentedControl.selectedSegmentIndex = 0
        self.screenChange(segment: self.segmentedControl)
        
    }
    
    func setLayout(){
        NSLayoutConstraint.activate([
            self.segmentedControl.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20),
            self.segmentedControl.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20),
            self.segmentedControl.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100),
            self.segmentedControl.heightAnchor.constraint(equalToConstant: 40),
        ])
        
        NSLayoutConstraint.activate([
            self.toDoView.leftAnchor.constraint(equalTo: self.segmentedControl.leftAnchor),
            self.toDoView.rightAnchor.constraint(equalTo: self.segmentedControl.rightAnchor),
            self.toDoView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -80),
            self.toDoView.topAnchor.constraint(equalTo: self.segmentedControl.bottomAnchor, constant: 16),
        ])

        
        NSLayoutConstraint.activate([
            self.doneView.leftAnchor.constraint(equalTo: self.toDoView.leftAnchor),
            self.doneView.rightAnchor.constraint(equalTo: self.toDoView.rightAnchor),
            self.doneView.bottomAnchor.constraint(equalTo: self.toDoView.bottomAnchor),
            self.doneView.topAnchor.constraint(equalTo: self.toDoView.topAnchor),
        ])
        
    }
}
