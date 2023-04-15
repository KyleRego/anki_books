# frozen_string_literal: true

class TestsController < ApplicationController # :nodoc:
  def show
    @hello = "world"
    @random = ["red", "blue", "black", "yellow",
              "white", "colors", "random color", "pink",
              "light blue", "green", "rainbow", "purple"].sample
  end
end
