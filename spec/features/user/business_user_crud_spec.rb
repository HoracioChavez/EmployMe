require 'feature_helper'

describe 'business user can CRUD a new listing' do

  before(:each) do
    listing     = default_job_listing
    @listing    = listing

    @category1  = Category.create( title:("Things"), description:("Do some stuff"))
    @category1.listings << listing
  end

  it 'I can create a new listing' do
    user_register_a
    add_listing
    expect(page).to have_content("barista")
  end

  it "A user can edit its own listings" do
    user_register_a
    add_listing
    expect(page).to have_content("barista")
    page.visit listings_path
    page.click_link "Edit"
    page.fill_in "Title", with: "real barista"
    page.click_button "Submit"
    expect(page).to have_content("real barista")
  end

  it 'can edit a listing' do
    user_register_a
    add_listing
    visit listings_path
    page.visit listings_path
    expect(page).to have_link("Edit")

    click_link("Edit")
  end

  it 'can delete a listing' do
    user_register_a
    add_listing
    page.visit listing_path(@listing)
    expect(page).to have_content(@listing.title)
    visit listings_path
    page.click_on "Remove listing"
    page.visit listings_path
    expect(page).not_to have_content(@listing.title)
  end

  it 'cannot see the apply for job button when vieiwing a job' do
    visit signin_path
      within('//form') do
        fill_in("session_email",    with: @business.email)
        fill_in("session_password", with: @business.password)
        click_button("Sign In")
      end
    visit listing_path(Listing.last)
    expect(page).to_not have_content('Apply')
  end

  it 'cannot see Apply for Job from the listings page' do
    visit signin_path
      within('//form') do
        fill_in("session_email",    with: @business.email)
        fill_in("session_password", with: @business.password)
        click_button("Sign In")
      end
    visit listings_path
    expect(page).to_not have_content("Add this Job")
  end
end
