#!/usr/bin/env ruby

class TaskCommand
  attr_reader :root_dir

  def self.execute(root_dir)
    new(root_dir).execute
  end

  def initialize(root_dir)
    @root_dir = root_dir
  end

  def execute
    puts "\033[1;36mBuild release artifacts\033[0m"

    set_release_name
    set_release_tag
    set_release_commit
    set_release_notes
  end

  private

  def set_release_name
    puts 'Set release name...'
    File.write("#{release_artifacts_dir}/name", "v#{release_version}")
    puts "\033[1;32mok\033[0m"
  rescue StandardError
    puts "\033[1;31mfailed\033[0m"
  end

  def release_artifacts_dir
    @release_artifacts_dir ||= File.expand_path('release-artifacts', root_dir)
  end

  def release_version
    @release_version ||= begin
      version_file = File.expand_path('version/version', root_dir)
      File.read(version_file).strip
    end
  end

  def set_release_tag
    puts 'Set release tag...'
    File.write("#{release_artifacts_dir}/tag", "v#{release_version}")
    puts "\033[1;32mok\033[0m"
  rescue StandardError
    puts "\033[1;31mfailed\033[0m"
  end

  def set_release_commit
    puts 'Set release commit...'
    commit_ref_file = File.expand_path('app/.git/ref', root_dir)
    release_commit_id = File.read(commit_ref_file).strip
    File.write("#{release_artifacts_dir}/commitish", release_commit_id)
    puts "\033[1;32mok\033[0m"
  rescue StandardError
    puts "\033[1;31mfailed\033[0m"
  end

  def set_release_notes
    puts 'Set release notes...'
    notes = '# Changelog'
    File.write("#{release_artifacts_dir}/notes.md", notes)
    puts "\033[1;32mok\033[0m"
  rescue StandardError
    puts "\033[1;31mfailed\033[0m"
  end
end

TaskCommand.execute(Dir.pwd) if __FILE__ == $PROGRAM_NAME
