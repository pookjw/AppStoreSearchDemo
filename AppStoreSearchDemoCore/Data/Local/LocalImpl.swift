//
//  LocalImpl.swift
//  AppStoreSearchDemoCore
//
//  Created by Jinwoo Kim on 8/4/21.
//

import Foundation
import RealmSwift
import RxSwift

private var kOperationQueues: [String: OperationQueue] = [:]

class LocalImpl<T: RealmSwift.Object>: Local {
    typealias Object = T
    
    private var queue: OperationQueue!
    
    init() {
        configureQueue()
    }
    
    func objects(predicate: NSPredicate?) -> Single<[T]> {
        return .create { promise in
            
            let operation: BlockOperation = .init {
                do {
                    let realmStore: Realm = try self.newRealmStore()
                    var results: Results<T> = realmStore.objects(T.self)
                    
                    if let predicate: NSPredicate = predicate {
                        results = results.filter(predicate)
                    }
                    
                    promise(.success(results.objects))
                } catch {
                    promise(.failure(error))
                }
            }
            
            self.queue.addOperation(operation)
            
            return Disposables.create {
                operation.cancel()
            }
        }
    }
    
    func create(block: @escaping ((T) -> ())) -> Single<T> {
        return .create { promise in
            
            let operation: BlockOperation = .init {
                do {
                    let realmStore: Realm = try self.newRealmStore()
                    let object: T = .init()
                    block(object)
                    
                    try realmStore.write {
                        realmStore.add(object)
                        promise(.success(object))
                    }
                } catch {
                    promise(.failure(error))
                }
            }
            
            self.queue.addOperation(operation)
            
            return Disposables.create {
                operation.cancel()
            }
        }
    }
    
    func modify(_ object: T, block: @escaping ((T) -> ())) -> Completable {
        return .create { promise in
            
            let ref: ThreadSafeReference = .init(to: object)
            
            let operation: BlockOperation = .init {
                do {
                    let realmStore: Realm = try self.newRealmStore()
                    
                    try realmStore.write {
                        guard let _object: T = realmStore.resolve(ref) else {
                            promise(.error(LocalError.realmThreadSolveFailed))
                            return
                        }
                        block(_object)
                        promise(.completed)
                    }
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
    
    func delete(_ object: T) -> Completable {
        return .create { promise in
            let ref: ThreadSafeReference = .init(to: object)
            
            let operation: BlockOperation = .init {
                do {
                    let realmStore: Realm = try self.newRealmStore()
                    
                    try realmStore.write {
                        guard let _object: T = realmStore.resolve(ref) else {
                            promise(.error(LocalError.realmThreadSolveFailed))
                            return
                        }
                        realmStore.delete(_object)
                        promise(.completed)
                    }
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
    
    func observe() -> Observable<Void> {
        return .create { observer in
            do {
                let realmStore: Realm = try self.newRealmStore()
                
                let token: NotificationToken = realmStore.observe { _, realmStore in
                    observer.onNext(())
                }
                
                return Disposables.create {
                    token.invalidate()
                }
            } catch {
                observer.onError(error)
                return Disposables.create()
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
            queue.maxConcurrentOperationCount = 1
            self.queue = queue
            kOperationQueues[name] = queue
        }
    }
    
    private func newRealmStore() throws -> Realm {
        let name: String = String(describing: T.self)
        
        var config: Realm.Configuration = .defaultConfiguration
        config.fileURL?.deleteLastPathComponent()
        config.fileURL?.appendPathComponent(name)
        config.fileURL?.appendPathExtension("realm")
        
        let realmStore: Realm = try .init(configuration: config)
        return realmStore
    }
}
