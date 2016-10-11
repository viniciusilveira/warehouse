feature 'Materials' do
  describe 'manage materials' do
    before do
      user = create(:user)
      login_as(user, scope: :user)
    end

    it 'create new material' do
      visit new_material_path
      fill_in 'Nome', with: 'Caderno 200 folhas'
      fill_in 'Quantidade', with: 200
      click_button 'Criar Material'
      expect(page).to have_content 'Material criado com sucesso.' 
      expect(page).to have_content 'Name: Caderno 200 folhas'
      expect(page).to have_content 'Ammount: 200'
    end

    it 'update exists material' do
      create(:material)
      visit materials_path
      click_link 'Edit'
      fill_in 'Nome', with: 'Novo Material'
      click_button 'Atualizar Material'
      expect(page).to have_content 'Material atualizado com sucesso.'
      expect(page).to have_content 'Name: Novo Material'
    end

    it 'create material with ammount less than 0' do
      visit new_material_path
      fill_in 'Nome', with: 'Lapis de cor'
      fill_in 'Quantidade', with: -3
      click_button 'Criar Material'
      expect(page).to have_content 'Quantidade deve ser maior que 0'
    end

    it 'create material with name is null' do
      visit new_material_path
      fill_in 'Nome', with: ''
      fill_in 'Quantidade', with: 10
      click_button 'Criar Material'
      expect(page).to have_content 'Nome não pode ficar em branco'
    end

    it 'set name of an existing material for null' do
      create(:material)
      visit materials_path
      click_link 'Edit'
      fill_in 'Nome', with: ''
      click_button 'Atualizar Material'
      expect(page).to have_content 'Nome não pode ficar em branco'
    end
  end
end
