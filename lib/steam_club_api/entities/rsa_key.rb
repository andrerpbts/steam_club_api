module SteamClubAPI
  module Entities
    class RSAKey
      include Virtus.model

      attribute :publickey_mod, String
      attribute :publickey_exp, String
      attribute :timestamp, Integer
      attribute :steamid, Integer

      def rsa
        @rsa ||= generate_rsa
      end

      def encrypt(plain_text)
        plain_text.gsub!(/[^\x00-\x7F]/i, '')
        rsa.public_encrypt(plain_text).unpack('H*')[0]
      end

      private

      def mod
        publickey_mod.to_i(16)
      end

      def exp
        publickey_exp.to_i(16)
      end

      def generate_rsa
        OpenSSL::PKey::RSA.new.tap do |rsa_key|
          rsa_key.n = mod
          rsa_key.e = exp
        end
      end
    end
  end
end
