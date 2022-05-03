# frozen_string_literal: true

require_relative 'file'

module Ls
  class Display
    def initialize(options)
      params = options['a'] ? ['*', ::File::FNM_DOTMATCH] : ['*']
      file_names = Dir.glob(*params)
      file_names = file_names.reverse if options['r']
      @files = file_names.map { |file_name| Ls::File.new(file_name) }
    end
  end
end
