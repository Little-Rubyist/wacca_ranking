require 'rails_helper'

RSpec.describe User, type: :model do
  let(:add_user) { build(:user, name: 'test') }
  it 'should unique name' do
    create(:user, name: 'test')
    expect(add_user.valid?).to eq false
  end
end
