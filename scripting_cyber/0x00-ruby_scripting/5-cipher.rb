#!/usr/bin/env ruby

class CaesarCipher
  # 1. Constructor: saves the shift value when you do CaesarCipher.new(5)
  def initialize(shift)
    @shift = shift
  end

  # 2. Encrypt method: shifts letters forward
  def encrypt(message)
    cipher(message, @shift)
  end

  # 3. Decrypt method: shifts letters backward by making the shift negative
  def decrypt(message)
    cipher(message, -@shift)
  end

  # Make the cipher method private so it can only be called inside this class
  private

  # 4. Core cipher method that handles both encryption and decryption
  def cipher(message, shift_value)
    result = ""

    # Split the message into characters and loop through each one
    message.chars.each do |char|
      if char.match?(/[a-z]/) # If it's a lowercase letter (a-z)
        # Convert letter to number, apply shift, and keep it within a-z bounds
        base = 'a'.ord
        new_char_code = (char.ord - base + shift_value) % 26 + base
        result += new_char_code.chr

      elsif char.match?(/[A-Z]/) # If it's an uppercase letter (A-Z)
        # Convert letter to number, apply shift, and keep it within A-Z bounds
        base = 'A'.ord
        new_char_code = (char.ord - base + shift_value) % 26 + base
        result += new_char_code.chr

      else
        # If it's a space, comma, or exclamation mark, leave it exactly as it is
        result += char
      end
    end

    return result
  end
end
