//
//  DispatchViewController.swift
//  SwiftDispatch
//
//  Created by jiang hua hu on 2020/7/28.
//  Copyright © 2020 xjjd. All rights reserved.
//

import UIKit

class DispatchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        // self.DispatchSemaphoreFunc()
        
        // self.DispatchGroupFunc()
        
        // self.DispatchBarricFunc()
        
        self.DispatchAfterFunc()
    }
    

    //Dispatch Semaphore
       func DispatchSemaphoreFunc() {
           let workingQueue = DispatchQueue(label: "request_queue",attributes: .concurrent)
           let semaphore = DispatchSemaphore(value: 0)
            
            //模拟异步发送网络请求A
            workingQueue.async {
                Thread.sleep(forTimeInterval: 1.0)
                print("接口 A 数据请求完成")
                semaphore.signal()
            }
            
            //模拟异步发送网络请求B
            semaphore.wait()
            workingQueue.async {
                Thread.sleep(forTimeInterval: 1.0)
                print("接口 B 数据请求完成")
                semaphore.signal()
            }
            
            //模拟异步发送网络请求C
            semaphore.wait()
            workingQueue.async {
                Thread.sleep(forTimeInterval: 1.0)
                print("接口 C 数据请求完成")
                semaphore.signal()
            }
           
            print("我是最开始执行的，异步操作里的打印后执行")
           
            semaphore.wait()
            print("接口 A，B，C 请求完成，开始刷新UI")
       }

       //Dispatch Group
       func DispatchGroupFunc() {
           let workingQueue = DispatchQueue(label: "request_queue",attributes: .concurrent)
           let workingGroup = DispatchGroup()
                   
                   //模拟异步发送网络请求A
                   workingGroup.enter()
                   workingQueue.async {
                       Thread.sleep(forTimeInterval: 1.0)
                       print("接口 DispatchGroupA 数据请求完成")
                       workingGroup.leave()
                   }
                   
                   //模拟异步发送网络请求B
                   workingGroup.enter()
                   workingQueue.async {
                       Thread.sleep(forTimeInterval: 1.0)
                       print("接口 DispatchGroupB 数据请求完成")
                       workingGroup.leave()
                   }
                   
                   //模拟异步发送网络请求C
                   workingGroup.enter()
                   workingQueue.async {
                       Thread.sleep(forTimeInterval: 1.0)
                       print("接口 DispatchGroupC 数据请求完成")
                       workingGroup.leave()
                   }
                   
                   print("我是最开始执行DispatchGroup的，异步操作里的打印后执行")
                   
                   workingGroup.notify(queue: workingQueue) {
                       print("接口 DispatchGroupA，DispatchGroupB，DispatchGroupC 请求完成，开始刷新UI")
                   }
       }

       //Dispatch Barric
       func DispatchBarricFunc() {
           let workQueue = DispatchQueue.init(label: "com.dispatch.queue", qos: .default, attributes: .concurrent, autoreleaseFrequency: .workItem, target: .global())
           workQueue.async {
               print("A")
           }
           
           workQueue.asyncAfter(deadline:DispatchTime.now() + 5.0, execute: {
               print("B")
           })
           
           workQueue.async(flags:.barrier) {
               print("C")
           }
           
           workQueue.async {
               print("E",Thread.current)
               
               DispatchQueue.main.async {
                   print("update UI \(Thread.current)")
               }
           }
       }
       
       //Dispatch After
       func DispatchAfterFunc() {
           let workQueue = DispatchQueue.init(label: "com.dispatch.after",attributes: .concurrent)
           workQueue.asyncAfter(deadline: DispatchTime.now() + 5.0) {
               print("A")
           }
       }

}
