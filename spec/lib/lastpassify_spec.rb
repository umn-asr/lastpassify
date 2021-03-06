require_relative "../spec_helper"

RSpec.describe LastPassify::LastPassify, type: :aruba do
  describe "when given a database.example.yml file" do
    let(:input) { "database.example.yml" }
    let(:output) { "config/database.yml" }

    before :all do
      status = system("lpass status -q")
      unless status
        raise(StandardError, "Please log in to lastpass with lpass login")
      end
    end

    before :each do
      copy "%/database.example.yml", "database.example.yml"
    end

    it "copies the output file to config/database.yml" do
      run_command "bundle exec lastpassify #{input}"
      expect(output).to be_an_existing_file
      expect(output).to have_file_content(/Ex@mple_p@ssw0rd\#\$/)
    end

    it "doesn't copy production block" do
      run_command "bundle exec lastpassify #{input}"
      expect(output).not_to have_file_content(/production/)
    end

    it "doesn't copy staging block" do
      run_command "bundle exec lastpassify #{input}"
      expect(output).not_to have_file_content(/staging|qat/)
    end

    it "retrieves values for keys that contain spaces" do
      run_command "bundle exec lastpassify #{input}"
      expect(output).to have_file_content(/secret_key: test/)
    end

    context "includes production flag" do
      before :each do
        run_command "bundle exec lastpassify #{input} -p"
      end

      it "copies production block" do
        expect(output).to have_file_content(/production/)
      end
    end

    context "includes staging flag" do
      before :each do
        run_command "bundle exec lastpassify #{input} -s"
      end

      it "copies staging block" do
        expect(output).to have_file_content(/staging/)
      end
    end

    context "output file is set" do
      before :each do
        run_command "bundle exec lastpassify #{input} some_other_file.yml"
      end

      it "creates output filename" do
        expect("some_other_file.yml").to be_an_existing_file
      end
    end
  end

  it "has a version number" do
    expect(LastPassify::VERSION).not_to be nil
  end
end
