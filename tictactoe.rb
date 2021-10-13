class TicTacToe
    attr_accessor :board_positions, :winner, :game_over
    
    def initialize(p1, p2)
      @board_positions = ['1','2','3','4','5','6','7','8','9']
      @game_over = false
      @winner = nil
      @p1 = p1
      @p2 = p2
      play
    end
  
    private
    
    def play
      player = @p1
      available_positions = [1,2,3,4,5,6,7,8,9]
     
  
      until @game_over
        show_board
        puts "#{player.name}: Please choose a position from the available positions on the board."
  
        position = gets.chomp.to_i 
        if available_positions.include?(position)
          available_positions.delete(position)
          @board_positions[position - 1] = player.game_piece;
        
          check_if_winner(player)
          check_if_stalemate(available_positions)
          
          player == @p1 ? player = @p2 : player = @p1
        end
      end
  
      display_winner
    end
  
    def check_if_stalemate(available_positions)
      @game_over = true if available_positions.empty?
    end
  
    def check_if_winner(player)
      winning_combinations = [
        [0,1,2],
        [3,4,5],
        [6,7,8],
        [0,3,6],
        [1,4,7],
        [2,5,8],
        [0,4,8],
        [2,4,6]
      ]
  
      winning_combinations.each do |combination|
        arr = []
        combination.each do |position|
          arr << @board_positions[position]
        end
  
        if arr.join =~ /#{player.game_piece}{3}/
          @winner = player
          player.score += 1
          @game_over = true
        end
      end
    end
  
    def display_winner
      show_board
      unless @winner.nil?
        puts "#{@winner.name} is the winner"
      else
        puts "Game is a draw, no one wins"
      end
  
      puts "Would you like to play again? [Y/N]"
      if gets.chomp.upcase == 'Y'
        game = TicTacToe.new(@p1, @p2)
      else
        show_board
        puts "Thank you for playing!"
      end
    end
  
    
    def show_board
      clear
      row1 =   " #{@board_positions[0]} | #{@board_positions[1]} | #{@board_positions[2]} "
      row2 =   " #{@board_positions[3]} | #{@board_positions[4]} | #{@board_positions[5]} "
      row3 =   " #{@board_positions[6]} | #{@board_positions[7]} | #{@board_positions[8]} "
      divider ="---+---+---"
  
      puts "|=============================|"
      puts "|======== TIC TAC TOE ========|"
      puts "|=============================|"
      puts ''
      puts row1 +    "  | #{@p1.game_piece}: #{@p1.score}  (#{@p1.name})"
      puts divider + "  | #{@p2.game_piece}: #{@p2.score}  (#{@p2.name})" 
      puts row2 +    "  *----------------"
      puts divider
      puts row3
      puts ''
    end
  end
  
  class Player
    attr_accessor :name, :game_piece, :score
    
    @@other_game_piece = ""
  
    def initialize(player_number)
      set_player_name(player_number)
      set_game_piece
      @score = 0
    end
  
    private 
  
    def banner
      clear
      puts "|=============================|"
      puts "|==== Let the games begin ====|"
      puts "|=============================|"
      puts ''
    end
  
    def set_player_name(player_number)
      banner
      puts "Player #{player_number}: What is your name?"
      @name = gets.chomp
    end
  
    def set_game_piece
      piece_set = false
  
      until piece_set
        banner
        puts "#{@name}: Choose a single letter to represent your piece."
        puts "It cannot be #{@@other_game_piece}" if @@other_game_piece != ""
        @game_piece = gets.chomp.upcase
  
        if @game_piece =~ /^[A-Z]\b/ && @game_piece != @@other_game_piece
          @@other_game_piece = @game_piece
          piece_set = true
        else
          banner
          puts "Invalid piece, please choose a single letter"
          sleep(2)
        end
      end
    end
  end
  
  def clear
    print "\e[2J\e[H"
  end
  
  p1 = Player.new(1)
  p2 = Player.new(2)
  game = TicTacToe.new(p1, p2)