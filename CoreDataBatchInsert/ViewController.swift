//
//  ViewController.swift
//  CoreDataBatchInsert
//
//  Created by Jason Anderson on 3/12/22.
//

import UIKit

class ViewController: UIViewController {
    private lazy var viewModel = ViewModel()
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("starting import \(Date())")
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        viewModel.importData { result in
            switch result {
            case .failure(let error): print("error occurred: \(error)")
            case .success(_): print("date imported")
            }
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
            print("import complete \(Date())")
        }
    }


}

