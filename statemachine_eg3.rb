# -*- coding: utf-8 -*-
require "statemachine"


class VendingMachineContext

  attr_accessor :statemachine

  def initialize
    @amount_tendered = 0
  end

  def add_coins( of_value )
    @amount_tendered += of_value
  end

  def check_amount_tendered
    if @amount_tendered >= 100
      @statemachine.paid
    else
      @statemachine.not_paid_yet
    end
  end

  def prompt_money
    puts "£ .#{ @amount_tendered }: more money please."
  end

  def prompt_selection
    puts "Please make a selection."
  end
  
end


$vending_machine = Statemachine.build do

  trans( :accept_money, :coin, :coin_inserted, :add_coins )

  state( :coin_inserted ) do
    event( :not_paid_yet, :accept_money, :prompt_money )
    event( :paid, :await_selection, :prompt_selection )
    on_entry( :check_amount_tendered )
  end

  context( VendingMachineContext.new )
  
end

$vending_machine.context.statemachine = $vending_machine


def vm
  $vending_machine
end
