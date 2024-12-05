INPUT = <<-'EOF'.strip
.|...\....
|.-.\.....
.....|-...
........|.
..........
.........\
..../.\\..
.-.-/..|..
.|....-|.\
..//.|....
EOF
INPUT = DATA.read

MAP = INPUT.lines(chomp: true).map(&:chars)

height = MAP.length
width = MAP[0].length

energized = Hash.new
explored_heads = Hash.new

heads = [[[-1, 0], [1, 0]]]

while !heads.empty?
  new_heads = []

  heads.each { |pos, dir|
    explored_heads[[pos, dir]] = true
    x, y = pos
    dx, dy = dir

    new_x = x + dx
    new_y = y + dy

    if new_x < 0 || new_x >= width || new_y < 0 || new_y >= height
      next
    end

    c = MAP[new_y][new_x]
    energized[[new_x, new_y]] = true

    if c == "|" && dx != 0
      new_heads << [[new_x, new_y], [0, 1]]
      new_heads << [[new_x, new_y], [0, -1]]
    elsif c == "-" && dy != 0
      new_heads << [[new_x, new_y], [1, 0]]
      new_heads << [[new_x, new_y], [-1, 0]]
    elsif c == "/"
      if dx == 0
        new_heads << [[new_x, new_y], [-dy, 0]]
      else
        new_heads << [[new_x, new_y], [0, -dx]]
      end
    elsif c == "\\"
      if dx == 0
        new_heads << [[new_x, new_y], [dy, 0]]
      else
        new_heads << [[new_x, new_y], [0, dx]]
      end
    else
      new_heads << [[new_x, new_y], [dx, dy]]
    end
  }

  heads = new_heads.filter { |head|
    !explored_heads.include?(head)
  }
end

p energized.count
#(0...height).each { |y|
  #(0...width).each { |x|
    #if energized[[x, y]]
      #print "#"
    #else
      #print " "
    #end
  #}
  #puts
#}


starting_positions = []
(0...height).each { |i|
  starting_positions << [[-1, i], [1, 0]]
  starting_positions << [[width, i], [-1, 0]]
}

(0...width).each { |i|
  starting_positions << [[i, -1], [0, 1]]
  starting_positions << [[i, height], [0, -1]]
}

max_energy = 0

starting_positions.each { |starting|
  energized = Hash.new
  explored_heads = Hash.new

  heads = [starting]

  while !heads.empty?
    new_heads = []

    heads.each { |pos, dir|
      explored_heads[[pos, dir]] = true
      x, y = pos
      dx, dy = dir

      new_x = x + dx
      new_y = y + dy

      if new_x < 0 || new_x >= width || new_y < 0 || new_y >= height
        next
      end

      c = MAP[new_y][new_x]
      energized[[new_x, new_y]] = true

      if c == "|" && dx != 0
        new_heads << [[new_x, new_y], [0, 1]]
        new_heads << [[new_x, new_y], [0, -1]]
      elsif c == "-" && dy != 0
        new_heads << [[new_x, new_y], [1, 0]]
        new_heads << [[new_x, new_y], [-1, 0]]
      elsif c == "/"
        if dx == 0
          new_heads << [[new_x, new_y], [-dy, 0]]
        else
          new_heads << [[new_x, new_y], [0, -dx]]
        end
      elsif c == "\\"
        if dx == 0
          new_heads << [[new_x, new_y], [dy, 0]]
        else
          new_heads << [[new_x, new_y], [0, dx]]
        end
      else
        new_heads << [[new_x, new_y], [dx, dy]]
      end
    }

    heads = new_heads.filter { |head|
      !explored_heads.include?(head)
    }
  end

  max_energy = [max_energy, energized.count].max
}

p max_energy

__END__
\....................\...|...................\/........|.....-......|....|................................/...
...../.../........|.........../......-........-...|.....|............\............./..../.\.\.................
|................./..../...............................................-....................\......../........
.................\.........../...-.............................-.......-......|................../.|..\.|.....
......\./...-........................................-.......\........-.........................\.............
.\..-...-/\.....\.../.......-..............|..../.........|.............-...........|./......|........-.......
./.....\...........|.....-.........|........../.../.............\......\....-|....-.....-.\..............\....
.....\...|............|........\../..-....................\\.-...-./...............\...-.........../.-........
.|.\................./.....................-.......-.../............\...../...........|.......................
....../......\-.............../..................../.\...|........../....../......../\.......\..\-\........./.
.........\............-|.............\.....................\......-........-...........................-....|.
...-.-..-.......././..........|.-...../..\...\....|..........-.........|......../...\.........................
.........\...............\...../............................|.................................................
................|......./../...................|.....\|......................|../../.-.......\./.....|./......
......../|......................|....\.................\.........\|..............-.............../../.........
.......\......\....................../..-............................-..................-.....|..../..........
........|../...................\.............................../.\...../......./...............-.../..........
|.................../.\....-............................................\.|......|...\.........\..../.........
........|-....-/.........../...........................-......\..\\.......\............-....../....\.-....../.
..............\......./.....\......................-......-.\.-............................|.../....|.........
.........................\..............\........../...|...........|...|.....-..............|................-
...............\....|............../.......-..\.................|..-........../.............../...............
-....................\.........|.............../.........\..............................-./............../.../
.........||......|.\.../....../.....-../.......|........./-.|................-......../.............-..|......
..............................|.............|-........./....|.\..../.............\......./\.|..-..............
....................-..|......\.......|....................\..../...........\...................\../..........
|.....\.........\.......|...............|..................|.|................|.|..........\...\...|....../...
.......\.........|.\........-......\..........|................|./....\...........-...............\.........|.
.........|......................................................................................./......-....|
.........|.....|....\...\..\....\......\....................-......../.............\/-........................
............-.............\......./..\./................./.................................\....|...\/........
...........................................\............\|.....................|................./......\.....
.........-..................|.......\.............................-...|.|............../\..\....../........-..
.........\-.....-.....|.........\........|........-./....................-.....|..../.......|./.\...|.\.......
...-...............|...../............/.||..|.......................-...|.........................../.........
...................-../...............................................-/........\....................-..-.....
...............-............/..|...-..-\......................|....../.............-................\.......\.
..............|....-........-......................./........./\..............|../............................
.-....|.\.-...\\-............-...../..|..../....|.|..........-.......|.....\.....\...\...-............/.......
....../......-./............................................\...............................-...-........-....
./....\...........|.../.........................................\-/.....\............/.........../|...........
........\..../-......................|/.......................-.......-.....-././....|..............\.........
................|........-................................................/......-........................-...
-.........\......-...\.........|..|..|.....|....|.........................../....-.....|/................/....
...-......|......../..........-.\....../......-.............\|....././.../....................................
.....................\......................./...../\/.........|.../..........\.-..../....\/..................
..|.......\.../...........\................|............/....-........../.....\..\......-............./......|
......-.|..................................................-......-......|............/.......................
..\............-./...|.................../.\.........................-........\..........................||./.
...............................\..../................/.....|..............-......\...........................|
....../.........../..../.\......................................................-....-...............\....-...
....\...........|.............../...................\.|.............-.\..\../.|.|.................../.........
.......................|........-../|...........................................-.............................
............../.............|.....................\...........|........\......|.................../...........
..|....|.............|...|............|...-..|....................................|.....-./...................
...|.............-.......-.........\.................................-/....|...........|...../......-......./.
....../............\.-.......................|.........................|.|.....\............-...-....../.../..
../....\..-........|.........\......|........\.../.......-...|....\..\.-.....................|................
\........-.-.........................-............\|.....\...............|....-....../......|......\..........
...-...................|..\..........................-....\.......-\.....................-............|.......
....\...........\...........-............................|..-../.........\...\................\...-.....-.....
..........\.....\./.............................|...|.....-...................|................./.............
...............|........|\.........|..-.............-../.../...../......................|....../...|..-\......
.|...........\./..\...........|....................|.........................-......................./........
..././.............-..\....\.......|........|....|.\.\.....................-.............../../........-......
....|...|........................./..\......../.......-...........................|./..|.......-..............
........................../../.............../.....\.\..\...............-\...............//.-.................
..............|......................//.../.............|..........\..........................................
...-.|......................................\//............................/..........\.....\........\.....\..
.-.............../........\............................../......-/.............|....\.........................
\.........................-..............-....................../....\.../.........|................-./.......
./........-....|......../...-....-........|.......\..../...|.\.|......................................\.......
........-.|.........\.....\.-.......|....-.....|.............././...................../...................-...
........................\....-..............................-...-.......................|.............\...-|..
./........\-............................................|./.\.................|..........|/...|-..............
............\......./.......-.......\......|..|.........|.......|...........|..../....-../|......|-.-.........
.\......\.............................................-......./......................................./......|
...................................-.......\..-././..................|........./.............................|
..............|..................-..\.-..............|......../....................-./...........|...-...|....
.....\......................./............................\...\/.....-..........-........./.../.-.............
/....-./..\..............-....-........|..-............../...\...../.....|.....-....-...................|...|.
..........-......./.............|...../.-|.......................\..|.........-.............\.....\.....-.....
../......................................./..........................\.....\..........-...................|...
.............................-................-....-..../.................................../................-
........................./.....\....|/........|.........-\........\.........\.........|.-..........|......./..
....................--../................-...../..|....................\....../..........|.........\..........
....../.......-........-.-...-....\../|.............|.......................-................................\
....................|.-../........-.............../.../........./.....-/......\--..../....-........-......../.
.............\.......\............../...-................................./..........|........................
..\..../..../.....|............................................-../...........-.........................\...\.
.........../.-.\...\...........................|..........|..........-.........................-....\.........
.....-...|.....|......../......................./.........|.................|.............../..-.......-.\....
.-.................\........./.........\...\.....................................................\.......|....
..-......-................-.-..........\...................../....|...............-................\..../.....
..-....|....................\.....\..\.|.../......|.|..../..-./........................|-.....................
|.\........-.....................|..................-........-.......\..............|.../../.....-............
.........-.......................|......................|.......|............|../......|......./......../.....
..\....................|.........-............../../.....................-.....................\..............
...|....\.........................|.....|.../......|..\......\-........-..........-.|.....|......-............
..-../...............-..|......../.........|.........../...|.............\....\...............................
..\..|..........................|../...........\..|..........|............/..-..-....../......................
.|./............\.|.................\..-....../......................|..........-....../.......\..............
..........................\..-.\.|........./.............../......-............./...................../.......
-..\.......|.............................-..-........................\|.................../........-|.../.....
..........-.|../.|...........-..........--.........................\...................../....................
...\./............|.........-.....-.......|............-............|......\.....||....\..-......./...........
.....................-...................../......../....................\......................../...\.......
......................./-..\................................/.|....../......../................|..............
....../..|..../......................-..........\........|/......-.........-..................................
.................-.......\-.............................................\.../.....\...........................