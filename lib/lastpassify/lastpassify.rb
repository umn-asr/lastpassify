require "thor"
require "yaml"

module LastPassify
  # main LastPassify Thor script
  class LastPassify < Thor::Group
    include Thor::Actions

    # Exception for when LastPass-CLI is not installed
    class LPassNotInstalled < RuntimeError; end

    # files will be available as attr_accessors
    argument :input_file, type: :string, default: "config/database.example.yml", desc: "Input file"
    argument :output_file, type: :string, default: "config/database.yml", desc: "Output file"

    class_option :production, type: :boolean, aliases: "-p", desc: "Include production sections"
    class_option :staging, type: :boolean, aliases: "-s", desc: "Include staging sections"

    def self.source_root
      File.expand_path("./")
    end

    desc "Takes a file to process, and outputs a new file populated with values from LastPass."

    NOW = Time.now.strftime("%v")

    def main
      raise LPassNotInstalled, "Please install LastPass-CLI - https://github.com/lastpass/lastpass-cli" unless lastpass_installed?

      template input_file, output_file do |content|
        yml = YAML.safe_load content, [], [], true
        delete_staging(yml) unless options[:staging]
        delete_production(yml) unless options[:production]
        content = YAML.dump(yml)
        content << "# This file was automatically generated by LastPassify on #{NOW}.\n"
      end
    end

    no_commands do
      def lookup(_source, shared_path, field)
        response = if %w[username password url notes id name].include? field
          `lpass show --#{field} "#{shared_path}"`.chomp
        else
          `lpass show --field='#{field}' "#{shared_path}"`.chomp
        end

        puts "Please fill in: '#{shared_path}' : #{field} field" if response.empty?

        response
      end
    end

    private

    def lastpass_installed?
      system("command -v lpass")
    end

    def delete_staging(yml)
      yml.keys.each do |key|
        yml.delete(key) if /staging|qat/.match?(key.to_s)
      end
    end

    def delete_production(yml)
      yml.keys.each do |key|
        yml.delete(key) if /production/.match?(key.to_s)
      end
    end
  end
end
