//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Sahadev Tandur on 21/08/17.
//  Copyright © 2017 Sahadev Tandur. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController {

    @IBOutlet weak var OutLb: UILabel!
    
    var BtnSound : AVAudioPlayer?
    
    var CurrentNumber: String = ""
    var LeftOperand: String = ""
    var RightOperend: String = ""
    var Result: String = ""
    var Flag: Bool = false
    enum op : String {
        case Div = "/"
        case Mul = "*"
        case Sub = "-"
        case Add = "+"
        case Empty = "empty"
    }
    var CurrentOperation : op = op.Empty
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let sound = URL(fileURLWithPath: path!)
        do {
            try BtnSound = AVAudioPlayer(contentsOf: sound)
            BtnSound?.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func OnNumberBtnClick(sender : UIButton)
    {
        playsound()
        CurrentNumber += "\(sender.tag)"
        Display(Str: CurrentNumber)
        
    }
    
    
    @IBAction func OnSubBtnClick(_ sender: Any) {
        playsound()
        if CurrentNumber != "" {
        LeftOperand = CurrentNumber
        CurrentNumber += "-"
        Display(Str: CurrentNumber)
        CurrentNumber = ""
        CurrentOperation = op.Sub
        }
        
        if CurrentOperation != op.Sub
        {
            CurrentOperation = op.Sub
            CurrentNumber = String(CurrentNumber.characters.dropLast())
            CurrentNumber += LeftOperand + "-"
            Display(Str : CurrentNumber)
            CurrentNumber = ""
        }
    }

    @IBAction func OnMulBtnClick(_ sender: Any) {
        playsound()
        if CurrentNumber != "" {
            LeftOperand = CurrentNumber
            CurrentNumber += "*"
            Display(Str: CurrentNumber)
            CurrentNumber = ""
            CurrentOperation = op.Mul
        }
       
        if CurrentOperation != op.Mul
        {
            CurrentOperation = op.Mul
            CurrentNumber = String(CurrentNumber.characters.dropLast())
            CurrentNumber += LeftOperand + "*"
            Display(Str : CurrentNumber)
            CurrentNumber = ""
        }


    }
    
    @IBAction func OnDivBtnClick(_ sender: Any) {
        playsound()
        if CurrentNumber != "" {
            LeftOperand = CurrentNumber
            CurrentNumber += "/"
            Display(Str: CurrentNumber)
            CurrentNumber = ""
            CurrentOperation = op.Div
        }
        
        if CurrentOperation != op.Div
        {
            CurrentOperation = op.Div
            CurrentNumber = String(CurrentNumber.characters.dropLast())
            CurrentNumber += LeftOperand + "/"
            Display(Str : CurrentNumber)
            CurrentNumber = ""
        }



    }
    
    
    @IBAction func OnAddBtnClick(_ sender: Any) {
        playsound()
        if CurrentNumber != "" {
            LeftOperand = CurrentNumber
            CurrentNumber += "+"
            Display(Str: CurrentNumber)
            CurrentNumber = ""
            CurrentOperation = op.Add
        }
        
        if CurrentOperation != op.Add
        {
            CurrentOperation = op.Add
            CurrentNumber = String(CurrentNumber.characters.dropLast())
            CurrentNumber += LeftOperand + "+"
            Display(Str : CurrentNumber)
            CurrentNumber = ""
        }


    }
    
    @IBAction func OnEqualBtnClick(_ sender: Any) {
        playsound()
        calculate()
    }
    
    func playsound()
    {
        if (BtnSound?.isPlaying)!
        {
            BtnSound?.stop()
        }
        BtnSound?.play()
    }
    
    func calculate()
    {
        if LeftOperand != ""
        {
        switch CurrentOperation {
        case op.Sub:
            Result = "\(Double(LeftOperand)! - Double(CurrentNumber)!)"
        case op.Mul:
            Result = "\(Double(LeftOperand)! * Double(CurrentNumber)!)"
        case op.Div:
            Result = "\(Double(LeftOperand)! / Double(CurrentNumber)!)"
        case op.Add:
            Result = "\(Double(LeftOperand)! + Double(CurrentNumber)!)"
        case op.Empty:
            Result = "0"
        }
        Display(Str: Result)
        clear()
        }
        else
        {
            Display(Str: "0")
            clear()
        }
    }
    
    func clear()
    {
        Result = ""
        LeftOperand = ""
        CurrentNumber = ""
        CurrentOperation = op.Empty
    }
    
    func Display(Str : String)
    {
        OutLb.text = Str
    }
}

