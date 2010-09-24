require "statemachine"


class VendingMachineContext

  def activate
    puts "Activating."
  end

  def release( product )
    puts "Releasing product #{ product.inspect }."
  end

  def refund
    puts "Refunding dollar."
  end

  def sales_mode
    puts "Entering Sales Mode."
  end

  def operation_mode
    puts "Entering Operation Mode."
  end
  
end


$vending_machine = Statemachine.build do

  state( :waiting ) do
    event( :dollar, :paid, :activate )
    event( :selection, :waiting )
    on_entry( :sales_mode )
    on_exit( :operation_mode )
  end

  trans( :paid, :selection, :waiting, :release )
  trans( :paid, :dollar, :paid, :refund )
  context( VendingMachineContext.new )
  
end


def vm
  $vending_machine
end
