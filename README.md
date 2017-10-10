# LastPassify

LastPassify is a gem for automating `database.yml` configuration files. The goal of this gem is to populate a given a YAML ERB config file with values from LastPass. It uses the Ruby toolkit [Thor](https://github.com/erikhuda/thor) and [lastpass-cli](https://github.com/lastpass/lastpass-cli).

### Install

LastPassify requires [lastpass-cli](https://github.com/lastpass/lastpass-cli) to be installed.

Also, LastPassify only works with Ruby version 2 and above.

LastPassify expects ERB in the inputted YAML file and uses lastpass-cli to populate these fields with data from LastPass.com
The conventions around how the values should be structured stored on LastPass are described in detail at the [asr_ansible repo](https://github.umn.edu/asrweb/asr_ansible).

#### Artifactory

The gem can be used standalone or included as part of a project's Gemfile. Both ways require grabbing the gem from the UMN's private Artifactory install. To get setup with installing gems from the UMN's private Artifactory repo, you'll first need to generate an API key:

1. Log into [Artifactory](https://artifactory.umn.edu)
1. Click on your name in upper right corner of screen
1. Enter current password to unlock your profile
1. Click "generate" gear, copy to clipboard

Then, you'll need to create a file in your home directory at `~/.gem/credentials`. To populate this file, use curl to make a call to Artifactory with your API key and internet ID:

`$ curl -u*YOURINTERNETID*:*YOURAPIKEY* https://artifactory.umn.edu/artifactory/api/gems/asr-rubygems-local/api/v1/api_key.yaml > ~/.gem/credentials`

Then, change the permissions on this file to 600:

`$ chmod 600 credentials`

Now you can add Artifactory to your list of gem sources:

`$ gem source -a https://artifactory.umn.edu/artifactory/api/gems/asr-rubygems/`

Now when you run a `gem sources --list` at the commandline, Artifactory should be listed along with RubyGems.org

Finally, your Bundler needs to be configured to be able to authenticate and pull gems from Artifactory:

`$ bundle config artifactory.umn.edu <USERNAME>:<YOUR_API_KEY>`

The gem can be installed globally for your version of Ruby by running `gem sources -u && gem install lastpassify`. Otherwise to install it per-project, see the next section for instructions.

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
