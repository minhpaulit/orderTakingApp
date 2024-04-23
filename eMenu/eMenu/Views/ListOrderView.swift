//
//  ContentView.swift
//  eMenu
//
//  Created by Minh Paul on 01/01/2024.
//

import SwiftUI
import Foundation


// ItemOrder
let item01 = ItemOrder(name: "#1", price: 4.99)
let item02 = ItemOrder(name: "#2", price: 4.98)
let item03 = ItemOrder(name: "#3", price: 4.97)
let item04 = ItemOrder(name: "Combo 1", price: 4.99)
let item05 = ItemOrder(name: "Combo 12", price: 4.98)
let item06 = ItemOrder(name: "Combo 13", price: 4.97)
let item07 = ItemOrder(name: "Dinner 1", price: 4.99)
let item08 = ItemOrder(name: "Dinner 2", price: 4.98)
let item09 = ItemOrder(name: "Dinner 3", price: 4.97)


let cat1 = CategoryMenu(name: "Dish", items: [item01, item02, item03])
let cat2 = CategoryMenu(name: "Combo", items: [item04, item05, item06])
let cat3 = CategoryMenu(name: "Dinner", items: [item07, item08, item09])

let categories = [cat1, cat2, cat3]

//Random items
let item21 = ItemOrder(name: "Nui xao Bo", quantity: 2, price: 3.0, noteAdd: "No chili", noteRemove: "No onions", additionalFee: 0.5)
let item22 = ItemOrder(name: "Suon xao chua ngot", quantity: 1, price: 4.0, noteAdd: "", noteRemove: "", additionalFee: 0.0)
let item23 = ItemOrder(name: "Pho bo", quantity: 1, price: 5.0, noteAdd: "Extra noodles", noteRemove: "", additionalFee: 1.0)
let item24 = ItemOrder(name: "Com ga", quantity: 3, price: 6.0, noteAdd: "", noteRemove: "", additionalFee: 0.0)


// Order
//var order1 = Order(customerName: "Alice", items: [item21, item22], Addingitems: [], total: 10.5, time: Date(), dineIn: "TakeOut", pay: false, sendOrder: false)
//var order2 = Order(customerName: "Bob", items: [item23, item24], Addingitems: [], total: 23.0, time: Date(), dineIn: "Table 3", pay: true, sendOrder: true)
//
//// List of orders
//var listOrders: [Order] = [order1, order2]

let tables = ["TakeOut", "Table 1", "Table 2", "Table 3", "Table 4", "Table 5", "Table 6", "Table 7", "Table 8", "Table 9", "Table 10", "Table 11", "Table 12", "Table 13"]



///////////////////////////////////////////////////////////////////////////////////////////////////




struct ContentView: View {
    //    @Environment(\.modelContext) private var context
    @EnvironmentObject var orderStore: OrderStore
    @State private var isNewOrderView = false
    @State var selectedOrder: Order = Order()
    
    // Main body
    var body: some View {
        
        
        NavigationView{
            VStack{
                Text("SaiGon's Garden").font(.title)
                GeometryReader { geometry in
                    HStack{
                        VStack{
                            // Search bar
                            SearchBar(text: $searchText)
                            List{
                                ForEach(orderStore.listOrders){ item in
                                    Button(action:{
                                        selectedOrder = item
                                    })
                                    {
                                        VStack(alignment: .leading) {
                                            Text(item.orderNumber)
                                                .font(.headline)
                                            HStack{
                                                Text(item.dineIn)
                                                    .font(.subheadline)
                                                Text(DateFormatter.localizedString(from: item.time, dateStyle: .none, timeStyle: .short))
                                                    .font(.subheadline)
                                                    .foregroundColor(.gray)
                                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                            }
                                        }
                                    }
                                }
                                .onDelete { indexes in
                                    for index in indexes{
                                        // context.delete(orders[index])
                                        orderStore.listOrders.remove(at: index)
                                    }
                                }
                            }
                            .listStyle(PlainListStyle())
                            NavigationLink(destination: NewOrderView()) {
                                Text("New Order")
                            }
                            
                        }
                        .frame(width: geometry.size.width * 0.3)
                        VStack{
                            ListOrderDetailView(order: $selectedOrder)
                        }.frame(width: geometry.size.width * 0.7)
                        
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    
    
    @State var searchText = ""
    @State var selection = 0
    
    // Search bar filter
//    private var filteredOrders: [Order] {
//        if searchText.isEmpty {
//            return orderStore.listOrders
//        } else {
//            return orderStore.listOrders.filter { $0.orderNumber.lowercased().contains(searchText.lowercased()) || $0.customerName.lowercased().contains(searchText.lowercased())}
//        }
//    }
}



//struct MyWrapperView: View {
//    @State var listOrders:[Order] = []
//    var body: some View {
//        ContentView(listOrders: $listOrders)
//    }
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(OrderStore())
    }
}

//#Preview {
//    ContentView()
//}
