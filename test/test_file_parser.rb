$: << File.dirname(__FILE__)
$: << File.join(File.dirname(__FILE__), "..")

require 'test/unit'
require 'lib/tvparser'

class TestTVParser < Test::Unit::TestCase
  def test_parses_file_name_common
    assert_equal(
      ["House", 4, 13], 
      p("House.S04E13.HDTV.XviD-XOR.avi"))
  end
  
  def test_parses_file_name_double_episode
    assert_equal(
      ["My Name Is Earl", 3, 7..8], 
      p("my.name.is.earl.s03e07-e08.hdtv.xvid-xor.[VTV].avi"))
  end
  
  def test_parses_file_name_with_x_and_underscores
    assert_equal(
      ["My Name Is Earl", 3, 17], 
      p("My_Name_Is_Earl.3x17.No_Heads_And_A_Duffel_Bag.HDTV_XviD-FoV.[VTV].avi"))
  end
  
  def test_parses_filename_normal_with_x
    assert_equal(
      ["My Name Is Earl", 3, 4], 
      p("My Name Is Earl - 3x04.avi"))
  end
  
  def test_parses_file_name_common_dash
    assert_equal(
      ["MythBusters", 4, 1], 
      p("MythBusters - S04E01 - Newspaper Crossbow.avi"))
  end
  
  def test_parses_file_name_with_no_season_episode_separator
    assert_equal(
      ["My Name Is Earl", 3, 5], 
      p("my.name.is.earl.305.hdtv-lol.[VTV].avi"))
  end
  
  def test_parses_file_name_with_quality
    assert_equal(
      ["The Simpsons", 20, 10], 
      p("The.Simpsons.S20E10.720p.HDTV.X264-DIMENSION.mkv"))
  end
  
  def test_parses_file_with_brackets_around_episode_identifier
    assert_equal(
      ["How I Met Your Mother", 3, 15], 
      p("How I Met Your Mother [3x15] The Title.mkv"))
  end
  
  
  def test_parses_file_with_spaces_between_season_and_episode
    assert_equal(
      ["Arrested Development", 2, 3], 
      p("Arrested Development - S2 E 03 - Amigos.avi"))
  end
    
  def test_parses_file_with_dash_as_season_and_episode_separator
    assert_equal(
      ["The Big Bang Theory", 2, 18], 
      p("The Big Bang Theory 02-18"))
  end
  
  def test_parses_file_without_a_dash_between_season_name_and_episode_identifiers
    assert_equal(
      ["The West Wing", 3, 22], 
      p("The West Wing S03E22"))
  end
  
  def test_doesnt_parse_invalid_filename
    assert_nil p("my home video.wmv")
  end
  
  private
  def p(s)
    TVParser.parse(s)
  end
end