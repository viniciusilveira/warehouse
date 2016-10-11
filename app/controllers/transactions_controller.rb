class TransactionsController < ApplicationController
  has_enumeration_for :movimentation_operation, with: MovimentationOperation, create_helpers: true

  before_action :authenticate_user!

  def index
    @transactions = Transaction.where(material_id: params[:material_id])
  end

  def new 
    @transaction = Transaction.new(material_id: params[:material_id])
  end

  def create
    @transaction = Transaction.new(transaction_params)
    @transaction.material_id = transaction_params[:material_attributes][:id]
    @transaction.user = current_user
    movimentation = Movimentation.new(@transaction.material_id, @transaction.ammount) 
    @material = movimentation.movement(@transaction.operation)
    respond_to do |format|
      if @material.valid? && @transaction.save

        format.html { redirect_to @transaction.material, notice: t('successful.messages.updated') }
        format.json { render :show, status: :created, location: @transaction }
      else
        format.html { render :new }
        format.json { render json: @transaction.material.errors, status: :unprocessable_entity }
      end
    end

  end

  private
    def transaction_params
      params.require(:transaction).permit(:ammount, :operation, material_attributes: [:id])
    end
end
