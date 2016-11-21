//
//  MainTableViewModel.swift
//  GraphQLConnector
//
//  Created by LostSeaWay on 9/28/2559 BE.
//  Copyright © 2559 TW-LostSeaWay. All rights reserved.
//

import Gloss
import RxSwift

class MainTableViewModel {
    var data = [People]()
    var client = Client()
    lazy var dataVariable: Variable<[People]> = {
        return Variable(self.data)
    }()
    
    let disposeBag = DisposeBag()
    
    init() {
        loadData().subscribe(onNext: { [unowned self] heros in
            self.data = heros
            self.dataVariable.value = heros
        }).addDisposableTo(disposeBag)
    }
    
    func loadData() -> Observable<[People]>{
        let peopleQuery = PeopleQuery(label: "people", fields: [.id,.name], arguments: nil)
        let allQuery = AllPeopleQuery(label: "allPeople", fields: [.people(peopleQuery)], arguments: nil)
        return PeopleRequest(connector: client.connector, query: "{\(allQuery.serialized())}").call()
    }
}


