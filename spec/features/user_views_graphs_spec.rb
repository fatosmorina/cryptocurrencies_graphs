require "rails_helper"

feature "User views graph links" do 
  scenario "successfully" do
    visit root_path
    expect(page).to have_link("Bitcoin")
    expect(page).to have_link("Ethereum")
    expect(page).to have_link("Nasdaq")
  end  
end  

feature "User views Wikipedia links of" do 
  scenario "Bitcoin" do
   expect_page_to_have_link("Bitcoin")
  end

  scenario "Ethereum" do
  	expect_page_to_have_link("Ethereum")
  end
  
  scenario "Nasdaq" do
  	expect_page_to_have_link("Nasdaq")
  end  
end  

private

def expect_page_to_have_link(currency)
	visit graph_path("#{currency}")
  	expect(page).to have_link("#{currency}", :href => "https://en.wikipedia.org/wiki/#{currency}") 
end