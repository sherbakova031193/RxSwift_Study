//
//  ViewController.swift
//  RxSwift_Study
//
//  Created by Елизавета Щербакова on 30.01.2021.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var button: UIButton!
    
    var text = PublishSubject<String>()
    var buttonSubject = PublishSubject<String>()
    
    @IBOutlet weak var textFieldForImputsInLabel: UITextField!
    @IBOutlet weak var labelForTextField: UILabel!

    @IBOutlet var tapGR: UITapGestureRecognizer!
    
    @IBOutlet weak var textViewForImputsInLabel: UITextView!
    @IBOutlet weak var labelForTextView: UILabel!
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var labelForSegmentedControl: UILabel!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var labelForDatePicker: UILabel!
    
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var labelForStepper: UILabel!
    
    @IBOutlet weak var switchControl: UISwitch!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        return dateFormatter
    }()
    
    let disposeDag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindStrinAndTextField()
        configurationButton()
        bindLabelAndTextField()
        configurationTapGR()
        bindLabelAndTextView()
        bindSliderAndProgressView()
        bindSegmentedControllAndLabel()
        bindDatePickerAndLabel()
        bindStepperAndLabel()
        bindSwitchAndActivityIndicator()
    }
    
    private func configurationButton() {
        button.rx.tap.map { "The button was pressed" }.bind(to: buttonSubject).disposed(by: disposeDag)
        
        buttonSubject.asObservable().subscribe {
            print($0)
        }.disposed(by: disposeDag)
    }
    
    private func bindStrinAndTextField() {
        textField.rx.text.orEmpty.bind(to: text).disposed(by: disposeDag)
        
        text.asObservable().subscribe {
            print($0)
        }.disposed(by: disposeDag)
    }
    
    private func bindLabelAndTextField() {
        textFieldForImputsInLabel.rx.text.bind {
            self.labelForTextField.rx.text.onNext($0)
        }.disposed(by: disposeDag)
        
        ///compact version:
//        textFieldForImputsInLabel.rx.text.bind {
//            self.labelForTextField.text = $0
//        }.disposed(by: disposeDag)
    }
    
    private func configurationTapGR() {
        tapGR.rx.event.asDriver().drive { [unowned self] _ in
            self.view.endEditing(true)
        }.disposed(by: disposeDag)
    }
    
    private func bindLabelAndTextView() {
        textViewForImputsInLabel.rx.text.bind { text in
            if  let text = text {
                self.labelForTextView.text = "Character count: \(text.count)"
            }
        }.disposed(by: disposeDag)
    }
    
    private func bindSliderAndProgressView() {
        slider.rx.value.asDriver().drive(progressView.rx.progress).disposed(by: disposeDag)
    }
    
    private func bindSegmentedControllAndLabel() {
        segmentedControl.rx.value.asDriver().drive {
            self.labelForSegmentedControl.text = "Selected segment = \($0 + 1)"
        }.disposed(by: disposeDag)
        
         /// display after the first press
//        segmentedControl.rx.value.asDriver().skip(1).drive {
//            self.labelForSegmentedControl.text = "Selected segment = \($0 + 1)"
//        }.disposed(by: disposeDag)
    }
    
    private func bindDatePickerAndLabel() {
        datePicker.rx.date
            .asDriver()
            .map {
                self.dateFormatter.string(from: $0)
            }
            .drive {
                self.labelForDatePicker.text = "Selected date: \($0)"
            }
            .disposed(by: disposeDag)
    }
    
    private func bindStepperAndLabel() {
        stepper.rx.value.asDriver().map { "\($0)" }
            .drive(labelForStepper.rx.text).disposed(by: disposeDag)
    }
    
    private func bindSwitchAndActivityIndicator() {
        switchControl.rx.isOn.asDriver().map {!$0 }.drive(activityIndicator.rx.isHidden)
            .disposed(by: disposeDag)
        
        switchControl.rx.isOn.asDriver().drive(activityIndicator.rx.isAnimating)
            .disposed(by: disposeDag)
    }
}

