//
//  LocalRealmImpl.swift
//  AppStoreSearchDemoCore
//
//  Created by Jinwoo Kim on 8/4/21.
//

import Foundation
import RealmSwift
import RxSwift

private var kOperationQueues: [String: OperationQueue] = [:]

final class LocalRealmImpl: LocalRealm {
    
    func objects<T: Object>(predicate: NSPredicate?) -> Single<[T]> {
        return .create { promise in
            
            let operation: BlockOperation = .init {
                do {
                    let realmStore: Realm = try self.realmStore(type: T.self)
                    var results: Results<T> = realmStore.objects(T.self)
                    
                    if let predicate: NSPredicate = predicate {
                        results = results.filter(predicate)
                    }
                    
                    promise(.success(results.objects))
                } catch {
                    promise(.failure(error))
                }
            }
            
            self.queue(type: T.self).addOperation(operation)
            
            return Disposables.create {
                operation.cancel()
            }
        }
    }
    
    func objects<T>(predicate: NSPredicate?, sortKV: String, ascending: Bool) -> Single<[T]> where T : Object {
        return .create { promise in
            
            let operation: BlockOperation = .init {
                do {
                    let realmStore: Realm = try self.realmStore(type: T.self)
                    var results: Results<T> = realmStore.objects(T.self)
                    
                    if let predicate: NSPredicate = predicate {
                        results = results.filter(predicate)
                    }
                    
                    results = results.sorted(byKeyPath: sortKV, ascending: ascending)
                    
                    promise(.success(results.objects))
                } catch {
                    promise(.failure(error))
                }
            }
            
            self.queue(type: T.self).addOperation(operation)
            
            return Disposables.create {
                operation.cancel()
            }
        }
    }
    
    func create<T: Object>(block: @escaping ((T) -> ())) -> Single<T> {
        return .create { promise in
            
            let operation: BlockOperation = .init {
                do {
                    let realmStore: Realm = try self.realmStore(type: T.self)
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
            
            self.queue(type: T.self).addOperation(operation)
            
            return Disposables.create {
                operation.cancel()
            }
        }
    }
    
    func modify<T: Object>(_ object: T, block: @escaping ((T) -> ())) -> Single<T> {
        return .create { promise in
            
            let ref: ThreadSafeReference = .init(to: object)
            
            let operation: BlockOperation = .init {
                do {
                    let realmStore: Realm = try self.realmStore(type: T.self)
                    
                    try realmStore.write {
                        guard let _object: T = realmStore.resolve(ref) else {
                            promise(.failure(LocalError.realmThreadSolveFailed))
                            return
                        }
                        block(_object)
                        promise(.success(_object))
                    }
                } catch {
                    promise(.failure(error))
                }
            }
            
            self.queue(type: T.self).addOperation(operation)
            
            return Disposables.create {
                operation.cancel()
            }
        }
    }
    
    func delete<T: Object>(_ object: T) -> Completable {
        return .create { promise in
            let ref: ThreadSafeReference = .init(to: object)
            
            let operation: BlockOperation = .init {
                do {
                    let realmStore: Realm = try self.realmStore(type: T.self)
                    
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
            
            self.queue(type: T.self).addOperation(operation)
            
            return Disposables.create {
                operation.cancel()
            }
        }
    }
    
    func observe(type: Object.Type) -> Observable<Void> {
        return .create { observer in
            do {
                let realmStore: Realm = try self.realmStore(type: type)
                
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
        .startWith(())
    }
    
    private func queue(type: Object.Type) -> OperationQueue {
        let name: String = String(describing: type)
        
        if let queue: OperationQueue = kOperationQueues[name] {
            return queue
        } else {
            let queue: OperationQueue = .init()
            queue.qualityOfService = .userInteractive
            queue.maxConcurrentOperationCount = 1
            kOperationQueues[name] = queue
            return queue
        }
    }
    
    private func realmStore(type: Object.Type) throws -> Realm {
        let name: String = String(describing: type)
        
        var config: Realm.Configuration = .defaultConfiguration
        config.fileURL?.deleteLastPathComponent()
        config.fileURL?.appendPathComponent(name)
        config.fileURL?.appendPathExtension("realm")
        
        let realmStore: Realm = try .init(configuration: config)
        return realmStore
    }
}
