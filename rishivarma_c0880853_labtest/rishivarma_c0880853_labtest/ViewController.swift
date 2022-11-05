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
    case Reset
    case Stop
}

class ViewController: UIViewController {

    
    @IBOutlet weak var labelClock: UILabel!
    @IBOutlet weak var stackButtonsFlagPause: UIStackView!

    @IBOutlet weak var buttonLeft: UIButton!
    @IBOutlet weak var buttonRight: UIButton!
    @IBOutlet weak var tableFlags: UITableView!
    
    private var flags: [Flag] = []
    private var timer: Timer?
    private var timeElapsed: Int = 0
    private var curState = State.Stop
    
    override func viewDidLoad() {
        super.viewDidLoad()
        curState = .Reset
        buttonLeft.setTitle("Start", for: .normal)
        buttonRight.setTitle("Lap", for: .normal)
        stackButtonsFlagPause.isHidden = false
    }
    
    
    @IBAction func onLeftButtonClicked(_ sender: Any) {
        if curState == .Reset {
            buttonLeft.setTitle("Stop", for: .normal)
            buttonRight.setTitle("Lap", for: .normal)
            timerStart()
            curState = .Play
        } else if curState == .Play {
            onPause()
        } else if curState == .Stop {
            onPlay()
        }
    }
 
    @IBAction func onRightButtonClicked(_ sender: Any) {
        if curState == .Play {
            var timeGap = 0
            if let firstRow = flags.first {
                timeGap = timeElapsed - firstRow.timeDiff
            }
            flags.insert(Flag(index: flags.count, timeDiff: timeGap, flagTime: timeElapsed), at: 0)
        } else {
            timerEnd()
            timeElapsed = 0
            buttonLeft.setTitle("Start", for: .normal)
            buttonRight.setTitle("Lap", for: .normal)
            curState = .Reset
            labelClock.text = "00:00:00"
            flags.removeAll()
        }
        tableFlags.reloadData()
    }
    
    
    func onPlay() {
        timerStart()
        
        buttonLeft.setTitle("Stop", for: .normal)
        
        buttonRight.setTitle("Lap", for: .normal)
        
        curState = .Play
    }
    
    func onPause() {
        timerEnd()
        
        buttonLeft.setTitle("Start", for: .normal)
        
        buttonRight.setTitle("Reset", for: .normal)
        
        curState = .Stop
    }
    
    private func timerStart( ){
        timerEnd()
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true){_ in
            self.timeElapsed+=1
            self.labelClock.text = self.formatTimeLabel(timeEllapsed: self.timeElapsed)
        }
    }
    
    func timerEnd()  {
        timer?.invalidate()
    }
    
    private func formatTimeLabel (timeEllapsed: Int) ->String{
        let minutes = timeEllapsed / 100 / 60
        let seconds = timeEllapsed / 100
        let milliseconds = timeEllapsed % 100
        
        return String(format: "%02d:%02d:%02d", minutes, seconds, milliseconds)
    }
    
}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flags.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tablecellFlagStopWatch") as! StopWatchFlag
        let data = flags[indexPath.row]
        cell.index.text = "\(data.index)"
        cell.timeDifference.text = "+\(formatTimeLabel(timeEllapsed: data.timeDiff))"
        cell.flagTime.text = "\(formatTimeLabel(timeEllapsed: data.flagTime))"
        return cell
    }
}
