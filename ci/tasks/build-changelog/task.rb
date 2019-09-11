#!/usr/bin/env ruby

require 'open3'

class TaskCommand
  attr_reader :root_dir

  def self.execute(root_dir)
    new(root_dir).execute
  end

  def initialize(root_dir)
    @root_dir = root_dir
  end

  def execute
    puts "\033[1;36mBuild Changelog\033[0m"

    parse_commit_messages
  end

  private

  def parse_commit_messages
    delimiter = '###___###'
    command = "git -C app log v#{release_version}..HEAD --pretty='%B#{delimiter}'"
    puts command
    output, status = Open3.capture2e(command)

    raise "DDDD" unless status.exitstatus.zero?

    messages = {
      add: [],
      update: [],
      remove: [],
      fix: []
    }

    output.strip.split(delimiter).map do |entry|
      type = nil
      message = nil
      entry.each_line do |line|
        puts line.inspect
        case line.strip
        when '[add]'
          messages[type] << message unless message.nil?
          type = :add
          message = ''
        when '[remove]'
          messages[type] << message unless message.nil?
          type = :remove
          message = ''
        else
          message << line unless type.nil?
        end
        # type = line.gsub(/\[|\]/, '') if line.strip == '[add]'
        puts "type: #{type.inspect}"
      end
      messages[type] << message.strip unless type.nil?
      # entry.strip.gsub(/.*(\[add\].*)/m, '\1')

    end

    puts messages.inspect
    changelog_filename = File.expand_path('app/CHANGELOG.md', root_dir)
    changelog_file = File.open(changelog_filename, 'a+')

    messages.each do |type, changelog_messages, |
      changelog_file.write("")
    end
    changelog_file.close
  end

  def release_version
    @release_version ||= begin
      version_file = File.expand_path('version/version', root_dir)
      File.read(version_file).strip
    end
  end
end

TaskCommand.execute(Dir.pwd) if __FILE__ == $PROGRAM_NAME
