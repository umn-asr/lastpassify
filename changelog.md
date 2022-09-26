# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- `byebug` as a development dependency
    - [#19](https://github.com/umn-asr/lastpassify/pull/19)

### Changed

- Lastpassify should now be compatible with projects using Psych 4 and above
    - https://github.com/umn-asr/lastpassify/pull/19

### Fixed

- Update `rexml` and `tzinfo` gems for CVEs
    - https://github.com/umn-asr/lastpassify/pull/17
- Fix comment in `Gemfile`
    - https://github.com/umn-asr/lastpassify/pull/17
- Alphabetize dependencies in `gemspec`
    - https://github.com/umn-asr/lastpassify/pull/17
- Prompt user to login to LastPass when running tests
    - https://github.com/umn-asr/lastpassify/pull/18

## [0.5.0]

### Added
- Tests now ensure you are logged in to lastpass before running
  - https://github.com/umn-asr/lastpassify/issues/9

### Fixed
- Unable to see that lpass is installed
  - https://github.com/umn-asr/lastpassify/issues/12

## [0.4.3]

- Fixed the loading of the LastPassify executable.

## [0.4.2]

- Updates to dependencies
- Minimum Ruby version is now 2.3
- Hopefully fixing the binstub warning

[Unreleased]: https://github.com/umn-asr/lastpassify/compare/v0.5.0...HEAD
[0.5.0]: https://github.com/umn-asr/lastpassify/compare/v0.4.3...v0.5.0
[0.4.3]: https://github.com/umn-asr/lastpassify/compare/v0.4.2...v0.4.3
[0.4.2]: https://github.com/umn-asr/lastpassify/compare/3997abac1101eb75c91543241651976be4d49f73...HEAD
