require "rails_helper"

feature "User views homepage" do 
  scenario "successfully" do
    visit root_path
    expect(page).to have_headline_text 
  end 

  private
    def have_headline_text
      have_text ("Values of CryptoCurrencies")
    end
end
