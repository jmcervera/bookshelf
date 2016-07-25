require 'features_helper'

RSpec.describe 'List Books' do

  before do
    BookRepository.clear
    BookRepository.create(Book.new(title: 'PoEAA', author: 'Martin Fowler'))
    BookRepository.create(Book.new(title: 'TDD', author: 'Kent Beck'))
  end
  it 'displays each book on the page' do
    visit '/books'

    within '#books' do
      expect(page).to have_css('.book', count: 2)
    end
  end
end

