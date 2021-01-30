import UIKit
import RxSwift
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

public func startExample(_ rxOperator: String, action: () -> () ) {
    print("\n----Example of: \(rxOperator)----")
    action()
}
///Documentation: http://reactivex.io/
///Charts:  https://rxmarbles.com/
/// Operator cheat sheet: https://habr.com/ru/post/281292/


startExample("Just") {
    // Observable
    let observable = Observable.just("Hello, RxSwift")
    
    //Observer
    observable.subscribe { event in
        print(event)
    }
}

startExample("Of") {
    // Observable
    let observable = Observable.of(1,2,3,4,5,6)
    
    //Observer
    observable.subscribe {
        print($0)
    }
}

startExample("Create") {
    let items = [1,2,3,4,5,6]
    
    Observable.from(items).subscribe { (item) in
        print(item)
    } onError: { (error) in
        print(error)
    } onCompleted: {
        print("onCompleted")
    } onDisposed: {
        print("onDisposed")
    }
}

startExample("Disposables") {
    let sec = [1,2,3]
    Observable.from(sec).subscribe {
        print($0)
    }
    Disposables.create()
}

startExample("Dispose") {
    let sec = [1,2,3]
    let subscription = Observable.from(sec)
    subscription.subscribe { (event) in
        print(event)
    }.dispose()
}

startExample("DisposeBag") {
    let disposeBag = DisposeBag()
    let seq = [1,2,3,4,5]
    let subscription = Observable.from(seq)
    subscription.subscribe {
        print($0)
    }.disposed(by: disposeBag)
}

startExample("TakeUntil") {
    let stopSeq = Observable.just(1).delaySubscription(.seconds(2), scheduler: MainScheduler.instance)
    let seq = Observable.from([1,2,3,5,6]).take(until: stopSeq)
    seq.subscribe {
        print($0)
    }
}

startExample("Filter") {
    let seq = Observable.of(1,2,3,5,6,7,8,29,34,78,86,78,789).filter { $0 > 10 }
    seq.subscribe {
        print($0)
    }
}

startExample("Map") {
    let seq = Observable.of(1,2,3).map { $0 + 3 }
    seq.subscribe {
        print($0)
    }
}

startExample("Merge") {
    let firtSeq = Observable.of(1,2,3)
    let secondSeq = Observable.of(4,5,6)
    let bothSeq = Observable.of(firtSeq, secondSeq)
    let mergeSec = bothSeq.merge()
    mergeSec.subscribe {
        print($0)
    }
}

