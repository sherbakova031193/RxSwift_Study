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


