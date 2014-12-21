module SteamClubAPI
  class CryptoUtil
    attr_reader :cipher_type

    def initialize(options = {})
      @cipher_type = options.fetch(:cipher_type, default_cipher_type)
    end

    def self.decrypt(armored_iv_and_ciphertext, key, options = {})
      new(options).decrypt(armored_iv_and_ciphertext, key)
    end

    def self.encrypt(data, key, options = {})
      new(options).encrypt(data, key)
    end

    def decrypt(armored_iv_and_ciphertext, key)
      ciphertext = [armored_iv_and_ciphertext].pack("H*")
      aes.decrypt
      aes.key = sha_hexdigest(key)
      aes.iv = ciphertext.slice!(0, 16)
      aes.update(ciphertext) + aes.final
    end

    def encrypt(data, key)
      aes.encrypt
      aes.iv = iv = aes.random_iv
      aes.key = sha_hexdigest(key)
      iv_and_ciphertext = iv + aes.update(data) + aes.final
      armored_iv_and_ciphertext = iv_and_ciphertext.unpack("H*")[0]
    end

    private

    def aes
      @aes ||= OpenSSL::Cipher::Cipher.new(cipher_type)
    end

    def sha_hexdigest(key)
      Digest::SHA512.hexdigest(key)
    end

    def default_cipher_type
      "AES-256-CBC"
    end
  end
end
