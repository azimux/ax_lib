module Azimux
  PGSMALLINTMAX = 2 ** 15

  EMAIL_REGEX = /^[A-Z0-9._%+-]+@(?:[A-Z0-9-]+\.)+[A-Z]+$/i
  VERIFY_CODE_LENGTH = 16

  def self.generate_verify_code
    chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'

    retval = ""

    VERIFY_CODE_LENGTH.times do
      retval << chars[rand(chars.length)]
    end
    retval
  end
end