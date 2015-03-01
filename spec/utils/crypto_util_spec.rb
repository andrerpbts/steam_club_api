require 'spec_helper'

describe SteamClubAPI::CryptoUtil do
  let(:key) { "secretsone" }
  let(:plaintext) { "private one" }
  let(:options) do
    { cipher_type: "AES-256-CBC" }
  end

  describe ".encrypt" do
    subject { described_class }

    it "calls the encrypt of instance" do
      expect(subject).to receive_message_chain("new.encrypt")
        .with(plaintext, key) { :encrypt }
      subject.encrypt plaintext, key, options
    end
  end

  describe ".decrypt" do
    let(:armored_iv_and_ciphertext) { described_class.new.encrypt(plaintext, key) }
    subject { described_class }

    it "calls the decrypt of instance" do
      expect(subject).to receive_message_chain("new.decrypt")
        .with(armored_iv_and_ciphertext, key) { :decrypt }
      subject.decrypt armored_iv_and_ciphertext, key, options
    end
  end

  describe "#encrypt" do
    subject { described_class.new.encrypt(plaintext, key) }

    it { expect(subject).not_to be_nil }
    it { expect(subject).to be_a(String) }
    it { expect(subject).not_to match(plaintext) }
    it { expect(subject).not_to match(key) }
  end

  describe 'decrypt' do
    let(:armored_iv_and_ciphertext) { described_class.new.encrypt(plaintext, key) }
    subject { described_class.new.decrypt(armored_iv_and_ciphertext, key) }

    it { expect(subject).to eq(plaintext) }
  end
end
