require 'puppet_bind/provider/nsupdate'

Puppet::Type.type(:dns_rr).provide(:nsupdate) do

  include PuppetBind::Provider::NsUpdate

  commands :dig => 'dig', :nsupdate => 'nsupdate'

  def initialize(value={})
    super(value)
    @properties = {}
  end

  def rrdata
    query.map { |record| record[:rrdata] }.sort
  end

  def rrdata=(rrdata)
    @properties[:rrdata] = rrdata
  end

private

  def newdata
    resource[:rrdata]
  end

  def specarray
    resource[:spec].split('/')
  end

  def rrclass
    specarray[0]
  end

  def type
    specarray[1]
  end

  def name
    specarray[2]
  end

end
