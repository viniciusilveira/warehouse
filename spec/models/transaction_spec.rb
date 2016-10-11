require 'rails_helper'

RSpec.describe Transaction, type: :model do
  
  describe 'validates' do

    let(:monday) {
      Time.local(2016, 10, 10, 12, 0)
    }

    let(:transaction){
      build(:transaction)
    }

    it 'be valid' do
      Timecop.freeze(monday)
      expect(transaction.valid?).to be_truthy
    end

    it 'be a material is null' do
      transaction.material_id = nil
      Timecop.freeze(monday)
      expect(transaction.valid?).to be_falsey
    end

    it 'be a ammount is less a 0' do
      transaction.ammount = -3
      Timecop.freeze(monday)
      expect(transaction.valid?).to be_falsey
    end

    it 'be a out business hour' do
      saturday_night = Time.local(2016, 8, 10, 22, 30)
      Timecop.freeze(saturday_night)
      transaction = build(:transaction)
      expect(transaction.valid?).to be_falsey
    end
  end
end
