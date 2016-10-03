//
//  MainTableViewController.swift
//  GraphQLConnector
//
//  Created by LostSeaWay on 9/28/2559 BE.
//  Copyright © 2559 TW-LostSeaWay. All rights reserved.
//

import UIKit
import RxSwift

class MainTableViewController: UITableViewController {

    private let viewModel = MainTableViewModel()
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        bindSignal()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.data.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        cell.textLabel?.text = viewModel.data[indexPath.row].name

        return cell
    }
    
    func bindSignal() {
        viewModel.dataVariable.asObservable().subscribe(onNext: { _ in
            self.tableView.reloadData()
        }).addDisposableTo(disposeBag)
    }

}
