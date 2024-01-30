# location: spec/feature/integration_spec.rb
require 'rails_helper'

RSpec.feature "Book management", type: :feature do

  scenario "add a new book" do
    visit new_book_path
    fill_in 'book_title', with: 'Test Book'
    fill_in 'book_position', with: '1'
    fill_in 'book_author', with: 'Test Author'
    fill_in 'book_price', with: '1.00'
    click_on 'Create Book'
    expect(page).to have_current_path books_path
    expect(page).to have_content 'Test Book'
    expect(page).to have_content "Book was successfully created."
    expect(Book.last.title).to eq 'Test Book'
  end

  scenario "delete a book" do
    book = Book.create!(title: 'Test Book', position: 1, author: 'Test Author', price: 1.00, published_date: '2020-01-01')
    visit delete_book_path(book)
    click_on 'Delete Book'
    expect(page).to have_current_path books_path
    expect(page).not_to have_content 'Test Book'
    expect(page).to have_content "Book was successfully deleted."
    expect(Book.find_by(id: book.id)).to be_nil
  end

  scenario "edit a book" do
    book = Book.create!(title: 'Test Book', position: 1, author: 'Test Author', price: 1.00, published_date: '2020-01-01')
    visit edit_book_path(book)
    fill_in 'book_title', with: 'Updated Book'
    fill_in 'book_author', with: 'Updated Author'
    click_on 'Edit Book'
    expect(page).to have_current_path book_path(book)
    expect(page).to have_content 'Updated Book'
    expect(page).to have_content 'Updated Author'
    expect(Book.find_by(id: book.id).title).to eq 'Updated Book'
  end

  scenario "attempt to add a book with a blank title" do
    visit new_book_path
    fill_in 'book_title', with: ''
    click_on 'Create Book'
    expect(page).to have_content "Title can't be blank"
  end

  scenario "attempt to add a book with a blank position" do
    visit new_book_path
    fill_in 'book_position', with: ''
    click_on 'Create Book'
    expect(page).to have_content "Position can't be blank"
  end

  scenario "attempt to add a book with a blank author" do
    visit new_book_path
    fill_in 'book_author', with: ''
    click_on 'Create Book'
    expect(page).to have_content "Author can't be blank"
  end

  scenario "attempt to add a book with a blank price" do
    visit new_book_path
    fill_in 'book_price', with: ''
    click_on 'Create Book'
    expect(page).to have_content "Price can't be blank"
  end

end