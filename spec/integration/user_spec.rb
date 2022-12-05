require 'rails_helper'

RSpec.describe UsersController, type: :request do
  describe 'GET #index' do
    before(:example) do
      # create user with factorie
      @user = FactoryBot.create(:user)

      # get token JWT
      @token = JsonWebToken.encode(sub: @user.id)
      # set header
      @headers = { 'Authorization' => "Bearer #{@token}" }
      # get index
      get '/users', headers: @headers
    end

    # user authentacated successfully
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'return the numer of users 10' do
      expect(JSON.parse(response.body).size).to eq(1)
    end

    it 'return user as admin' do
      expect(JSON.parse(response.body).first['admin']).to eq(true)
    end

    it 'delete user with id 1' do
      delete "/users/#{@user.id}", headers: @headers
      expect(response).to have_http_status(:success)
    end

    it 'register user ' do
      post '/register',
           params: { user: { name: 'test', email: 'test12@gmail.com', password: '123qedwd',
                             date_of_birth: '1990-01-02' } }
      expect(response).to have_http_status(:success)
    end

    it 'return after adding a user ' do
      post '/register',
           params: { user: { name: 'test', email: 'tut12@gmail.com', password: '123qedwd',
                             date_of_birth: '1990-01-02' } }
      expect(JSON.parse(response.body)['name']).to eq('test')
    end

    it 'updaet user informaytion' do
      patch "/users/#{@user.id}",
            params: { user: { name: 'jack', email: 'tt1w2@gmail.com', password: '123fedwd',
                              date_of_birth: '1920-01-02' } },
            headers: @headers
      expect(response).to have_http_status(:success)
    end

    it 'return after update user ' do
      put "/users/#{@user.id}",
          params: { user: { name: 'jack', email: 'tet1wff2@gmail.com', password: '12ffeedwd',
                            date_of_birth: '1920-01-02' } },
          headers: @headers
      expect(JSON.parse(response.body)['name']).to eq('jack')
    end
  end
end
