require_relative './block'


class Blockchain

  attr_reader :blocks
	
  def initialize
	genesis = Block.new "genesis block", ""
	@blocks = [genesis] 
  end

  def add_block(block)
	@blocks << block
  end

  def create_block(data)
	last_block = @blocks.last			
	new_block =  Block.new(data, last_block.hash) 
	new_block.mine
 	add_block(new_block)
	puts "new block added"	
  end


  def is_chain_valid?
	# puts "chain is #{@blocks.size} blocks long"
	@blocks.each_with_index do |block, idx|
	  if idx > 0 
 	    prev_block = @blocks[idx-1]
	    hash = block.gen_hash block.data, block.prev_hash, block.time
	    
	    # validate hash of current block
            if !(block.hash.eql? hash) 
	  	return false	
	    end	
		
	    if !(block.prev_hash.eql? prev_block.hash)
		return false
	    end
	  end
	end	
	return true
  end

  def dump
        @blocks.each_with_index do |block, idx|
                puts "#{idx} #{block.hash} #{block.data} [proof: #{block.proof}]" 
        end
  end

  def valid_proof?(proof)

  end 




end
