module DeadTrail
  refine(Object) do
    def dead_trail
      def self.dead_trail; end
    end

    def dead_trail?
      respond_to?(:dead_trail)
    end
  end
end

using DeadTrail

def reach_the_top?(rock, trails, hiker)
  return if hiker == rock

  trails.reverse.each do |trail|
    case [hiker, trail]
    when %w(B 1), %w(H 8)
      return if trail.dead_trail?
      hiker = 'A'
    when %w(C 2), %w(A 1)
      return if trail.dead_trail?
      hiker = 'B'
    when %w(D 3), %w(B 2)
      return if trail.dead_trail?
      hiker = 'C'
    when %w(E 4), %w(C 3)
      return if trail.dead_trail?
      hiker = 'D'
    when %w(F 5), %w(D 4)
      return if trail.dead_trail?
      hiker = 'E'
    when %w(G 6), %w(E 5)
      return if trail.dead_trail?
      hiker = 'F'
    when %w(H 7), %w(F 6)
      return if trail.dead_trail?
      hiker = 'G'
    when %w(A 8), %w(G 7)
      return if trail.dead_trail?
      hiker = 'H'
    end
  end

  true
end

def rock_rolling_down(rock, trails)
  trails.each do |trail|
    case [rock, trail]
    when %w(B 1), %w(H 8)
      rock = 'A'
      trail.dead_trail
    when %w(C 2), %w(A 1)
      rock = 'B'
      trail.dead_trail
    when %w(D 3), %w(B 2)
      rock = 'C'
      trail.dead_trail
    when %w(E 4), %w(C 3)
      rock = 'D'
      trail.dead_trail
    when %w(F 5), %w(D 4)
      rock = 'E'
      trail.dead_trail
    when %w(G 6), %w(E 5)
      rock = 'F'
      trail.dead_trail
    when %w(H 7), %w(F 6)
      rock = 'G'
      trail.dead_trail
    when %w(A 8), %w(G 7)
      rock = 'H'
      trail.dead_trail
    end
  end
  rock
end

def solve(input)
  trails, rock = input.split(?:)
  trails = trails.chars

  rock = rock_rolling_down(rock, trails)

  hikers = %w(A B C D E F G H)
  hikers.select {|hiker| reach_the_top?(rock, trails, hiker) }.join
end

def test(input, expected)
  actual = solve(input)
  unless actual == expected
    puts "test(#{input.inspect}) #=>\n  expected: #{expected}\n    actual: #{actual}"
  end
end

test("2512:C", "DEFGH")
test("1:A", "CDEFGH")
test(":C", "ABDEFGH")
test("2345:B", "AGH")
test("1256:E", "ABCDH")
test("1228:A", "ADEFG")
test("5623:B", "AEFGH")
test("8157:C", "ABDEFGH")
test("74767:E", "ABCFGH")
test("88717:D", "ABCEFGH")
test("148647:A", "ACDEFH")
test("374258:H", "BCDEFH")
test("6647768:F", "ABCDEH")
test("4786317:E", "ABFGH")
test("3456781:C", "")
test("225721686547123:C", "CEF")
test("2765356148824666:F", "ABCDEH")
test("42318287535641783:F", "BDE")
test("584423584751745261:D", "FGH")
test("8811873415472513884:D", "CFG")
test("74817442725737422451:H", "BCDEF")
test("223188865746766511566:C", "ABGH")
test("2763666483242552567747:F", "ABCG")
test("76724442325377753577138:E", "EG")
test("327328486656448784712618:B", "")
test("4884637666662548114774288:D", "DGH")
test("84226765313786654637511248:H", "DEF")
test("486142154163288126476238756:A", "CDF")
test("1836275732415226326155464567:F", "BCD")
test("62544434452376661746517374245:G", "G")
test("381352782758218463842725673473:B", "A")
