 

import SwiftUI
import SVGKit

struct RouteCarrierView: View {
    // MARK: - Properties
   
    
    @ObservedObject var viewModel: RouteCarrierViewModel
    @Binding var carrierIcon: Image
   

    // MARK: - Body
    var body: some View {
        HStack(spacing: AppSizes.Spacing.small) {
            iconView
            VStack(alignment: .leading) {
                carrierTitleView
                if !viewModel.route.isDirect {
                    connectionInfoView
                }
            }
            Spacer()
            departureDateView
        }
        .padding(.top, AppSizes.Spacing.medium)
        .padding(.horizontal, AppSizes.Spacing.medium)
    }
}

// MARK: - Private Views
private extension RouteCarrierView {
    var iconView: some View {
        carrierIcon
            .frame(width: AppSizes.Size.logo, height: AppSizes.Size.logo)
    }

    var carrierTitleView: some View {
        Text(viewModel.carrier.title)
            .font(AppFonts.Regular.medium)
            .foregroundStyle(AppColors.Universal.black)
    }

    var connectionInfoView: some View {
        Text(viewModel.connectionInValue)
            .font(AppFonts.Regular.small)
            .foregroundStyle(AppColors.Universal.red)
    }

    var departureDateView: some View {
        Text(viewModel.route.date.getLocalizedShortDate)
            .font(AppFonts.Regular.small)
            .foregroundStyle(AppColors.Universal.black)
    }

    var placeholderImageView: some View {
        Image(systemName: viewModel.carrier.placeholder)
            .renderingMode(.template)
            .resizable()
            .scaledToFit()
            .frame(width: AppSizes.Size.logo / 1.5, height: AppSizes.Size.logo / 1.5)
            .foregroundStyle(AppColors.LightDark.black)
    }
}

#Preview {
    RouteCarrierView(viewModel:RouteCarrierViewModel( route: Mocks.Routes.all[0], carrier: Mocks.Carriers.rzhd), carrierIcon: .constant(Image(systemName: "cablecar"))
    )
        .background(AppColors.Universal.lightGray)
}


       
