//
//  LocalImpl.swift
//  AppStoreSearchDemoCore
//
//  Created by Jinwoo Kim on 8/4/21.
//

import Foundation
import RealmSwift
import RxSwift

private var kRealmStores: [String: Realm] = [:]
private var kOperationQueues: [String: OperationQueue] = [:]

class LocalImpl<T: RealmSwift.Object>: Local {
    typealias Object = T
    
    private var realmStore: Realm!
    private var queue: OperationQueue!
    
    init() {
        configureQueue()
        configureRealmStore()
    }
    
    func objects(predicate: NSPredicate?) -> Single<[T]> {
        return .create { promise in
            
            let operation: BlockOperation = .init {
                var results: Results<T> = self.realmStore.objects(T.self)
                
                if let predicate: NSPredicate = predicate {
                    results = results.filter(predicate)
                }
                
                promise(.success(results.objects))
            }
            
            self.queue.addOperation(operation)
            
            return Disposables.create {
                operation.cancel()
            }
        }
    }
    
    func add(_ object: T) -> Completable {
        return .create { promise in
            
            let operation: BlockOperation = .init {
                print(Thread.current)
                do {
                    try self.realmStore.write {
                        self.realmStore.add(object)
                    }
                    promise(.completed)
                } catch {
                    promise(.error(error))
                }
            }
            
            self.queue.addOperation(operation)
            
            return Disposables.create {
                operation.cancel()
            }
        }
    }
    
    private func configureQueue() {
        let name: String = String(describing: T.self)
        
        if let queue: OperationQueue = kOperationQueues[name] {
            self.queue = queue
        } else {
            let queue: OperationQueue = .init()
            queue.qualityOfService = .userInteractive
            self.queue = queue
            kOperationQueues[name] = queue
        }
    }
    
    private func configureRealmStore() {
        let semaphore: DispatchSemaphore = .init(value: 0)
        
        queue.addOperation {
            let name: String = String(describing: T.self)

            if let realmStore: Realm = kRealmStores[name] {
                self.realmStore = realmStore
            } else {
                var config: Realm.Configuration = .defaultConfiguration
                config.fileURL?.deleteLastPathComponent()
                config.fileURL?.appendPathComponent(name)
                config.fileURL?.appendPathExtension("realm")
                
                let realmStore: Realm = try! .init(configuration: config)
                self.realmStore = realmStore
                kRealmStores[name] = realmStore
            }
            
            print(Thread.current)
            
            semaphore.signal()
        }
        
        semaphore.wait()
    }
}
