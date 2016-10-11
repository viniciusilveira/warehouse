class Movimentation
  extend EnumerateIt
  has_enumeration_for :movimentation_operation, with: MovimentationOperation, create_helpers: true

  def initialize(material_id, ammount)
    @material = Material.find(material_id)
    @ammount = ammount
  end
  
  def movement(operation) 
    @material.add(@ammount) if operation == MovimentationOperation::ADD
    @material.remove(@ammount) if operation == MovimentationOperation::REMOVE
    @material.save
    @material
  end
end
