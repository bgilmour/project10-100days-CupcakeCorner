//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Bruce Gilmour on 2021-07-21.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order

    @State private var showingAlert = false
    @State private var confirmationMessage = ""
    @State private var errorMessage = ""

    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    Image("cupcakes")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width)

                    Text("Your total is: $\(order.cost, specifier: "%.2f")")
                        .font(.title)

                    Button("Place Order") {
                        placeOrder()
                    }
                    .padding()
                }
            }
        }
        .navigationBarTitle("Check out", displayMode: .inline)
        .alert(isPresented: $showingAlert) {
            if !confirmationMessage.isEmpty {
                return Alert(title: Text("Thank you!"), message: Text(confirmationMessage), dismissButton: .default(Text("OK")))
            } else {
                return Alert(title: Text("Network error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
        }
    }

    func placeOrder() {
        guard let encoded = try? JSONEncoder().encode(order.details) else {
            print("Failed to encode order")
            return
        }

        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded

        print("Sending: \(String(data: encoded, encoding: .utf8)!)")

        URLSession.shared.dataTask(with: request) { data, response, error in
            confirmationMessage = ""
            errorMessage = ""
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error").")
                errorMessage = "\(error?.localizedDescription ?? "Unknown error")"
                showingAlert = true
                return
            }

            if let orderDetails = try? JSONDecoder().decode(OrderDetails.self, from: data) {
                print("Response body: \(String(data: data, encoding: .utf8)!)")
                confirmationMessage = "Your order for \(orderDetails.quantity)x \(Order.types[orderDetails.type].lowercased()) cupcakes is on its way!"
                showingAlert = true
            } else {
                print("Invalid response from server: \(String(data: data, encoding: .utf8)!)")
                errorMessage = "Invalid response from server"
                showingAlert = true
            }
        }
        .resume()
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
