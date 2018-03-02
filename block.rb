require 'digest'

class Block
  attr_accessor :index, :hash, :prev_hash,  :data, :time,  :proof

  @@dificulty = "000"

  def initialize(data, prev_hash)
	@data = data
	@prev_hash = prev_hash	
	@time = Time.now.getutc.to_i 
	@hash = gen_hash @data,@prev_hash,@time 
  end 

  def gen_hash(data, prev_hash, time)
    Digest::SHA2.hexdigest "#{data}#{prev_hash}#{time}"	
  end


  # Our PoW alogrithm checks for a hash sting with 3 zeros. 
  def valid_proof?(proof)
    proof_hash = Digest::SHA2.hexdigest "#{@prev_hash}#{proof}"
    proof_hash.start_with?(@@dificulty) 
  end

  def mine()
    proof = 0
    while !valid_proof?(proof) do
	proof = proof + 1
    end
    puts "pow found with nounace #{proof} and hash is #{Digest::SHA2.hexdigest "#{@prev_hash}#{proof}"}"
    @proof = proof
  end

end
