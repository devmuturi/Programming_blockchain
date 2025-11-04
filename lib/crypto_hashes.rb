# crypto hashes
require "digest"
require "pp"

class Block
  attr_reader :data, :hash, :nonce, :prev

  def initialize(data, prev)
    @data = data
    @prev = prev
    @nonce, @hash = compute_hash_with_proof_of_work
  end

  def compute_hash_with_proof_of_work(difficulty = "0000")
    nonce = 0
    loop do
      hash = Digest::SHA256.hexdigest("#{nonce}#{prev}#{data}")
      return [nonce, hash] if hash.start_with?(difficulty)

      nonce += 1
    end
  end
end

# Build some blocks linked(chained) together with crypto hashes
b0 = Block.new("Hello, Cryptos!", "0000000000000000000000000000000000000000000000000000000000000000")
b1 = Block.new("Hello, Cryptos! - Hello, Cryptos!", b0.hash)
b2 = Block.new("Your Name Here", b1.hash)
b3 = Block.new("Data Data Data Data", b2.hash)

blockchain = [b0, b1, b2, b3]

pp blockchain
