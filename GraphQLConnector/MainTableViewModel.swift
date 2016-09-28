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
    //var data = [Hero]()
    var data = [Hero]()
    lazy var dataVariable: Variable<[Hero]> = {
        return Variable(self.data)
    }()
    
    let disposeBag = DisposeBag()
    
    init() {
        loadData().subscribe(onNext: { [unowned self] heros in
            self.data = heros
            self.dataVariable.value = heros
        }).addDisposableTo(disposeBag)
    }
    
    func loadData() -> Observable<[Hero]>{
        return Client.requestObserve(query: [Hero].createQuery(bundleName: "allPeople", param: nil)).map({ response -> [Hero] in
                let data:JSON = ("data" <~~ response)!
                let allPeople:JSON = ("allPeople" <~~ data)!
                let people:[JSON] = ("people" <~~ allPeople)!
                return [Hero].from(jsonArray: people)!
            })
    }
}
