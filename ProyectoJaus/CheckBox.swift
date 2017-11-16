//
//  CheckBox.swift
//  ProyectoJaus
//
//  Created by Estudiante on 10/6/16.
//  Copyright © 2016 Tecnologico de Costa Rica. All rights reserved.
//
import UIKit
import Foundation

class RadioButton: UIButton{
    var alternateButton:Array<RadioButton>?
    
    override func awakeFromNib() {
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 2.0
        self.layer.masksToBounds = true
    }
    
    func unselectAlternateButtons(){
        if alternateButton != nil {
            self.isSelected = true
            
            for aButton:RadioButton in alternateButton! {
                aButton.isSelected = false
            }
        }else{
            toggleButton()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        unselectAlternateButtons()
        super.touchesBegan(touches, with: event)
    }

    func toggleButton(){
        self.isSelected = !isSelected
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.layer.borderColor = UIColor.cyan.cgColor
            } else {
                self.layer.borderColor = UIColor.darkGray.cgColor
            }
        }
    }
}
