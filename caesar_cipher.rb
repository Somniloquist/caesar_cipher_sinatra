require 'sinatra'
require 'sinatra/reloader' if development?

def caesar_cipher (input, shift = 0)
      cipher = input.split('').map do |c|
          # determine char code at which to wrap
          c == c.downcase ? wrap_a = 'a'.ord : wrap_a = 'A'.ord
          c == c.downcase ? wrap_z = 'z'.ord : wrap_z = 'Z'.ord
          c.match(/\W/) || c.match(/\d/) ? c : (((c.ord - wrap_a + shift) % 26) + wrap_a).chr
      end
      return cipher.join
  end

get '/' do
  message = params['message']
  shift_value = params['shift_value'].to_i
  encrypted_message = caesar_cipher(message, shift_value) unless params['message'].nil?
  erb :index, :locals => { :message => message, :encrypted_message => encrypted_message }
end