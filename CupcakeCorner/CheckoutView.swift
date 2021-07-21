//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Bruce Gilmour on 2021-07-21.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order

    var body: some View {
        Text("CheckoutView")
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
