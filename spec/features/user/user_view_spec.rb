require 'feature_helper'

describe 'the user view', type: :feature do

  describe 'the home view' do

    context 'business users' do

        it 'has link to register user' do
          visit home_path
          expect(page).to have_link('Register Your Business')
        end

        it 'displays the business registration page' do
          visit home_path
          click_link('Register Your Business')
          expect(current_path).to eq(new_user_path)
        end

        it 'can register a business' do
          visit home_path
          click_link('Register Your Business')
          expect(current_path).to eq(new_user_path)
          fill_in("Company name", with: "FedEx")
          fill_in("email", with: "user@example.com")
          fill_in("First Name", with: "Bob")
          fill_in("Last Name", with: "Gu")
          fill_in("Password", with: "password")
          fill_in("Confirmation", with: "password")
          click_button("Register Now")
          expect(current_path).to eq user_path(User.last)
        end

        it 'can log in as business' do
          user = User.new
            user.company_name          = "FedEx"
            user.first_name            = "Fred"
            user.last_name             = "Rex"
            user.email                 = "fredrex@fedex.com"
            user.password              = "password"
            user.password_confirmation = "password"
          user.save

          visit signin_path
          fill_in("Email", with: user.email)
          fill_in("Password", with: "password")
          click_button("Signin")
          expect(current_path).to eq user_path(user)
        end
      end
    end
  end
