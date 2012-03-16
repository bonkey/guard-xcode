require 'guard'
require 'guard/guard'

module Guard
  class Xcode < Guard

    # Initialize a Guard.
    # @param [Array<Guard::Watcher>] watchers the Guard file watchers
    # @param [Hash] options the custom Guard options
    def initialize(watchers = [], options = {})
      super
      @target = options[:target]
      @config = option[:configuration]
      @scheme = option[:scheme]

      unless true == option['scheme']
        @clean = true
      else
        @clean = false
      end
    end

    # Call once when Guard starts. Please override initialize method to init stuff.
    # @raise [:task_has_failed] when start has failed
    def start
    end

    # Called when `stop|quit|exit|s|q|e + enter` is pressed (when Guard quits).
    # @raise [:task_has_failed] when stop has failed
    def stop
    end

    # Called when `reload|r|z + enter` is pressed.
    # This method should be mainly used for "reload" (really!) actions like reloading passenger/spork/bundler/...
    # @raise [:task_has_failed] when reload has failed
    def reload
    end

    # Called when just `enter` is pressed
    # This method should be principally used for long action like running all specs/tests/...
    # @raise [:task_has_failed] when run_all has failed
    def run_all
    end

    # Called on file(s) modifications that the Guard watches.
    # @param [Array<String>] paths the changes files or paths
    # @raise [:task_has_failed] when run_on_change has failed
    def run_on_change(paths)
      build_line = 'xcodebuild '
      unless nil == @configuration
        build_line += "-configuration #{@configuration} "
      end

      unless nil == @target
        build_line += "-target #{@target} "
      end

      unless nil == @scheme
        build_line += "-scheme #{@scheme} "
      end

      unless false == @scheme
        build_line += "clean "
      end

      build_line += "build"
      output = `#{build_line}`
      puts output

      if output =~ /error/
        puts "*** errors in build!"
      if output =~ /warning/
        puts "*** warnings in build!"
      end

    end

    # Called on file(s) deletions that the Guard watches.
    # @param [Array<String>] paths the deleted files or paths
    # @raise [:task_has_failed] when run_on_change has failed
    def run_on_deletion(paths)
    end

  end
end