//
//  DeliveryDetails.swift
//  technicalexamTests
//
//  Created by iOS on 10/10/20.
//  Copyright © 2020 iOS. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Swinject

@testable import technicalexam

class DeliveryDetailsSpec: QuickSpec {
    override func spec() {
        var viewModel: DeliveryDetailsViewModel!
       
        beforeEach {
            viewModel = Assembler.shared.resolver.resolve(DeliveryDetailsViewModel.self)!
        }
        
        describe("delivery detail page") {
            it("can show details correctly") {
                
                let sender = Sender(phone: "9999999",
                                    name: "mark",
                                    email: "mark@gmail.com")
                
                let route = Route(start: "Metro Manila",
                                       end: "Legazpi City")
                
                let delivery = Delivery(id: "#000000",
                                        remarks: "a remrk",
                                        pickupTime: "2018-11-22T07:06:05-08:00",
                                        goodsPicture: "https://loremflickr.com/320/240/cat?lock=28542",
                                        deliveryFee: "$1",
                                        surcharge: "$20",
                                        route: route,
                                        sender: sender)
                
                viewModel.configure(delivery: delivery)
    
                let packageTotalFee = try! viewModel.outputs.totalFee.toBlocking().first()
                
                expect(packageTotalFee)
                    .to(equal("$21.00"))
                
                let pickUpTime = try! viewModel.outputs.pickUpTime.toBlocking().first()
                
                expect(pickUpTime)
                    .to(equal("Nov 22,2018 at 11:06 PM"))
            }
        }
    }
}
