require 'spec_helper'

describe Article do
  describe "validation" do
    it "fails validation with no body" do
      expect(Article.new).to have(1).error_on(:body)
    end

    it "fails validation without a title" do
      expect(Article.new).to have(1).error_on(:title)
    end

    it "passes validation with a body attribute" do
      expect(Article.new({ :body => "sample body" })).to have(0).errors_on(:body)
    end

    it "passes validation with a title attribute" do
      expect(Article.new({ :title => "sample title" })).to have(0).errors_on(:title)
    end
  end

  describe "factories" do
    it "has a valid factory" do
      FactoryGirl.create(:article).should be_valid
    end
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
    it { should have_searchable_field(:tags) }
  end

  describe "#markdown" do
    it "returns the html representation of body content written in Markdown" do
      article = Article.new({
        :title => "test title",
        :body => "+ list item"
      })

      expect(article.markdown).to eq("<ul>\n<li>list item</li>\n</ul>\n")
    end
  end

  describe "#get_tag_names" do
    context "when an article has no tags" do
      let(:article) { Article.new({ body: "hey hey", title: "hi hi" }) }

      it "returns an empty string" do
        article.get_tag_names.should eq("")
      end
    end

    context "when an article has tags" do
      let(:article) { Article.new({ body: "hey hey", title: "hi hi", tags: tags }) }
      let(:tags) {[
        Tag.new({ name: "tag_one" }),
        Tag.new({ name: "tag_two" })
      ]}

      it "returns a comma separated list of tags" do
        article.get_tag_names.should eq("tag_one, tag_two")
      end
    end
  end
end
