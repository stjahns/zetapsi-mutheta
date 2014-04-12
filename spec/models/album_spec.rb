require 'spec_helper'

describe Album do

  before do 
    @album = FactoryGirl.create(:album)
  end

  subject { @album }

  it { should be_valid }

  it { should respond_to(:title) }
  it { should respond_to(:frontpage?) }

  it "should not be frontpage album after another album is assigned" do
    @album.frontpage = true
    @album.save

    @album.frontpage?.should == true

    album2 = FactoryGirl.create(:album)
    album2.frontpage = true
    album2.save

    @album.reload
    album2.reload

    @album.frontpage?.should == false
    album2.frontpage?.should == true
  end
end
