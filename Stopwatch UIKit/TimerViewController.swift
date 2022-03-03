//
//  TimerViewController.swift
//  Stopwatch UIKit
//
//  Created by Temirlan Idrissov on 03.03.2022.
//

import UIKit
import SnapKit

class TimerViewController: UIViewController {
    
    private lazy var timeLabel: UILabel = {
       let label = UILabel()
        label.text = "00:00"
        label.font = .systemFont(ofSize: 42, weight: .regular)
        label.textColor = .white
        return label
    }()
    
    
    //MARK: -ActionButton-
    private lazy var actionButton: UIButton = {
       let button = UIButton()
        button.setTitle("Start", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        button.backgroundColor = UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 0.3)
        button.layer.cornerRadius = 17
        button.addTarget(self, action: #selector(handleActionButton), for: .touchUpInside)
        return button
    }()
    
    @objc private func handleActionButton() {
        startPauseTapped()
    }
    
    @objc func tapStopWatchLabel() {
        actionButton.isHidden = false
        timeLabel.isHidden = false
    }
    
    @objc func tapCountDownLabel() {
        actionButton.isHidden = true
        timeLabel.isHidden = true
    }
    
    //MARK: -Stopwatch-
    var timer: Timer = Timer()
    var count: Int = 0
    var timerCounting: Bool = false
    
    private func startPauseTapped() {
        if timerCounting {
            timerCounting = false
            timer.invalidate()
            actionButton.backgroundColor = UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 0.3)
            actionButton.layer.borderWidth = 0
        }else {
            timerCounting = true
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
            actionButton.backgroundColor = UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 0.3)
        }
        actionButton.setTitle(timerCounting ? "Pause":"Start", for: .normal)
    }

    @objc private  func timerCounter() -> Void {
        count = count + 1
        let time = secondsToMinutes(seconds: count)
        let timeString = makeTimeString(minutes: time.0, seconds: time.1)
        timeLabel.text = timeString
    }
    
    private func secondsToMinutes(seconds: Int) -> (Int, Int) {
        return ((seconds / 60), (seconds % 60))
    }
    
    private func makeTimeString(minutes: Int, seconds: Int) -> String {
        var timeString = ""
        timeString += String(format: "%02d", minutes)
        timeString += ":"
        timeString += String(format: "%02d", seconds)
        return timeString
    }
    
    //MARK: -ViewDidLoad-
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.93, green: 0.08, blue: 0.08, alpha: 1)
        setUI()
    }
    
    //MARK: -SetUI-
    private func setUI() {
        view.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(actionButton)
        actionButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(timeLabel.snp.bottom).offset(24)
            make.width.equalTo(121)
            make.height.equalTo(50)
        }
    }
}

