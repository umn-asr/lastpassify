# LastPassify

LastPassify is a gem for automating `database.yml` configuration files. The goal of this gem is to populate a given a YAML ERB config file with values from LastPass. It uses the Ruby toolkit [Thor](https://github.com/erikhuda/thor) and [lastpass-cli](https://github.com/lastpass/lastpass-cli).

### Install

LastPassify requires [lastpass-cli](https://github.com/lastpass/lastpass-cli) to be installed.

Also, LastPassify only works with Ruby version 2 and above.

LastPassify expects ERB in the inputted YAML file and uses lastpass-cli to populate these fields with data from LastPass.com
The conventions around how the values should be structured stored on LastPass are described in detail at the [asr_ansible repo](https://github.umn.edu/asrweb/asr_ansible).

#### Adding to your project's Gemfile

You can install LastPassify by adding a section for gems sourced from Artifactory to your Gemfile and listing `lastpassify` like so:

```ruby
# sample Gemfile

source "https://rubygems.org" do
  ruby "2.3.3"

  gem "rubocop"
end

source "https://artifactory.umn.edu/artifactory/api/gems/asr-rubygems/" do
  group :development do
    gem "lastpassify"
  end
end

```


### Usage

LastPassify expects an input of one YAML file to be processed and outputs one YAML file. The input file can be passed in as an argument at the commandline like so:

`$ bundle exec lastpassify my_input_file.yml`

The output file and path can also be specified:

`$ bundle exec lastpassify my_input_file.yml config/my_output_file.yml`

LastPassify has default values that silently get passed if no input or output file is specified. The default input file LastPassify will look for is `config/database.example.yml`. The default output will also live in the `config` directory, with a filename of `database.yml`.

#### Flags

By default, LastPassify strips out any YAML keys with production, staging or qat in their names. This is a security measure to ensure no prod or staging environment credentials sit on your local development machine unnecessarily.

However, if for some reason you do want these credentials, this behavior can be overridden by passing in flags:

```
-p flag to include production values in final output file
-s flag to include staging/qat values in final output file
```

Example usage to include production values while using the default filenames and paths:

`$ bundle exec lastpassify -p`

Finally, upon completion, LastPassify will print the date the file was generated at the bottom of the outputted YAML file.


Author Information
------------------
Eric Eklund, Remy Abdullahi @ ASR
