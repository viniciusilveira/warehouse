class Material < ApplicationRecord
  validates :name, :ammount, presence: true
  validates :name, uniqueness: true
  validates :ammount, numericality: { greater_than: 0 }

  has_many :transactions, dependent: :restrict_with_error
  

  def add(ammount)
    self.ammount += ammount
    self.save
  end

  def remove(ammount)
    self.ammount -= ammount
    self.save
  end

end
