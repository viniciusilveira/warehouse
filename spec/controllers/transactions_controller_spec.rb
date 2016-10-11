require 'rails_helper'

RSpec.describe TransactionsController, type: :controller do

  let(:user){
    create(:user)
  }

  let(:material){
    create(:material)
  }

  let(:valid_attributes) {
    attributes_for(:transaction, material_attributes: {id: material.id})
  }

  let(:invalid_attributes) {
    attributes_for(:transaction, ammount: nil, material_attributes: {id: material.id})
  }

  let(:monday){
    Time.local(2016, 10, 10, 12, 0)
  }

  before { sign_in user }

  describe "GET #:index" do

    it "assigns all transactions for one any material" do
      Timecop.freeze(monday)
      transaction = Transaction.create!(operation: valid_attributes[:operation], user_id: user.id, ammount: valid_attributes[:ammount], material_id: material.id)
      get :index, params: { material_id: transaction.material_id }
      expect(assigns(:transactions)).to eq([transaction])
    end
  end

  describe "GET #new" do
    it "assigns a new transaction as @transaction" do
      get :new, params: {material_id: material.id}
      expect(assigns(:transaction)).to be_a_new(Transaction)
    end
  end

  describe "POST #create" do
    context "with valid params" do

      before do
        Timecop.freeze(monday)
      end

      it "creates a new Transaction" do
        expect {
          post :create, params: {transaction: valid_attributes}
        }.to change(Transaction, :count).by(1)
      end

      it "assigns a newly created transaction as @transaction" do
        post :create, params: {transaction: valid_attributes}
        expect(assigns(:transaction)).to be_a(Transaction)
        expect(assigns(:transaction)).to be_persisted
      end

      it "redirects to the created transaction" do
        post :create, params: {transaction: valid_attributes}
        expect(response).to redirect_to(Transaction.last.material)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved transaction as @transaction" do
        post :create, params: {transaction: invalid_attributes}
        expect(assigns(:transaction)).to be_a_new(Transaction)
      end

      it "re-renders the 'new' template" do
        post :create, params: {transaction: invalid_attributes}
        expect(response).to render_template("new")
      end
    end
  end

end
