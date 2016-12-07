class IP7 < String
  def tls?
    self.match(/(.)(?!\1)(.)\2\1/) &&
      !self.match(/\[[^\]]*(.)(?!\1)(.)\2\1[^\]]*\]/)
  end

  def ssl?
    supernets = self.split(/\[.*?\]/).select { |x| !x.empty? }
    hypernets = self.scan(/\[.*?\]/).map { |x| x[1..-1] }
    scan = supernets.join('|') + '-' + hypernets.join('|')
    scan.match(/(.)(?!\1)(.)\1.*-.*\2\1\2/)
  end
end
INPUT = ARGF.readlines
tls = INPUT.map { |x| IP7.new(x.chomp) }
puts tls.select(&:tls?).size
puts tls.select(&:ssl?).size
