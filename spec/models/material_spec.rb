require 'rails_helper'

RSpec.describe Material, type: :model do
  describe 'validates' do
    it 'be valid' do
      material = build(:material)
      expect(material.valid?).to be_truthy
    end
  end

  describe 'raise records invalid' do
    it 'when name is null' do
      material = build(:material, name: nil)
      expect(material.save).to be_falsey
      expect(material.errors.messages).to include(name: ['não pode ficar em branco'])
    end

    it 'when ammount is < 0' do
      material = build(:material, ammount: -2)
      expect(material.save).to be_falsey
      expect(material.errors.messages).to include(ammount: ['deve ser maior que 0'])
    end
  end
end
