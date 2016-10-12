class Movimentation
  extend EnumerateIt
  has_enumeration_for :movimentation_operation, with: MovimentationOperation, create_helpers: true

  def initialize(transaction)
    @transaction = transaction
  end
  
  def movement
    if @transaction.valid?
      @material = @transaction.material
      @material.add(@transaction.ammount) if @transaction.operation == MovimentationOperation::ADD
      @material.remove(@transaction.ammount) if @transaction.operation == MovimentationOperation::REMOVE
      @transaction.save if @material.valid?
      @material.save
      return @material
    end

  end
end
