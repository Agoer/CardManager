//
//  CMAddController.swift
//  CardManager
//  添加主页面
//  Created by 李二狗 on 2018/1/11.
//  Copyright © 2018年 李二狗. All rights reserved.
//

import UIKit
import Material
class CMAddController: UIViewController {
    
    fileprivate var tableView: UITableView!
    fileprivate var emailField: ErrorTextField!
    fileprivate var passwordField: TextField!
    /// A constant to layout the textFields.
    fileprivate let itemArray = ["银行","卡号","备注","账单日","还款日"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cm_initUI()
        // Do any additional setup after loading the view.
    }
    
    func cm_initUI() {
        //tableview
        prepareTableView()
    }

    @IBAction func closeBarButtonPressed(_ sender: Any) {
        self .dismiss(animated: true) {
            
        }
    }
    
    @IBAction func addBarButtonPressed(_ sender: Any) {
        
        //todo 添加提醒信息到数据库
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension CMAddController {
    
    fileprivate func prepareTableView() {
        tableView = UITableView.init(frame: CGRect.zero, style: .plain)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView .register(UINib.init(nibName: "CMAddCell", bundle: nil), forCellReuseIdentifier: "CMAddCell")
        view.layout(tableView).left().right().top().bottom()
        
    }
    
    
    fileprivate func prepareEmailField() {
        emailField = ErrorTextField()
        emailField.placeholder = "Email"
        emailField.detail = "Error, incorrect email"
        emailField.isClearIconButtonEnabled = true
        emailField.delegate = self
        emailField.isPlaceholderUppercasedWhenEditing = true
        emailField.placeholderAnimation = .hidden
        
        // Set the colors for the emailField, different from the defaults.
        //        emailField.placeholderNormalColor = Color.amber.darken4
        //        emailField.placeholderActiveColor = Color.pink.base
        //        emailField.dividerNormalColor = Color.cyan.base
        //        emailField.dividerActiveColor = Color.green.base
        
        // Set the text inset
        //        emailField.textInset = 20
        
        let leftView = UIImageView()
        leftView.image = Icon.cm.audio
        emailField.leftView = leftView
        
        view.layout(emailField).center(offsetY: -passwordField.bounds.height - 60).left(20).right(20)
    }
    
    fileprivate func preparePasswordField() {
        passwordField = TextField()
        passwordField.placeholder = "Password"
        passwordField.detail = "At least 8 characters"
        passwordField.clearButtonMode = .whileEditing
        passwordField.isVisibilityIconButtonEnabled = true
        
        // Setting the visibilityIconButton color.
        passwordField.visibilityIconButton?.tintColor = Color.green.base.withAlphaComponent(passwordField.isSecureTextEntry ? 0.38 : 0.54)
        
        view.layout(passwordField).center().left(20).right(20)
    }
    
    /// Prepares the resign responder button.
    fileprivate func prepareResignResponderButton() {
        let btn = RaisedButton(title: "Resign", titleColor: Color.blue.base)
        btn.addTarget(self, action: #selector(handleResignResponderButton(button:)), for: .touchUpInside)
        
    }
    @objc
    internal func handleResignResponderButton(button: UIButton) {
        emailField?.resignFirstResponder()
        passwordField?.resignFirstResponder()
    }
}

extension CMAddController: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return itemArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
        //        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CMAddCell", for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell:CMAddCell = tableView.cellForRow(at: indexPath) as! CMAddCell
        cell.cm_becomeFirstResponder()
    }
}


extension CMAddController: TextFieldDelegate {
    public func textFieldDidEndEditing(_ textField: UITextField) {
        (textField as? ErrorTextField)?.isErrorRevealed = false
    }
    
    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        (textField as? ErrorTextField)?.isErrorRevealed = false
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        (textField as? ErrorTextField)?.isErrorRevealed = true
        return true
    }
}


