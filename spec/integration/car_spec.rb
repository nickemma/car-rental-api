require 'rails_helper'

RSpec.describe CarsController, type: :request do
  describe 'GET #index' do
    before(:example) do
      # create user with factorie
      @user = FactoryBot.create(:user)
      # get token JWT
      @token = JsonWebToken.encode(sub: @user.id)
      # set header
      @cars = FactoryBot.create_list(:car, 10)
      @car = @cars.first
      @headers = { 'Authorization' => "Bearer #{@token}" }
      # get index
      get '/cars', headers: @headers
    end

    it 'return the numer of cars 10' do
      expect(JSON.parse(response.body).size).to eq(10)
    end

    it 'return status code 200' do
      expect(response).to have_http_status(200)
    end

    it 'delete car with id 1' do
      delete "/cars/#{@car.id}", headers: @headers
      expect(response).to have_http_status(:success)
    end

    it 'create car' do
      post '/cars',
           params: { car: { name: 'Fiat', brand: 'Uno', description: 'the most fast car in the market',
                            daily_rate: '2324', car_type: 'rangrover' } },
           headers: @headers
      expect(response).to have_http_status(:success)
    end

    it 'return the name of the car created ' do
      post '/cars',
           params: { car: { name: 'Fiat', brand: 'Uno', description: 'the most fast car in the market',
                            daily_rate: '2324', car_type: 'rangrover' } },
           headers: @headers
      expect(JSON.parse(response.body)['name']).to eq('Fiat')
    end

    it 'update car information' do
      patch "/cars/#{@car.id}",
            params: { car: { name: 'toyota', brand: 'GM', description: 'the most fast car in the market',
                             daily_rate: '2324', car_type: 'rangrover' } },
            headers: @headers
      expect(response).to have_http_status(:success)
    end

    it 'after update car ' do
      put "/cars/#{@car.id}",
          params: { car: { name: 'toyota', brand: 'GM', description: 'the most fast car in the market',
                           daily_rate: '2324', car_type: 'rangrover' } },
          headers: @headers
      expect(JSON.parse(response.body)['name']).to eq('toyota')
    end
  end
end
