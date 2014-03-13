require 'spec_helper'

describe "HomePages" do

  subject { page }

  describe "Home page" do

    before { visit root_path }

    it { should have_content('Welcome') }
    it { should have_title("Zeta Psi - Mu Theta") }
    it { should_not have_title("Zeta Psi - Mu Theta | Home") }

  end

  describe "About page" do

    before { visit '/about' }

    it { should have_content('The History of Zeta Psi') }
    it { should have_title("Zeta Psi - Mu Theta | About") }

  end

  describe "Contact page" do

    before { visit '/contact' }

    it { should have_content('please contact us directly') }
    it { should have_title("Zeta Psi - Mu Theta | Contact") }

  end

end
