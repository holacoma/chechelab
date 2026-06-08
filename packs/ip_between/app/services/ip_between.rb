module IpBetween
  module_function

  def ips_between(start_ip, end_ip)
    start_ip_num = ip_to_num(start_ip)
    end_ip_num = ip_to_num(end_ip)

    (start_ip_num - end_ip_num).abs
  end

  def ip_to_num(ip_string)
    ip_string.split('.').map(&:to_i).inject(0) do |total, octet|
      (total << 8) | octet
    end
  end
end
