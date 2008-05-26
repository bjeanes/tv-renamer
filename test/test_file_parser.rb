$: << File.dirname(__FILE__)
$: << File.join(File.dirname(__FILE__), "..")

require 'test/unit'
require 'lib/tvparser'

class TestTVParser < Test::Unit::TestCase
  def test_parses_file_name_common
    assert_equal(["House", 4, 13], 
      p("House.S04E13.HDTV.XviD-XOR.avi"))
  end
  
  def test_parses_file_name_double_episode
    assert_equal(["My Name Is Earl", 3, 7..8], 
      p("my.name.is.earl.s03e07-e08.hdtv.xvid-xor.[VTV].avi"))
  end
  
  def test_parses_file_name_with_x_and_underscores
    assert_equal(["My Name Is Earl", 3, 17], 
      p("My_Name_Is_Earl.3x17.No_Heads_And_A_Duffel_Bag.HDTV_XviD-FoV.[VTV].avi"))
  end
  
  def test_parses_filename_normal_with_x
    assert_equal(["My Name Is Earl", 3, 4], p("My Name Is Earl - 3x04.avi"))
  end
  
  def test_parses_file_name_common_dash
    assert_equal(["MythBusters", 4, 1], 
      p("MythBusters - S04E01 - Newspaper Crossbow.avi"))
  end
  
  private
  def p(s)
    TVParser.parse(s)
  end
end