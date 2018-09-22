//
//  Conda.swift
//  SwiftReinforce
//
//  Created by Pope, John on 9/21/18.
//  Copyright © 2018 Sascha Schramm. All rights reserved.
//

import Foundation
import Python



extension PythonClass{
    
    
    
    func importPytorch(){
        
        print("import keras")
        keras = Python.import("keras")
        print("import torch")
        torch = Python.import("torch")
        
        // IMPORTANT - hack required to get  torchvision   to load
        // in you Users/admin/miniconda3/envs/gymai/lib/python2.7/site-packages/
        // rename torchvision-0.2.1-py2.7.egg file to .zip - extract out torch ision folder to site-packages
        let torchvision = Python.import("torchvision")
        let transforms = torchvision.transforms
        let transform = transforms.Compose(
            [transforms.ToTensor(),
             transforms.Normalize([0.5, 0.5, 0.5], [0.5, 0.5, 0.5])])
        let trainset = torchvision.datasets.CIFAR10(root:"./data", train:true,
                                                download:true, transform:transform)
        let trainloader = torch.utils.data.DataLoader(trainset, batch_size:4,
                                                  shuffle:true, num_workers:2)
        let testset = torchvision.datasets.CIFAR10(root:"./data", train:false,
                                               download:true, transform:transform)
        let testloader = torch.utils.data.DataLoader(testset, batch_size:4,
                                                 shuffle:false, num_workers:2)
        let classes = ("plane", "car", "bird", "cat","deer", "dog", "frog", "horse", "ship", "truck")
        
        let nn = Python.import("torch.nn")
        let F = Python.import("torch.nn.functional")
        let neuralNet = Python.import("NeuralNet").NeuralNet() //.py
        let optim = Python.import("torch.optim")
        let criterion = nn.CrossEntropyLoss()
        let optimizer = optim.SGD(neuralNet.parameters(), lr:0.001, momentum:0.9)
        
        var  runningLoss = 0.0
        
        for epoch in 0...2{
            runningLoss = 0.0
//            for (i, data) in Python.enumerate(trainloader, 0){
//                // get the inputs
//                let inputs, labels = data
//                
//                //  zero the parameter gradients
//                optimizer.zero_grad()
//                
//                //  forward + backward + optimize
//                outputs = net(inputs)
//                loss = criterion(outputs, labels)
//                loss.backward()
//                optimizer.step()
//                
//                // print statistics
//                running_loss += loss.item()
//            }
//
//            if i % 2000 == 1999:    # print every 2000 mini-batches
//            print("[%d, %5d] loss: %.3f" %  (epoch + 1, i + 1, running_loss / 2000))
            runningLoss = 0.0
            
            print("Finished Training")
        }
        
        
        
        
    }
    
}
