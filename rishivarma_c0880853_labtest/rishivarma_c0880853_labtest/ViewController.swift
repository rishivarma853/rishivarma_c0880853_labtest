//
//  ViewController.swift
//  rishivarma_c0880853_labtest
//
//  Created by RISHI VARMA on 2022-11-04.
//

import UIKit

struct Flag {
    let index : Int
    let timeDiff : Int
    let flagTime : Int
}

enum State {
    case Play
    case Pause
    case Stop
}

class ViewController: UIViewController {

    @IBOutlet weak var stopWatch: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var buttonFlag: UIButton!
    @IBOutlet weak var buttonPause: UIButton!
    @IBOutlet weak var tableFlags: UITableView!
    @IBOutlet weak var buttonFlagPauseStack: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

