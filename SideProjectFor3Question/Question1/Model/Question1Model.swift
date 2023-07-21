import Foundation

class Question1Model: NSObject {
    override init() {
        super.init()
        debugPrint(self.classForCoder, "init")
    }
    deinit {
        debugPrint(self.classForCoder, "deinit")
    }
    func makeAnswer(number: Int) -> Int {
        if number < 1 { return number }
        var answer: Int = 0
        if number > 1 {
            let count: Int = (number - 2) / 2
            if number % 2 == 0 {
                answer = 3 + count
            } else {
                answer = 3 + count - number
            }
        } else {
            answer = 1
        }
        print("Question1: \(answer)")
        return answer
    }
}
