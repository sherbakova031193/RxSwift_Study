import UIKit
import RxSwift
import RxCocoa
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

//MARK: - SUBJECT
startExample("PublishSubject") {
    let disposeBag = DisposeBag()
    
    let subject = PublishSubject<String>()
    subject.subscribe {
        print("First subscriber:", $0)
    }.disposed(by: disposeBag)
    
    subject.on(.next("Hello"))
    //subject.onCompleted()
    subject.onNext("RxSwif")
    
    subject.subscribe {
        print("Second subscriber:",  $0)
    }.disposed(by: disposeBag)
    
    subject.onNext("How are you?")
}

startExample("BehaviorSubject") {
    let disposeBag = DisposeBag()
    let subject = BehaviorSubject(value: 1) // [1]
    
    subject.subscribe {
        print( #line, $0)
    }.disposed(by: disposeBag)
    
    subject.onNext(2) // [1, 2]
    subject.onNext(3) // [1,2,3]
    
    subject.map{ $0 + 2 }.subscribe {
        print( #line, $0) // [3]
    }.disposed(by: disposeBag)
}

startExample("ReplaySubject") {
    let disposeBag = DisposeBag()
    let subject = ReplaySubject<String>.create(bufferSize: 2)
    
    subject.subscribe {
        print("First subcription", $0)
    }.disposed(by: disposeBag)
    
    subject.onNext("A")
    subject.onNext("B")
    
    subject.subscribe {
        print("Second subcription", $0)
    }.disposed(by: disposeBag)
    
    subject.onNext("C")
    subject.onNext("D")
}

//MARK: - Side Effect
startExample("Side Effect") {
    let disposeBag = DisposeBag()
    let observable = Observable.from([0, 32, 300, -40])
    
    observable.do {
        print("\($0)F = ", terminator: "")
    }.map {
        Double($0 - 32) * 5/9.0
    }.subscribe {
        print(String(format: "%.1f", $0))
    }.disposed(by: disposeBag)
}

//MARK: - Schedulers
startExample("Without observeOn") {
    let disposeBag = DisposeBag()
    Observable.of(1,2,3)
        .subscribe {
            print(Thread.current, $0)
        } onError: { (error) in
            print("error")
        } onCompleted: {
            print("onCompleted")
        } onDisposed: {
            print("onDisposed")
        }.disposed(by: disposeBag)

}

startExample("observeOn") {
    let disposeBag = DisposeBag()
    Observable.of(12,3,456)
        .observe(on: ConcurrentDispatchQueueScheduler(qos: .background))
        .subscribe {
            print(Thread.current, $0)
        } onError: { (error) in
            print("error")
        } onCompleted: {
            print("onCompleted")
        } onDisposed: {
            print("onDisposed")
        }.disposed(by: disposeBag)
}

startExample("subscribeOn and observeOn") {
    print("Init",Thread.current)
    Observable<Int>.create { (observer) -> Disposable in
        print("Observable thread:", Thread.current)
        observer.onNext(1)
        observer.onNext(2)
        observer.onNext(3)
        return Disposables.create()
    }
    .subscribe(on: SerialDispatchQueueScheduler.init(qos: .background))
    .observe(on: MainScheduler.instance)
    .subscribe {
        print(print("subscribe thread:", Thread.current, $0))
    }
}

//MARK: - Units

startExample("Driver") {
     
}
