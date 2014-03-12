require 'spec_helper'

describe "StaticPages" do

  describe "Home page" do
    it "should have the content 'Welcome to the Zeta Psi Fraternity'" do
      visit '/'
      expect(page).to have_content('Welcome to the Zeta Psi Fraternity')
    end

    it "should have the right title" do
      visit '/'
      expect(page).to have_title("Zeta Psi - Mu Theta | Home")
    end
  end

  describe "About page" do
    it "should have the content 'The History of Zeta Psi'" do
      visit '/about'
      expect(page).to have_content('The History of Zeta Psi')
    end

    it "should have the right title" do
      visit '/about'
      expect(page).to have_title("Zeta Psi - Mu Theta | About")
    end
  end

  describe "Contact page" do
    it "should have the content 'please contact us directly'" do
      visit '/contact'
      expect(page).to have_content('please contact us directly')
    end

    it "should have the right title" do
      visit '/contact'
      expect(page).to have_title("Zeta Psi - Mu Theta | Contact")
    end
  end

end
