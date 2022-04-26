# frozen_string_literal: true

require_relative 'display'
require 'optparse'

module Ls
  class Command
    def initialize(argv)
      options = argv.getopts('alr')
      display = Ls::Display.new(options)
      options['l'] ? display.show_list_long : display.show_list_short
    end
  end
end
