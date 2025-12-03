//
//  FileLogger.swift
//  Platform
//
//  Created by Ankit Panchotiya on 18/07/25.
//

import Foundation

enum LogType {
    case page
    case network
    case action
    case error
    case system

    var logLevel: String {
        switch self {
        case .page:
            return "Page"
        case .network:
            return "Network"
        case .action:
            return "Action"
        case .error:
            return "Error"
        case .system:
            return "System"
        }
    }
}

protocol LoggerLocalLog {
    func log(_ message: String, type: LogType)
}

final class LogFileLogger: LoggerLocalLog {

    private let writingQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.name = "LogFileLogger writing queue"
        queue.maxConcurrentOperationCount = 1
        return queue
    }()

    private let appPath = "app.log"
    private let logger: FileLogger
    private let maxSize: UInt64 = 1_000_000 // 1MB

    init(logger: FileLogger = DefaultFileLogger()) {
        self.logger = logger
    }

    func log(_ message: String, type: LogType) {
        print(message)
        let dir = URL(fileURLWithPath: FileManager.documentsDirectory())
        let fileUrl = dir.appendingPathComponent(appPath)

        logger.logToFile(
            logText: message,
            logLevel: type.logLevel,
            fileURL: fileUrl,
            fileMaxSize: maxSize,
            writingQueue: writingQueue
        )
    }
}

protocol FileLogger {
    func logToFile(
        logText: String,
        logLevel: String,
        fileURL: URL,
        fileMaxSize: UInt64,
        writingQueue: OperationQueue
    )
}

final class DefaultFileLogger: FileLogger {
    private let numberOfLinesToRemove = 2000

    private func getLogPath() -> [URL] {
        let documentsDirectory = FileManager.documentsDirectory()
        do {
            let fileUrls = try FileManager.default.contentsOfDirectory(at: URL(string: documentsDirectory)!, includingPropertiesForKeys: nil)
            return fileUrls.filter { fileUrl -> Bool in
                let fileName = fileUrl.lastPathComponent
                return fileName.hasSuffix("log")
            }
        } catch {
            debugPrint("Error while trying to retrieve log files!")
            return []
        }
    }

    private func deleteAll() {
        let logUrls = getLogPath()
        for log in logUrls where FileManager.default.isDeletableFile(atPath: log.path) {
            do {
                try FileManager.default.removeItem(at: log)
            } catch {
                debugPrint("Error while trying to remove log files!")
            }
        }
    }

    private func checkSizeAndRemoveIfNeeded(fileURL: URL, maxSize: UInt64, writingQueue: OperationQueue) {
        do {
            let attributes = try FileManager.default.attributesOfItem(atPath: fileURL.path) as NSDictionary
            if attributes.fileSize() > maxSize {
                debugPrint("Logged files higer then max size, will remove lines.")
                removeLinesFromFile(fileURL, numLines: numberOfLinesToRemove, writingQueue: writingQueue)
            }
        } catch {
            debugPrint(error.localizedDescription)
        }
    }

    private func removeLinesFromFile(_ fileURL: URL, numLines: Int, writingQueue: OperationQueue) {
        do {
            let data = try NSData(contentsOf: fileURL, options: .mappedIfSafe)
            let newLine = "\n".data(using: .utf8)!

            var lineNo = 0
            var pos = 0

            while lineNo < numLines {
                // Find next newline character
                let range = data.range(of: newLine, options: [], in: NSRange(location: pos, length: data.length - pos))
                if range.location == NSNotFound {
                    return // File has less than numLines
                }
                lineNo += 1
                pos = range.location + range.length
            }
            // pos is at position where line number numLines begins
            let trimmedData = data.subdata(with: NSRange(location: pos, length: data.length - pos))
            writingQueue.addOperation {
                do {
                    try trimmedData.write(to: fileURL, options: .atomic)
                } catch {
                    debugPrint(error.localizedDescription)
                }
            }
        } catch {
            debugPrint(error.localizedDescription)
        }
    }

    func logToFile(
        logText: String,
        logLevel: String,
        fileURL: URL,
        fileMaxSize: UInt64,
        writingQueue: OperationQueue
    ) {
        checkSizeAndRemoveIfNeeded(fileURL: fileURL, maxSize: fileMaxSize, writingQueue: writingQueue)
        let string = "\(Date().stringWithMiliSec()): - [\(logLevel)] - \(logText)\n"
        guard let data = string.data(using: .utf8, allowLossyConversion: false) else { return }
        writingQueue.addOperation {
            do {
                if FileManager.default.fileExists(atPath: fileURL.path) {
                    let fileHandle = try FileHandle(forUpdating: fileURL)
                    fileHandle.seekToEndOfFile()
                    fileHandle.write(data)
                    fileHandle.closeFile()
                } else {
                    try data.write(to: fileURL, options: .atomic)
                }
            } catch {
                debugPrint(error.localizedDescription)
            }
        }
    }

}

private extension Date {
    func stringWithMiliSec() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        return dateFormatter.string(from: self)
    }
}

extension FileManager {
    static func documentsDirectory() -> String {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    }
}
