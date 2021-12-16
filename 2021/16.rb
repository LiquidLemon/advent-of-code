test ="A0016C880162017C3686B18A3D4780"
input = test
input = DATA
  .read
  .chomp
  .each_char
  .flat_map { |c|
    c.to_i(16).to_s(2).rjust(4, "0").chars.map(&:to_i)
  }.freeze

def to_i(bits)
  bits.reduce { |acc, x| (acc << 1) + x }
end

def parse(packet, offset=0, depth=0)
  version = to_i(packet[offset+0..offset+2])
  type_id = to_i(packet[offset+3..offset+5])
  value = nil
  children = []
  packet_length = 0

  if type_id == 4
    packet_length = 6
    i = offset + 6
    value = 0
    loop do
      packet_length += 5
      value = value << 4
      value += to_i(packet[i+1..i+4])
      break if packet[i] == 0
      i += 5
    end
  else
    length_id = packet[offset + 6]
    children_length = nil
    children_count = nil
    next_offset = offset

    if length_id == 0
      children_length = to_i(packet[offset + 7..offset + 21])
      next_offset += 22
      packet_length += 22
    else
      children_count = to_i(packet[offset + 7..offset + 17])
      next_offset += 18
      packet_length += 18
    end

    parsed_length = 0

    loop do
      if length_id == 0
        break if parsed_length == children_length
      else
        break if children.length == children_count
      end

      child, child_length = parse(packet, next_offset, depth+1)
      children << child
      next_offset += child_length
      parsed_length += child_length
    end

    packet_length += parsed_length
  end

  [[version, type_id, value, children], packet_length]
end

def version_sum(packet)
  packet[0] + packet[3].sum { |child| version_sum(child) }
end

def eval_packet(packet)
  _version, type_id, value, children = packet

  case type_id
  in 0
    children.sum { |child| eval_packet(child) }
  in 1
    children.reduce(1) { |acc, child| acc * eval_packet(child) }
  in 2
    children.map { |child| eval_packet(child) }.min
  in 3
    children.map { |child| eval_packet(child) }.max
  in 4
    value
  in 5
    a, b = children.map { |child| eval_packet(child) }
    a > b ? 1 : 0
  in 6
    a, b = children.map { |child| eval_packet(child) }
    a < b ? 1 : 0
  in 7
    a, b = children.map { |child| eval_packet(child) }
    a == b ? 1 : 0
  end
end

packet, _ = parse(input)
puts version_sum(packet)
puts eval_packet(packet)

__END__
A059141803C0008447E897180401F82F1E60D80021D11A3DC3F300470015786935BED80A5DB5002F69B4298A60FE73BE41968F48080328D00427BCD339CC7F431253838CCEFF4A943803D251B924EC283F16D400C9CDB3180213D2D542EC01092D77381A98DA89801D241705C80180960E93469801400F0A6CEA7617318732B08C67DA48C27551C00F972830052800B08550A277416401A5C913D0043D2CD125AC4B1DB50E0802059552912E9676931530046C0141007E3D4698E20008744D89509677DBF5759F38CDC594401093FC67BACDCE66B3C87380553E7127B88ECACAD96D98F8AC9E570C015C00B8E4E33AD33632938CEB4CD8C67890C01083B800E5CBDAB2BDDF65814C01299D7E34842E85801224D52DF9824D52DF981C4630047401400042E144698B2200C4328731CA6F9CBCA5FBB798021259B7B3BBC912803879CD67F6F5F78BB9CD6A77D42F1223005B8037600042E25C158FE0008747E8F50B276116C9A2730046801F29BC854A6BF4C65F64EB58DF77C018009D640086C318870A0C01D88105A0B9803310E2045C8CF3F4E7D7880484D0040001098B51DA0980021F17A3047899585004E79CE4ABD503005E610271ED4018899234B64F64588C0129EEDFD2EFBA75E0084CC659AF3457317069A509B97FB3531003254D080557A00CC8401F8791DA13080391EA39C739EFEE5394920C01098C735D51B004A7A92F6A0953D497B504F200F2BC01792FE9D64BFA739584774847CE26006A801AC05DE180184053E280104049D10111CA006300E962005A801E2007B80182007200792E00420051E400EF980192DC8471E259245100967FF7E6F2CF25DBFA8593108D342939595454802D79550C0068A72F0DC52A7D68003E99C863D5BC7A411EA37C229A86EBBC0CB802B331FDBED13BAB92080310265296AFA1EDE8AA64A0C02C9D49966195609C0594223005B80152977996D69EE7BD9CE4C1803978A7392ACE71DA448914C527FFE140
