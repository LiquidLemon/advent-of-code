require 'digest'
input = "bgvyzdsv"
i = 1
while true 
    print "\r" + i.to_s
    break if !Digest::MD5.hexdigest(input+i.to_s).match(/^0{6}/).nil?
    i += 1
end
print "\n"
