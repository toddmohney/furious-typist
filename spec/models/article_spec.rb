require 'spec_helper'

describe Article do
  describe "validations" do
    it { should validate_presence_of(:body) }
    it { should validate_presence_of(:title) }
  end

  describe "#searchable?" do
    subject { article.searchable? }

    let(:article) { stub_model(Article, published: is_published) }

    context "the article is published" do
      let(:is_published) { true }
      it { should be_true }
    end

    context "the article is not published" do
      let(:is_published) { false }
      it { should be_false}
    end
  end

  describe "searchable", search: true do
    subject { Article }

    it { should have_searchable_field(:title) }
    it { should have_searchable_field(:body) }
    it { should have_searchable_field(:categories) }
    it { should have_searchable_field(:tags) }
  end

  describe "#markdown" do
    let(:markdown) { double(:markdown) }
    let(:markdown_output) { double(:markdown_output) }
    let(:article_params) { { :body => "cool article body" } }

    before do
      BlueCloth.stub(:new).with(article_params[:body] ) { markdown }
      markdown.stub_chain(:to_html, :html_safe) { markdown_output }
    end

    it "returns the html representation of body content written in Markdown" do
      article = Article.new(article_params)
      expect(article.markdown).to eq(markdown_output)
    end
  end

  describe "#get_tag_names" do
    context "when an article has no tags" do
      let(:article) { Article.new }

      it "returns an empty string" do
        article.get_tag_names.should eq("")
      end
    end

    context "when an article has tags" do
      let(:tags) { [ double(:tag1, name: "tag_one"), double(:tag2, name: "tag_two") ] }

      before do
        Article.any_instance.stub(:tags) { tags }
      end

      it "returns a comma separated list of tags" do
        article = Article.new
        article.get_tag_names.should eq("tag_one, tag_two")
      end
    end
  end
end
