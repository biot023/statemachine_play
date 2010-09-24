require "statemachine"


$vending_machine = Statemachine.build do

  superstate( :operational ) do
    trans( :waiting, :dollar, :paid )
    trans( :paid, :selection, :waiting )
    trans( :waiting, :selection, :waiting )
    trans( :paid, :dollar, :paid )

    event( :repair, :repair_mode, lambda { puts "Entering Repair Mode." } )
  end

  trans( :repair_mode, :operate, :operational_H, lambda { puts "Exiting Repair Mode." } )

  on_entry_of( :waiting, lambda { puts "Entering Waiting State." } )
  on_entry_of( :paid, lambda { puts "Entering Paid State." } )
  
end


def vm
  $vending_machine
end
