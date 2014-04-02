require 'spec_helper'

describe "AlbumsPages" do
  before do 
    @member = FactoryGirl.create(:member)
    @album_manager = FactoryGirl.create(:album_manager)
    @album = FactoryGirl.create(:album)
  end

  subject { page }

  describe "album index while not logged in" do
    before { visit albums_path }

    it { should have_content('Albums') }
    it { should have_content(@album.title) }
    it { should_not have_content('Edit') }
    it { should_not have_content('Delete') }
    it { should_not have_content('New Album') }

  end

  describe "album index while logged in as basic member" do
    before do
      login_as(@member, :scope => :member)
      visit albums_path
    end

    it { should have_content('Albums') }
    it { should have_content(@album.title) }
    it { should_not have_content('Edit') }
    it { should_not have_content('Delete') }
    it { should_not have_content('New Album') }

  end

  describe "album index while logged in as event manager" do
    before do
      login_as(@album_manager, :scope => :member)
      visit albums_path
    end

    it { should have_content('Albums') }
    it { should have_content(@album.title) }
    it { should have_content('Edit') }
    it { should have_content('Delete') }
    it { should have_content('New Album') }

  end

end
