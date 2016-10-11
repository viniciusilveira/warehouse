feature 'Transactions' do
  describe 'manage stock' do 

    let(:monday){
      Time.local(2016, 10, 10, 12, 0)
    }

    before do
      user = create(:user)
      login_as(user, scope: :user)
      Material.create(attributes_for(:material))
      Timecop.freeze(monday)
    end

    it 'add new items in material' do
      visit materials_path
      click_link 'Movimentar'
      
      fill_in 'Quantidade', with: 10
      page.choose('transaction_operation_add')
      click_button 'Criar Transaction'
      expect(page).to have_content('Material atualizado com sucesso.')
    end

    it 'remove items in material' do
      visit materials_path
      click_link 'Movimentar'

      fill_in 'Quantidade', with: 3
      page.choose('transaction_operation_remove')
      click_button 'Criar Transaction'
      expect(page).to have_content('Material atualizado com sucesso.')
    end

    it 'removes more material that exists' do
      visit materials_path
      click_link 'Movimentar'

      fill_in 'Quantidade', with: 300
      page.choose('transaction_operation_remove')
      click_button 'Criar Transaction'
      expect(page).to have_content('Quantidade deve ser maior que 0')
    end

    it 'manage out business hour' do
      saturday_night = Time.local(2016, 10, 8, 22, 30)
      Timecop.freeze(saturday_night)
      
      visit materials_path
      click_link 'Movimentar'

      fill_in 'Quantidade', with: 10
      page.choose('transaction_operation_add')
      click_button 'Criar Transaction'
      expect(page).to have_content('Fora do horário de funcionamento')
    end
  end
end
    
    
