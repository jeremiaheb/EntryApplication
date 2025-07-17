# ActiveSupport::KeyGenerator is a small wrapper around
# OpenSSL::PKCS5.pbkdf2_hmac.
#
# With FIPS enabled, the salt must be at least 16 bytes. Some places in the
# Rails codebase try to generate keys with smaller salts, which raises an
# exception when FIPS is enabled.
#
# The salt is not a secret but does need to passed consistently. This patch
# pads the salt with null bytes as needed to make it at least 16 bytes.
module ActiveSupport
  module KeyGeneratorFIPSPatch
    MIN_SALT_SIZE = 16

    # See https://github.com/rails/rails/blob/main/activesupport/lib/active_support/key_generator.rb
    def generate_key(salt, key_size = 64)
      super(salt.ljust(MIN_SALT_SIZE, "\x00"), key_size)
    end
  end
end

ActiveSupport::KeyGenerator.prepend(ActiveSupport::KeyGeneratorFIPSPatch)
