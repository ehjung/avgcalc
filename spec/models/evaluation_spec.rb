require 'spec_helper'

describe Evaluation do
  it "should create a new evaluation" do
  	@new_evaluation = Evaluation.create(grade: 77, for: @new_work)
  	expect(Evaluation.where(:id => @new_evaluation).exists?).to eq(true)
  end
end
