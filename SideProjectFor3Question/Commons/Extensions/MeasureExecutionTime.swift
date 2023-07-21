import Foundation

func measureExecutionTime(block: () -> Void) -> String {
    let startTime = DispatchTime.now()
    block()
    let endTime = DispatchTime.now()

    let nanoseconds = endTime.uptimeNanoseconds - startTime.uptimeNanoseconds
    let milliseconds = Double(nanoseconds) / 1_000_000

    return "執行時間: \(milliseconds) ms"
}
