# frozen_string_literal: true

require_relative 'short_list'
require_relative 'long_list'
require 'optparse'

module Ls
  class Command
    def initialize(argv)
      options = argv.getopts('alr')
      list = options['l'] ? Ls::LongList.new(options) : Ls::ShortList.new(options)
      list.show
    end
  end
end
