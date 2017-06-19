require_relative "../spec_helper"

RSpec.describe LastPassify::LastPassify, type: :aruba, :exit_timeout => 1, :startup_wait_time => 2 do

  let(:lpass) { File.expand_path('../../../bin/lastpassify', __FILE__) }

  describe "when given a database.example.yml file" do
    let(:lpassify) { "#{lpass}" }
    let(:path) { expand_path("%/database.example.yml") }
    let(:input) { "database.example.yml" }
    let(:output) { "database.yml" }

    before :each do
      run "bundle exec lastpassify"
    end

    it "copies the output file to config/database.yml" do
      expect(read(output)).to eq [output]
      # expect(input).to be_an_existing_file
    end
    it "populates LastPass fields"
    it "doesn't include production bloc in output file"
    it "doesn't include staging bloc in output file"
  end

  it "has a version number" do
    expect(LastPassify::VERSION).not_to be nil
  end
end
