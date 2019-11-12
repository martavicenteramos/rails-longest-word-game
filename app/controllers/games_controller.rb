# frozen_string_literal: true

require 'open-uri'
require 'json'

# Creating a games contoller to controll the fucking games
class GamesController < ApplicationController
  def new
    alphabete = []
    ('A'..'Z').each { |letter| alphabete << letter }
    @sample = 10.times.map { alphabete.sample }
  end

  def score
    if params[:word] == ''
      @response = "You didn't type anything, try again"
    elsif check_validity == false
      @response = "You can't build #{params[:word]} with #{params[:sample]}"
    elsif check_existance == false
      @response = 'That is not a word, silly!'
    else
      @response = "Congrats, you've own this time!"
    end
  end

  private

  def check_validity
    @grid_check = []
    unless params[:word].nil?
      params[:word].each_char do |char|
        @grid_check << params[:sample].include?(char.upcase)
        @grid_check << (params[:word].count(char.upcase) <= params[:sample].count(char.upcase))
      end
    end
    @value = @grid_check.all?
  end

  def check_existance
    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    @word_exists = JSON.parse(open(url).read)['found']
  end
end
