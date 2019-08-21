RSpec.describe JobMinder do
  it "has a version number" do
    expect(Jobminder::VERSION).not_to be nil
  end

  it "does something useful" do

    test_job = JobMinder.new_job(:test) do |job|

      binding.pry

    end


  end
end
