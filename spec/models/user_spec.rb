require 'rails_helper'

RSpec.describe User, type: :model do
  let(:add_user) { build(:user, name: 'Test') }
  let(:valid_user) { build(:user, name: 'test-user_name123') }
  let(:invalid_user) { build(:user, name: 'test@')}
  describe 'create' do
    before do
      create(:user, name: 'test')
    end
    it 'should unique name' do
      expect(add_user.valid?).to eq false
    end

    it 'should have alphabet, number, hyphen or underscore only' do
      expect(valid_user.valid?).to eq true
      expect(invalid_user.valid?).to eq false
    end
  end
end
