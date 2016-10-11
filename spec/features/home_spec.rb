feature 'Home' do
  describe 'user access home page' do
    it 'logged' do
      user = create(:user)
      login_as(user, scope: :user)
      visit root_path
      expect(page).to have_content 'New Material'
    end

    it 'not logged' do
      visit root_path
      expect(page).to have_content 'HOME PAGE'
    end
  end
end
