require 'spec_helper'

describe User do
  it "creates new user" do
  	create(:user).should have(0).errors_on(:id)
  end
end
