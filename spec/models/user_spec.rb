require 'spec_helper'

describe User do
  describe "validation" do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:username) }
    it { should ensure_length_of(:username).is_at_most(64) }
  end
end


