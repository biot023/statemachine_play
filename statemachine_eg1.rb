require "statemachine"

$vending_machine = Statemachine.build do
  
  trans( :waiting, :dollar, :paid )
  trans( :paid, :selection, :waiting )
  trans( :waiting, :selection, :waiting )
  trans( :paid, :dollar, :paid )
  
end

def vm
  $vending_machine
end
