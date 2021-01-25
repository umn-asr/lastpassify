require "lastpassify/lastpassify"

module LastPassify
  class Runner
    # Allow everything fun to be injected from the outside while defaulting to normal implementations.
    def initialize(argv, stdin = $stdin, stdout = $stdout, stderr = $stderr, kernel = Kernel)
      @argv, @stdin, @stdout, @stderr, @kernel = argv, stdin, stdout, stderr, kernel
    end

    def execute!
      exit_code = begin
        # Replacing streams so we can use them
        $stderr = @stderr
        $stdin = @stdin
        $stdout = @stdout

        # Execute LastPassify
        LastPassify.start(@argv)

        # Thor::Base#start does not have a return value, assume success if no exception is raised.
        0
      rescue => e
        # The ruby interpreter would pipe this to STDERR and exit 1 in the case of an unhandled exception
        b = e.backtrace
        @stderr.puts("#{b.shift}: #{e.message} (#{e.class})")
        @stderr.puts(b.map { |s| "\tfrom #{s}" }.join("\n"))
        1
      rescue SystemExit => e
        e.status
      ensure
        # ...then we put the streams back.
        $stderr = STDERR
        $stdin = STDIN
        $stdout = STDOUT
      end

      # Proxy our exit code back to the injected kernel.
      @kernel.exit(exit_code)
    end
  end
end
