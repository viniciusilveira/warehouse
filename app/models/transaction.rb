class Transaction < ApplicationRecord
  validates :material_id, :user_id, :ammount, :operation, presence: true

  validate :operation, :validate_transaction_hour
  validates :ammount, numericality: { greater_than: 0 }

  belongs_to :material
  belongs_to :user

  accepts_nested_attributes_for :material

  def material_attributes=(attributes)
    if attributes['id'].present?
      self.material = Material.find(attributes['id'])
    end
    super
  end

  def validate_transaction_hour
    time = Time.now
    week_day = time.wday
    hour = Time.now.strftime("%H").to_i
    day_valid = week_day >= 1 && week_day <=5
    hour_valid = hour >= 9 && hour <= 18
    unless day_valid && hour_valid
      errors.add(:out_business_hour, 'Fora do horário de funcionamento')
    end
  end
end
