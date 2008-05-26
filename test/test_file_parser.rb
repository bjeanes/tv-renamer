$: << File.dirname(__FILE__)
$: << File.join(File.dirname(__FILE__), "..")

require 'test/unit'
require 'lib/tvparser'

class TestTVParser < Test::Unit::TestCase
  def test_parses_file_name_common
    p = TVParser.parse("House.S04E13.HDTV.XviD-XOR.avi")
    assert_equal("House", p.shift)
    assert_equal(4, p.shift)
    assert_equal(13, p.shift)
  end
  
  def test_parses_file_name_double_episode
    p = TVParser.parse("my.name.is.earl.s03e07-e08.hdtv.xvid-xor.[VTV].avi")
    assert_equal("My Name Is Earl", p.shift)
    assert_equal(3, p.shift)
    assert_equal(7..8, p.shift)
  end
  
  def test_parses_file_name_with_x_and_underscores
    p = TVParser.parse("My_Name_Is_Earl.3x17.No_Heads_And_A_Duffel_Bag.HDTV_XviD-FoV.[VTV].avi")
    assert_equal("My Name Is Earl", p.shift)
    assert_equal(3, p.shift)
    assert_equal(17, p.shift)
  end
  
  def test_parses_filename_normal_with_x
    p = TVParser.parse("My Name Is Earl - 3x04")
    assert_equal("My Name Is Earl", p.shift)
    assert_equal(3, p.shift)
    assert_equal(4, p.shift)
  end
  
  def test_parses_file_name_common_dash
    p = TVParser.parse("MythBusters - S04E01 - Newspaper Crossbow.avi")
    assert_equal("MythBusters", p.shift)
    assert_equal(4, p.shift)
    assert_equal(1, p.shift)
  end
end