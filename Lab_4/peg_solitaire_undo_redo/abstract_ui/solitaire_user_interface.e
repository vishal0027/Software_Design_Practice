note
	description: "Summary description for {SOLITAIRE_USER_INTERFACE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SOLITAIRE_USER_INTERFACE

create
	new_cross_game,
	new_plus_game,
	new_pyramid_game,
	new_arrow_game,
	new_diamond_game,
	new_skull_game

feature -- Attributes
	ga: GAME_ACCESS
	game: GAME
	history: HISTORY
	message: STRING

feature -- Events
	new_cross_game
			-- Start a cross game.
		do

			create history.make
			game := ga.game
			game.make_cross
			message := success
		end

	new_plus_game
			-- Start a plus game.
		do

			create history.make
			game := ga.game
			game.make_plus
			message := success
		end

	new_pyramid_game
			-- Start a pyramid game.
		do

			create history.make
			game := ga.game
			game.make_pyramid
			message := success
		end

	new_arrow_game
			-- Start a new arrow game.
		do

			create history.make
			game := ga.game
			game.make_arrow
			message := success
		end

	new_diamond_game
			-- Start a new diamond game.
		do

			create history.make
			game := ga.game
			game.make_diamond
			message := success
		end

	new_skull_game
			-- Start a new skull game.
		do

			create history.make
			game := ga.game
			game.make_skull
			message := success
		end

	move_left (r, c: INTEGER)
			-- User decides to move slot at (r, c) left.
		local
			left : COMMAND_MOVE_LEFT
		do
			-- Error reporting should be done here
			-- before you invoke the corresponding game feature.1
			create left.make (r, c)
			if current.game.board.is_valid_row (r) and
				current.game.board.is_valid_column (c) and
				current.game.board.is_valid_column (c - 1) and
				current.game.board.is_valid_column (c - 2) and
				current.game.board.status_of (r, c).is_equal (ga.game.board.occupied_slot) and
				current.game.board.status_of (r , c - 1).is_equal (ga.game.board.occupied_slot) and
				current.game.board.status_of (r, c - 2).is_equal (ga.game.board.unoccupied_slot) then
				--{	
					history.extend_history (left)
					history.item.execute
					message := success --}
			else
				if not ga.game.board.is_valid_row (r) then message := error_row_not_valid (r)
				elseif not ga.game.board.is_valid_column (c) then message := error_column_not_valid (c)
				elseif not ga.game.board.is_valid_column (c - 1) then message := error_column_not_valid (c - 1)
				elseif not ga.game.board.is_valid_column (c - 2) then message := error_column_not_valid (c - 2)
				elseif not ga.game.board.status_of (r, c).is_equal (ga.game.board.occupied_slot) then message := error_slot_not_of_status (r, c, ga.game.board.occupied_slot)
				elseif not ga.game.board.status_of (r , c - 1).is_equal (ga.game.board.occupied_slot) then message := error_slot_not_of_status (r, c - 1, ga.game.board.occupied_slot)
				elseif not ga.game.board.status_of (r, c - 2).is_equal (ga.game.board.unoccupied_slot) then message := error_slot_not_of_status (r, c - 2, ga.game.board.unoccupied_slot) end

			end
		end

	move_right (r, c: INTEGER)
			-- User decides to move slot at (r, c) right.
		local
			right : COMMAND_MOVE_RIGHT
		do
			-- Error reporting should be done here  ??
			-- before you invoke the corresponding game feature.
			create right.make(r,c)
			if current.game.board.is_valid_row (r) and
				current.game.board.is_valid_column (c) and
				current.game.board.is_valid_column (c + 1) and
				current.game.board.is_valid_column (c + 2) and
				current.game.board.status_of (r, c).is_equal (ga.game.board.occupied_slot) and
				current.game.board.status_of (r , c + 1).is_equal (ga.game.board.occupied_slot) and
				current.game.board.status_of (r, c + 2).is_equal (ga.game.board.unoccupied_slot) then
				--{	
					history.extend_history (right)
					history.item.execute
					message := success --}
			else
				if not ga.game.board.is_valid_row (r) then message := error_row_not_valid (r)
				elseif not ga.game.board.is_valid_column (c) then message := error_column_not_valid (c)
				elseif not ga.game.board.is_valid_column (c + 1) then message := error_column_not_valid (c + 1)
				elseif not ga.game.board.is_valid_column (c + 2) then message := error_column_not_valid (c + 2)
				elseif not ga.game.board.status_of (r, c).is_equal (ga.game.board.occupied_slot) then message := error_slot_not_of_status (r, c, ga.game.board.occupied_slot)
				elseif not ga.game.board.status_of (r , c + 1).is_equal (ga.game.board.occupied_slot) then message := error_slot_not_of_status (r, c + 1, ga.game.board.occupied_slot)
				elseif not ga.game.board.status_of (r, c + 2).is_equal (ga.game.board.unoccupied_slot) then message := error_slot_not_of_status (r, c + 2, ga.game.board.unoccupied_slot) end

			end
		end

	move_up (r, c: INTEGER)
			-- User decides to move slot at (r, c) up.
		local
			up : COMMAND_MOVE_UP
		do
			-- Error reporting should be done here
			-- before you invoke the corresponding game feature.
			create up.make(r,c)
			if current.game.board.is_valid_row (r) and
				current.game.board.is_valid_column (c) and
				current.game.board.is_valid_row (r - 1) and
				current.game.board.is_valid_row (r - 2) and
				current.game.board.status_of (r, c).is_equal (ga.game.board.occupied_slot) and
				current.game.board.status_of (r - 1 , c).is_equal (ga.game.board.occupied_slot) and
				current.game.board.status_of (r - 2, c).is_equal (ga.game.board.unoccupied_slot) then
			--{
					history.extend_history (up)
					history.item.execute
					message := success --}

			else

				if not ga.game.board.is_valid_row (r) then message := error_row_not_valid (r)
				elseif not ga.game.board.is_valid_column (c) then message := error_column_not_valid (c)
				elseif not ga.game.board.is_valid_row (r - 1) then message := error_row_not_valid (r - 1)
				elseif not ga.game.board.is_valid_row (r - 2) then message := error_row_not_valid (r - 2)
				elseif not ga.game.board.status_of (r, c).is_equal (ga.game.board.occupied_slot) then message := error_slot_not_of_status (r, c, ga.game.board.occupied_slot)
				elseif not ga.game.board.status_of (r - 1 , c).is_equal (ga.game.board.occupied_slot) then message := error_slot_not_of_status (r - 1, c, ga.game.board.occupied_slot)
				elseif not ga.game.board.status_of (r - 2, c ).is_equal (ga.game.board.unoccupied_slot) then message := error_slot_not_of_status (r - 2, c, ga.game.board.unoccupied_slot) end

			end
		end

	move_down (r, c: INTEGER)
			-- User decides to move slot at (r, c) down.
		local
			down : COMMAND_MOVE_DOWN
		do
			-- Error reporting should be done here
			-- before you invoke the corresponding game feature.
			create down.make(r,c)
			if current.game.board.is_valid_row (r) and
					current.game.board.is_valid_column (c) and
					current.game.board.is_valid_row (r + 1) and
					current.game.board.is_valid_row (r + 2) and
					current.game.board.status_of (r, c).is_equal (ga.game.board.occupied_slot) and
					current.game.board.status_of (r + 1 , c).is_equal (ga.game.board.occupied_slot) and
					current.game.board.status_of (r + 2, c).is_equal (ga.game.board.unoccupied_slot) then
				--{
						history.extend_history (down)
						history.item.execute
						message := success --}

				else

					if not ga.game.board.is_valid_row (r) then message := error_row_not_valid (r)
					elseif not ga.game.board.is_valid_column (c) then message := error_column_not_valid (c)
					elseif not ga.game.board.is_valid_row (r + 1) then message := error_row_not_valid (r + 1)
					elseif not ga.game.board.is_valid_row (r + 2) then message := error_row_not_valid (r + 2)
					elseif not ga.game.board.status_of (r, c).is_equal (ga.game.board.occupied_slot) then message := error_slot_not_of_status (r, c, ga.game.board.occupied_slot)
					elseif not ga.game.board.status_of (r + 1 , c).is_equal (ga.game.board.occupied_slot) then message := error_slot_not_of_status (r + 1, c, ga.game.board.occupied_slot)
					elseif not ga.game.board.status_of (r + 2, c ).is_equal (ga.game.board.unoccupied_slot) then message := error_slot_not_of_status (r + 2, c, ga.game.board.unoccupied_slot) end

				end
		end

	undo
			-- Undo the last command not yet undone, if any.
		do
			-- Error reporting should be done here.
			if history.on_item then
				history.item.undo
				history.back
				message := success
			else
				message := error_nothing_to_undo
			end
		end

	redo
			-- Redo the next command not yet redone, if any.
		do
			-- Error reporting should be done here.
			if not history.is_last then
				history.forth
				history.item.redo
				message := success
			else
				message := error_nothing_to_redo
			end
		end

feature -- Messages
	success: STRING
		do
			Result := "Operation successfully completed."
		end

	error_row_not_valid (r: INTEGER): STRING
		do
			create Result.make_from_string (
				"Row " + r.out + " is not valid.")
		end

	error_column_not_valid (c: INTEGER): STRING
		do
			create Result.make_from_string (
				"Column " + c.out + " is not valid.")
		end

	error_slot_not_of_status (r, c: INTEGER; status: SLOT_STATUS): STRING
		do
			create Result.make_from_string (
				"Slot at (" + r.out + ", " + c.out +
					") is not " + status.out)
		end

	error_nothing_to_undo: STRING
		do
			Result := "Nothing to undo."
		end

	error_nothing_to_redo: STRING
		do
			Result := "Nothing to redo."
		end
end
