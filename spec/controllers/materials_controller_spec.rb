require 'rails_helper'

RSpec.describe MaterialsController, type: :controller do

  let(:valid_attributes) {
    attributes_for(:material)     
  }

  let(:invalid_attributes) {
    attributes_for(:material, name: nil) 
  }

  let(:user){
    create(:user)
  }

  before { sign_in user }

  describe "GET #index" do
    it "assigns all materials as @materials" do
      material = Material.create! valid_attributes
      get :index, params: {}
      expect(assigns(:materials)).to eq([material])
    end
  end

  describe "GET #show" do
    it "assigns the requested material as @material" do
      material = Material.create! valid_attributes
      get :show, params: {id: material.to_param}
      expect(assigns(:material)).to eq(material)
    end
  end

  describe "GET #new" do
    it "assigns a new material as @material" do
      get :new, params: {}
      expect(assigns(:material)).to be_a_new(Material)
    end
  end

  describe "GET #edit" do
    it "assigns the requested material as @material" do
      material = Material.create! valid_attributes
      get :edit, params: {id: material.to_param}
      expect(assigns(:material)).to eq(material)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Material" do
        expect {
          post :create, params: {material: valid_attributes}
        }.to change(Material, :count).by(1)
      end

      it "assigns a newly created material as @material" do
        post :create, params: {material: valid_attributes}
        expect(assigns(:material)).to be_a(Material)
        expect(assigns(:material)).to be_persisted
      end

      it "redirects to the created material" do
        post :create, params: {material: valid_attributes}
        expect(response).to redirect_to(materials_path)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved material as @material" do
        post :create, params: {material: invalid_attributes}
        expect(assigns(:material)).to be_a_new(Material)
      end

      it "re-renders the 'new' template" do
        post :create, params: {material: invalid_attributes}
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        attributes_for(:material, name: 'Material Resistente', ammount: 150)
      }

      it "updates the requested material" do
        material = Material.create! valid_attributes
        put :update, params: {id: material.to_param, material: new_attributes}
        material.reload
        expect(assigns(:material)).to eq(material)
      end

      it "assigns the requested material as @material" do
        material = Material.create! valid_attributes
        put :update, params: {id: material.to_param, material: valid_attributes}
        expect(assigns(:material)).to eq(material)
      end

      it "redirects to the material" do
        material = Material.create! valid_attributes
        put :update, params: {id: material.to_param, material: valid_attributes}
        expect(response).to redirect_to(materials_path)
      end
    end

    context "with invalid params" do
      it "assigns the material as @material" do
        material = Material.create! valid_attributes
        put :update, params: {id: material.to_param, material: invalid_attributes}
        expect(assigns(:material)).to eq(material)
      end

      it "re-renders the 'edit' template" do
        material = Material.create! valid_attributes
        put :update, params: {id: material.to_param, material: invalid_attributes}
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested material" do
      material = Material.create! valid_attributes
      expect {
        delete :destroy, params: {id: material.to_param}
      }.to change(Material, :count).by(-1)
    end

    it "redirects to the materials list" do
      material = Material.create! valid_attributes
      delete :destroy, params: {id: material.to_param}
      expect(response).to redirect_to(materials_url)
    end
  end

end
