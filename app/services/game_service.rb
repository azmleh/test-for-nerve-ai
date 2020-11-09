class GameService

  Cell = Struct.new(:name, :value) do
    def x
      set_coords
      @coords[0]
    end
    
    def y
      set_coords
      @coords[1]
    end
    
    def set_coords
      @coords ||= name[1..-1].split(':').map(&:to_i)
    end
  end
  
  GameResult = Struct.new(:cells, :player, :win)
  
  def self.make_move(match_id, cell)
    pp 'MAKE A MOVE XXX', cell
    
    match = Match.find(match_id)
    return GameResult.new([], match.result, true) if match.result
    game = GameService.new(match)
    game.add_move(cell)
    game.result
  end
  
  attr_reader :result, :field
  
  def initialize(match)
    @match = match
    @field = build_field
    @result = nil
    fill_field
  end
  
  def build_field
    cells = {}
    @match.size.times do |i|
      @match.size.times {|j| cells[cell_key(j, i)] = nil }
    end
    cells
  end
  
  def fill_field
    @match.moves.split(';').map do |m|
      @field[m[0..-2]] = m[-1]
    end
  end
  
  def add_move(raw)
    cell = Cell.new(raw['name'], raw['value'])
    @match.moves += "#{cell.name}#{cell.value};"
    @result = calc_win(cell)
    @match.result = @result.player if @result && @result.win
    @match.save
  end
  
  def calc_win(cell)
    [:xx, :yy, :xy, :yx].each do |path|
      cells = send(path, cell)
      result = GameResult.new(cells, cell.value, @match.line <= cells.size)
      return result if result.win
    end
    nil
  end
  
  def cell_key(x, y)
    "c#{x}:#{y}"
  end
  
  def path_to_win(cell)
    result = [cell.name]
    increment = 1
    key = yield increment
    while @field[key] && @field[key] == cell.value do
      increment += 1
      result << key
      key = yield increment
    end
    increment = -1
    key = yield increment
    while @field[key] && @field[key] == cell.value do
      increment -= 1
      result << key
      key = yield increment
    end
    result
  end
  
  def xx(cell)
    path_to_win(cell) { |i| cell_key(cell.x + i, cell.y) }
  end
  
  def yy(cell)
    path_to_win(cell) { |i| cell_key(cell.x, cell.y + i) }
  end
  
  def xy(cell)
    path_to_win(cell) { |i| cell_key(cell.x + i, cell.y + i) }
  end
  
  def yx(cell)
    path_to_win(cell) { |i| cell_key(cell.x - i, cell.y + i) }
  end
  
end
