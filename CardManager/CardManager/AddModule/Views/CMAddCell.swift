//
//  CMAddCell.swift
//  CardManager
//
//  Created by 李二狗 on 2018/1/12.
//  Copyright © 2018年 李二狗. All rights reserved.
//

import UIKit
import Material
class CMAddCell: UITableViewCell {
    
    @IBOutlet weak var textField: ErrorTextField!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
        
        textField.placeholder = "Email"
        textField.detail = "Error, incorrect email"
        textField.isClearIconButtonEnabled = true
        textField.delegate = self
        textField.isPlaceholderUppercasedWhenEditing = true
        textField.placeholderAnimation = .hidden
        
        
        // Set the colors for the emailField, different from the defaults.
        //        emailField.placeholderNormalColor = Color.amber.darken4
        //        emailField.placeholderActiveColor = Color.pink.base
        //        emailField.dividerNormalColor = Color.cyan.base
        //        emailField.dividerActiveColor = Color.green.base
        
        // Set the text inset
        //        emailField.textInset = 20
        
        let leftView = UIImageView()
        leftView.image = Icon.cm.image
        textField.leftView = leftView
        
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
   public func cm_becomeFirstResponder() -> Bool {
       return textField.becomeFirstResponder()
    }

}


extension CMAddCell: TextFieldDelegate {
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

