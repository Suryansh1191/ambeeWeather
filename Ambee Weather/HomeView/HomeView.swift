//
//  HomeView.swift
//  Ambee Weather
//
//  Created by suryansh Bisen on 15/10/22.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewController = HomeViewControler()
    @State var index = 0
    
    var body: some View {
        VStack{
            Text("\(viewController.weatherData.city?.name ?? "NoData")")
                .padding()
                .foregroundColor(.gray)
            Spacer()
            VStack{
                Text("\((viewController.weatherData.list?[index].weather?[0].main ?? MainEnum.clear).rawValue)")
                    .textCase(.uppercase)
                    .font(.system(size: 35, weight: .heavy, design: .default))
                    .tracking(3)
                    .padding(.bottom, 10)
                Text("\(viewController.weatherData.list?[index].weather?[0].weatherDescription ?? "")")
                    .textCase(.uppercase)
                    .font(.system(size: 20, weight: .medium, design: .default))
                    .tracking(7)
                    .foregroundColor(.gray)
            }
            
            VStack(spacing: 0){
                
                if (viewController.weatherData.list?[index].weather?[0].main == MainEnum.clear) {
                    Image(systemName: "cloud.sun.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 80)
                        .padding(.top, 40)
                }else if (viewController.weatherData.list?[index].weather?[0].main == MainEnum.clouds) {
                    Image(systemName: "smoke.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 80)
                        .padding(.top, 40)
                }else {
                    Image(systemName: "cloud.drizzle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 80)
                        .padding(.top, 40)
                }
                

                
                Text("\((viewController.weatherData.list?[index].main?.temp ?? 0.0).toNoDesimal(tillPoint: 0))°")
                    .font(.system(size: 125, weight: .light, design: .default))
                    .tracking(3)
                    .padding(.top, 10)
                
                HStack{
                    VStack{
                        Text("max")
                            .foregroundColor(.gray)
                            .padding(.bottom, 8)
                        Text("\((viewController.weatherData.list?[index].main?.tempMax ?? 0).toNoDesimal(tillPoint: 0))°")
                    }.padding()
                    Divider()
                        .frame(maxHeight: 40)
                    VStack{
                        Text("min")
                            .foregroundColor(.gray)
                            .padding(.bottom, 8)
                        Text("\((viewController.weatherData.list?[index].main?.tempMin ?? 0).toNoDesimal(tillPoint: 0))°")
                    }.padding()
                }
            }
            
            Spacer()
            
            Divider()
                .padding()
            
            
            
            HStack{
                Group{
                    Spacer()
                    VStack{
                        Text("Wind Speed")
                            .foregroundColor(.gray)
                            .padding(.bottom, 8)
                        Text("\((viewController.weatherData.list?[index].wind?.speed ?? 0.0).toNoDesimal(tillPoint: 2)) m/s")
                    }
                    Spacer()
                    Divider()
                        .frame(maxHeight: 40)
                    Spacer()
                    VStack{
                        Text("Sea Level")
                            .foregroundColor(.gray)
                            .padding(.bottom, 8)
                        Text("\(viewController.weatherData.list?[index].main?.seaLevel ?? 0)")
                    }
                    Spacer()
                    Divider()
                        .frame(maxHeight: 40)
                    Spacer()
                }
                VStack{
                    Text("Pressure")
                        .foregroundColor(.gray)
                        .padding(.bottom, 8)
                    Text("\(viewController.weatherData.list?[index].main?.pressure ?? 0)")
                }
                Spacer()
                Divider()
                    .frame(maxHeight: 40)
                Spacer()
                VStack{
                    Text("humidity")
                        .foregroundColor(.gray)
                        .padding(.bottom, 8)
                    Text("\((viewController.weatherData.list?[index].main?.humidity ?? 0))")
                    
                }
                Spacer()
            }
            
            Divider()
                .padding()
            
            Group{
                
                ScrollView(.horizontal) {
                    HStack{
                        ForEach((0..<(viewController.weatherData.list?.count ?? 0)), id: \.self) { index in
                            VStack{
                                Text("\((viewController.weatherData.list?[index].dtTxt ?? "").dateFormate())")
                                    .foregroundColor(.gray)
                                if (viewController.weatherData.list?[index].weather?[0].main == MainEnum.clear) {
                                    Image(systemName: "cloud.sun.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(maxHeight: 20)
                                }else if (viewController.weatherData.list?[index].weather?[0].main == MainEnum.clouds) {
                                    Image(systemName: "smoke.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(maxHeight: 20)
                                }else {
                                    Image(systemName: "cloud.drizzle.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(maxHeight: 20)
                                }
                                
                                Text("\((viewController.weatherData.list?[index].main?.temp ?? 0.0).toNoDesimal(tillPoint: 0))°")
                            
                                Text("\((viewController.weatherData.list?[index].dtTxt ?? "").getTime())")
                                    .foregroundColor(.gray)
                        
                            }
                                .padding([.leading, .trailing])
                                .background(index == self.index ?  Color(.gray).opacity(0.2) : Color(.white).opacity(0))
                                .cornerRadius(5)
                                .onTapGesture {
                                    self.index = index
                                }
                                
                        }
                    }.padding(.leading)
                }
                
                Spacer()
            }
        }.onAppear{
            viewController.getData()
        }

        .overlay{
            if viewController.status == Status.isLoading {
                VStack{
                    ProgressView()
                        .fontWeight(.bold)
                        .font(.title)
                        .foregroundColor(.black)
                }
                .frame(
                      minWidth: 0,
                      maxWidth: .infinity,
                      minHeight: 0,
                      maxHeight: .infinity,
                      alignment: .center
                    )
                .background(Color.white)
            }
            else if viewController.status == Status.noPermition {
                VStack{
                    Text("Location Access Denied")
                        .font(.title)
                        .foregroundColor(.black)

                    Button {
                        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
                    } label: {
                        Text("Click Here to give access and reopen the app")
                    }

                    
                }
                .frame(
                      minWidth: 0,
                      maxWidth: .infinity,
                      minHeight: 0,
                      maxHeight: .infinity,
                      alignment: .center
                    )
                .background(Color.white)
            }
            else if viewController.status == Status.ApiError {
                VStack{
                    Text("Opps... API Error")
                        .font(.title)
                    Text("Please Provide Your Location Access")
                }
                .frame(
                      minWidth: 0,
                      maxWidth: .infinity,
                      minHeight: 0,
                      maxHeight: .infinity,
                      alignment: .center
                    )
                .background(Color.white)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
