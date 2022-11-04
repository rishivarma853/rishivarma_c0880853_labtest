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

    
    @IBOutlet weak var labelClock: UILabel!
    @IBOutlet weak var buttonStart: UIButton!
    @IBOutlet weak var stackButtonsFlagPause: UIStackView!
    @IBOutlet weak var buttonFlag: UIButton!
    @IBOutlet weak var buttonPause: UIButton!
    @IBOutlet weak var tableFlags: UITableView!
    
    private var flags: [Flag] = []
    private var timer: Timer?
    private var timeElapsed: Int = 0
    private var curState = State.Stop
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func onStartButtonClicked(_ sender: Any) {
        timerStart()
        buttonStart.isHidden = true
        stackButtonsFlagPause.isHidden = false
        curState = .Play
    }
    
    @IBAction func onFlagButtonClicked(_ sender: Any) {
        if curState == .Play {
            var timeGap = 0
            if let firstRow = flags.first {
                timeGap = timeElapsed - firstRow.timeDiff
            }
            flags.insert(Flag(index: flags.count, timeDiff: timeGap, flagTime: timeElapsed), at: 0)
        } else {
            // Click on Stop button
            endTimer()
            timeElapsed = 0
            buttonStart.isHidden = false
            stackButtonsFlagPause.isHidden = true
            curState = .Stop
            labelClock.text = "00:00:00"
            flags.removeAll()
        }
        
        tableFlags.reloadData()

    }
    
    @IBAction func onPauseButtonClicked(_ sender: Any) {
        if curState == .Play{
            onPause()
        } else {
            onPlay()
        }
    }
    
    func onPlay() {
        timerStart()
        
        buttonFlag.setTitle("Flag", for: .normal)
        buttonFlag.setTitleColor(UIColor(named: "linkColor"), for: .normal)
        
        buttonPause.setTitle("Pause", for: .normal)
        buttonPause.setTitleColor(UIColor(named: "halloweenColor"), for: .normal)
        
        curState = .Play
    }
    
    func onPause() {
        timerEnd()
        
        buttonFlag.setTitle("Stop", for: .normal)
        buttonFlag.setTitleColor(UIColor(named: "systemRedColor"), for: .normal)
        
        buttonPause.setTitle("Play", for: .normal)
        buttonPause.setTitleColor(UIColor(named: "linkColor"), for: .normal)
        
        curState = .Pause
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "stopwatchFlag") as! StopwatchFlagCell
        let data = flags[indexPath.row]
        cell.index.text = "\(data.index)"
        cell.timeDifference.text = "+\(formatTimeLabel(timeEllapsed: data.timeDifference))"
        cell.flagTime.text = "\(formatTimeLabel(timeEllapsed: data.flagTime))"
        return cell
    }
}
