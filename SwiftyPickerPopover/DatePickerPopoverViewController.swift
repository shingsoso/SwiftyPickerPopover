//
//  DatePickerPopoverViewController.swift
//  SwiftyPickerPopover
//
//  Created by Yuta Hoshino on 2016/09/14.
//  Copyright © 2016 Yuta Hoshino. All rights reserved.
//

import Foundation
import UIKit

open class DatePickerPopoverViewController: AbstractPickerPopoverViewController {
    
    typealias PopoverType = DatePickerPopover
    
    var popover:PopoverType?
    
    @IBOutlet weak var picker: UIDatePicker!
    @IBOutlet weak var clearButton: UIButton!

    var hideClearButton: Bool = false
    
    override open func viewWillAppear(_ animated: Bool) {
        if let pp = popover {
            if let _ = pp.clearAction_ { }
            else {
                clearButton.removeFromSuperview()
                view.layoutIfNeeded()
            }
        }
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        if let pp = popover {
            picker.date = pp.selectedDate_
            picker.minimumDate = pp.minimumDate_
            picker.maximumDate = pp.maximumDate_
            picker.datePickerMode = pp.dateMode_
            picker.minuteInterval = pp.minuteInterval_
        }
    }
    
    
    @IBAction func tappedDone(_ sender: UIButton? = nil) {
        popover?.doneAction_?(popover!, picker.date)
        dismiss(animated: false, completion: {})
    }
    
    @IBAction open func tappedCancel(_ sender: AnyObject? = nil) {
        popover?.cancelAction_?(popover!)
        dismiss(animated: false, completion: {})
    }
    
    @IBAction func tappedClear(_ sender: UIButton? = nil) {
        popover?.clearAction_?(popover!)
    }
    
    @IBAction func valueChanged(_ sender: Any) {
        popover?.redoDisappearAutomatically()
    }
    
    open func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
        tappedCancel()
    }
}
