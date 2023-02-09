require 'rails_helper'

RSpec.describe Api::V1::ReservationsController, type: :controller do
  describe "POST #create" do
    subject { post :create }

    context "when success request sent" do
      let(:params) do
        {
          "reservation_code": "YYY12345670",
          "start_date": "2021-04-14",
          "end_date": "2021-04-18",
          "nights": 4,
          "guests": 4,
          "adults": 2,
          "children": 2,
          "infants": 0,
          "status": "accepted",
          "guest": {
            "first_name": "Wayne",
            "last_name": "Woodbridge",
            "phone": "639123456789",
            "email": "wayne_woodbridge@bnb.com"
          },
          "currency": "AUD",
          "payout_price": "4200.00",
          "security_price": "500",
          "total_price": "4700.00"
        }
      end

      subject { post :create, params: params, as: :json }
      it "should have 201 status code" do
        subject
        expect(response).to have_http_status(:created)
      end

      it "should create the reservation" do
        expect{ subject }.to change{ Reservation.count }.by(1)
      end
    end

    context 'when invalid parameters provided - duplicate code' do
      let(:guest) { create :guest }
      let(:reservation) { create :reservation, guest: guest }

      let(:invalid_params) do
        {
          "reservation_code": reservation.code,
          "start_date": "2021-04-14",
          "end_date": "2021-04-18",
          "nights": 4,
          "guests": 4,
          "adults": 2,
          "children": 2,
          "infants": 0,
          "status": "accepted",
          "guest": {
            "first_name": "Wayne",
            "last_name": "Woodbridge",
            "phone": "639123456789",
            "email": "wayne_woodbridge@bnb.com"
          },
          "currency": "AUD",
          "payout_price": "4200.00",
          "security_price": "500",
          "total_price": "4700.00"
        }
      end

      subject { post :create, params: invalid_params, as: :json }
      it 'should return 422 status code' do
        subject
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'should return proper error json' do
        subject
        expect(json['errors']).to include(
          {
            "source" => { "pointer" => "/data/attributes/code" },
            "detail" =>  "has already been taken"
          }
        )
      end
    end
  end

  describe "PATCH #update" do
    let(:guest) { create :guest }
    let(:reservation) { create :reservation, guest: guest }
    subject { patch :update }

    context "when success request sent" do
      let(:params) do
        {
          "reservation_code": reservation.code,
          "start_date": "2021-04-14",
          "end_date": "2021-04-18",
          "nights": 4,
          "guests": 4,
          "adults": 2,
          "children": 2,
          "infants": 0,
          "status": "accepted",
          "guest": {
            "first_name": "Wayne",
            "last_name": "Woodbridge",
            "phone": "639123456789",
            "email": "wayne_woodbridge@bnb.com"
          },
          "currency": "AUD",
          "payout_price": "4200.00",
          "security_price": "500",
          "total_price": "4700.00"
        }
      end

      subject { patch :update, params: params, as: :json }

      it 'should have 201 status code' do
        subject
        expect(response).to have_http_status(:ok)
      end
    end

    context "when request fails - record does not exist" do
      let(:invalid_params) do
        {
          "reservation_code": "YYY12345670",
          "start_date": "2021-04-14",
          "end_date": "2021-04-18",
          "nights": 4,
          "guests": 4,
          "adults": 2,
          "children": 2,
          "infants": 0,
          "status": "accepted",
          "guest": {
            "first_name": "Wayne",
            "last_name": "Woodbridge",
            "phone": "639123456789",
            "email": "wayne_woodbridge@bnb.com"
          },
          "currency": "AUD",
          "payout_price": "4200.00",
          "security_price": "500",
          "total_price": "4700.00"
        }
      end

      subject { patch :update, params: invalid_params, as: :json }
      it 'should return 404 status code' do
        subject
        expect(response).to have_http_status(:not_found)
      end

      it 'should return proper error json' do
        subject
        expect(json['errors']).to include(
          {
            "detail" => "You must provide valid code in order to update Reservation.",
            "source" => { "pointer" => "/data/attributes/code" },
            "status" => "404",
            "title" => "Invalid Reservation code"
          }
        )
      end
    end
  end
end
