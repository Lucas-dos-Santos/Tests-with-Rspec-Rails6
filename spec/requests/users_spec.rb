require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /users' do
    it 'returns success status' do
      get users_path
      expect(response).to have_http_status(200)
    end

    it "the user's title is present" do
      users = create_list(:user, 3)
      get users_path
      users.each do |user|
        expect(response.body).to include(user.title)
      end
    end
  end

  describe 'POST /users' do
    context 'when it has valid parameters' do
      it 'creates the
      user with correct attributes' do
        attributes = FactoryBot.attributes_for(:user)
        post users_path, params: { user: attributes }
        expect(User.last).to have_attributes(attributes)
      end
    end

    context 'when it has no valid parameters' do
      it 'does not create user' do
        attributes = FactoryBot.attributes_for(:user, level: 125)
        expect do
          post(users_path, params: { user: attributes })
        end.to_not change(User, :count)
      end
    end
  end
end
