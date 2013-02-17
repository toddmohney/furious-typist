require 'spec_helper'

describe Article do

  it "fails validation with no body" do
    expect(Article.new).to have(1).error_on(:body)
  end

  it "fails validation without a title" do
    expect(Article.new).to have(1).error_on(:title)
  end

  it "fails validation without a url" do
    expect(Article.new).to have(1).error_on(:url)
  end

  it "passes validation with a body attribute" do
    expect(Article.new({ :body => "sample body" })).to have(0).errors_on(:body)
  end

  it "passes validation with a title attribute" do
    expect(Article.new({ :title => "sample title" })).to have(0).errors_on(:title)
  end

  it "passes validation with a url attribute" do
    expect(Article.new({ :url => "http://google.com" })).to have(0).errors_on(:url)
  end


  it "has a valid factory" do
    FactoryGirl.create(:article).should be_valid
  end

  it "has count+1 Articles after creation" do
    count = Article.find(:all).count

    Article.create({ :body => "Sample body",
                     :title => "Sample title",
                     :url => "http://gmail.com/" })

    expect(Article.count).to eq(count + 1)
  end

end
