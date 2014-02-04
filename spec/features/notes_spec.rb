require 'spec_helper'

feature 'Visitor checks notes page' do
  scenario 'anonymously' do
  	visit notes_home_path
    expect(page).to have_content('Introduction')
  end
end


feature 'Visitor on sandwich page' do
  scenario 'views form' do
    visit notes_sandwich_path
    expect(page).to have_content('Sandwich')
  end

  scenario 'orders a sandwich form' do
    visit notes_sandwich_path
    fill_in('Name', :with => 'John Smith')
    select('Doomsday', :from => 'Sandwich')
    select('Mustard', :from => 'Options')
    select('Salt', :from => 'Option')

    click_button('Place Order')
    expect(page).to have_content("\"sandwich\": \"Doomsday\"")
    expect(page).to have_content("\"mustard\"")
  end
end


feature 'Visitor to code sample page' do
  scenario 'syntax error sample' do
     visit code_sample_code_sample_syntax_error_demo_path
     expect(page).to have_content('Syntax Error')
  end

end