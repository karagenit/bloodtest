#!/usr/bin/env ruby

require 'fiddle'
require 'test/unit'

libSimulate = Fiddle.dlopen('./libsimulate.so')

$simulate = Fiddle::Function.new(
  libSimulate['simulate'],
  [Fiddle::TYPE_INT, Fiddle::TYPE_INT, Fiddle::TYPE_INT, Fiddle::TYPE_DOUBLE],
  Fiddle::TYPE_INT
)

$loadSim = Fiddle::Function.new(
  libSimulate['setup'],
  [],
  Fiddle::TYPE_VOID
)

class TestSimulate < Test::Unit::TestCase
  def setup()
    $loadSim.call()
  end

  def test_prob_zero()
    assert_equal($simulate.call(100, 1, 100, 0), 1)
    assert_equal($simulate.call(10, 1, 100, 0), 10)
    assert_equal($simulate.call(1, 1, 100, 0), 100)
  end

  def test_prob_one()
    assert_equal($simulate.call(1, 1, 100, 1), 100)
    assert_equal($simulate.call(10, 10, 100, 1), 110)
    assert_equal($simulate.call(100, 100, 100, 1), 101)
    assert_equal($simulate.call(100, 10, 100, 1), 111)
  end

  def test_div_two()
    assert_equal($simulate.call(2, 2, 16, 1), 24)
  end
end
