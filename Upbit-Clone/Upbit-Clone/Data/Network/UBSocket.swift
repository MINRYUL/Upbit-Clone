//
//  UBSocket.swift
//  Upbit-Clone
//
//  Created by 김민창 on 2022/04/23.
//

import Foundation

import RxSwift
import RxCocoa

enum UBSocketError: Error {
    case urlError
    case webSocketIsNotExist
    case connectionError
    case networkError
    case unknown
}

struct UBSocketOutput {
    var receiveData: PublishSubject<Data?>
    var receiveString:  PublishSubject<String?>
}

final class UBSocket: NSObject {
    static let shared = UBSocket()
    
    private override init() {
        self.output = UBSocketOutput(
            receiveData: _receiveData,
            receiveString: _receiveString
        )
    }
    
    let output: UBSocketOutput
    
    private var disposed: DisposeBag = DisposeBag()
    
    //MARK: - Output
    private var _receiveData = PublishSubject<Data?>()
    private var _receiveString = PublishSubject<String?>()
    
    private var webSocket: URLSessionWebSocketTask?
    private var isOpened: Bool = false
    
    func closeSocket() {
        self.webSocket?.cancel(with: .goingAway, reason: nil)
        self.isOpened = false
        self.webSocket = nil
    }
    
    func openSocketWithURL(_ url: String) {
        guard let url = URL(string: url) else {
            _receiveData.onError(UBSocketError.urlError)
            _receiveString.onError(UBSocketError.urlError)
            return
        }
        if !self.isOpened { self.openWebSocket(url: url) }
        
        guard let webSocket = self.webSocket else {
            _receiveData.onError(UBSocketError.webSocketIsNotExist)
            _receiveString.onError(UBSocketError.urlError)
            return
        }
        
        webSocket.receive(completionHandler: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure:
                self._receiveData.onError(UBSocketError.connectionError)
                self._receiveString.onError(UBSocketError.connectionError)
            case .success(let webSocketTaskMessage):
                switch webSocketTaskMessage {
                case .data(let data):
                    self._receiveData.onNext(data)
                case .string(let str):
                    self._receiveString.onNext(str)
                default:
                    self._receiveData.onError(UBSocketError.unknown)
                    self._receiveString.onError(UBSocketError.unknown)
                    fatalError("Failed. Received unknown data format. Expected String")
                }
            }
        })
    }
    
    private func openWebSocket(url: URL) {
        let request = URLRequest(url: url)
        let session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
        let webSocket = session.webSocketTask(with: request)
        self.webSocket = webSocket
        self.webSocket?.resume()
    }
}

extension UBSocket: URLSessionWebSocketDelegate {
    func urlSession(
        _ session: URLSession,
        webSocketTask: URLSessionWebSocketTask,
        didOpenWithProtocol protocol: String?
    ) {
        self.isOpened = true
    }
    

    func urlSession(
        _ session: URLSession,
        webSocketTask: URLSessionWebSocketTask,
        didCloseWith closeCode: URLSessionWebSocketTask.CloseCode,
        reason: Data?
    ) {
        self.webSocket = nil
        self.isOpened = false
    }
}
