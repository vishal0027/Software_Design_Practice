note
	description: "Summary description for {TEST_SOLITAIRE_UI}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_SOLITAIRE_UI
inherit
	ES_TEST
create
	make
feature
	make
		do
			add_boolean_case (agent test)
			add_boolean_case (agent test_single_redo)
			add_boolean_case (agent test_multiple_undo_redo)
			add_boolean_case (agent t_33)
			add_boolean_case (agent t_34)
			add_boolean_case (agent t_35)
			add_boolean_case (agent t_36)
			add_boolean_case (agent t_37)
			add_boolean_case (agent t_38)
			add_boolean_case (agent move_left_messages)
		end
feature
	test: BOOLEAN
		local
			ui: SOLITAIRE_USER_INTERFACE
			bta: BOARD_TEMPLATES_ACCESS
			b1: BOARD
		do
			comment ("test_cross_game: undo")

			create ui.new_cross_game
			Result := ui.game.board ~ bta.templates.cross_board
			check Result end

			b1 := ui.game.board.deep_twin
			ui.move_left (3, 4)

			ui.undo
			Result :=
				ui.game.board ~ b1 and
				ui.message ~ ui.success
			check Result end
		end
	test_single_redo: BOOLEAN
		local
			ui: SOLITAIRE_USER_INTERFACE
			b_orig: BOARD
			b_undo: BOARD
		do
			comment ("test_game: single redo")
			-- MOVE LEFT
			create ui.new_cross_game
			b_orig := ui.game.board.deep_twin
			ui.move_left (3, 4)
			Result := ui.game.board /~ b_orig and ui.message ~ ui.success
			check
				Result
			end
			b_undo := ui.game.board.deep_twin
			ui.undo
			Result := ui.game.board ~ b_orig and ui.message ~ ui.success
			check
				Result
			end
			ui.redo
			Result := ui.game.board /~ b_orig and ui.game.board ~ b_undo and ui.message ~ ui.success
			check
				Result
			end

			-- MOVE RIGHT
			create ui.new_cross_game
			b_orig := ui.game.board.deep_twin
			ui.move_right (3, 4)
			Result := ui.game.board /~ b_orig and ui.message ~ ui.success
			check
				Result
			end
			b_undo := ui.game.board.deep_twin
			ui.undo
			Result := ui.game.board ~ b_orig and ui.message ~ ui.success
			check
				Result
			end
			ui.redo
			Result := ui.game.board /~ b_orig and ui.game.board ~ b_undo and ui.message ~ ui.success
			check
				Result
			end

			-- MOVE DOWN
			create ui.new_cross_game
			b_orig := ui.game.board.deep_twin
			ui.move_down (4, 4)
			Result := ui.game.board /~ b_orig and ui.message ~ ui.success
			check
				Result
			end
			b_undo := ui.game.board.deep_twin
			ui.undo
			Result := ui.game.board ~ b_orig and ui.message ~ ui.success
			check
				Result
			end
			ui.redo
			Result := ui.game.board /~ b_orig and ui.game.board ~ b_undo and ui.message ~ ui.success
			check
				Result
			end

			-- MOVE UP
			create ui.new_cross_game
			b_orig := ui.game.board.deep_twin
			ui.move_left (3, 4)
			Result := ui.game.board /~ b_orig and ui.message ~ ui.success
			check
				Result
			end
			b_undo := ui.game.board.deep_twin
			ui.undo
			Result := ui.game.board ~ b_orig and ui.message ~ ui.success
			check
				Result
			end
			ui.redo
			Result := ui.game.board /~ b_orig and ui.game.board ~ b_undo and ui.message ~ ui.success
			check
				Result
			end
		end

	test_multiple_undo_redo: BOOLEAN
		local
			ui: SOLITAIRE_USER_INTERFACE
			b_orig: BOARD
			b_undo: BOARD
			b_redo: BOARD
			b_new_history: BOARD
		do
			comment ("test_game: multiple undo and redo")
			create ui.new_cross_game

			b_orig := ui.game.board.deep_twin
			ui.move_left (3, 4)
			ui.move_up (5 , 4)

			b_undo := ui.game.board.deep_twin
			ui.move_left (3, 5)
			ui.move_right (3, 2)
			Result := ui.game.board /~ b_undo
			check Result end
			b_redo := ui.game.board.deep_twin

			ui.undo
			ui.undo
			Result := ui.game.board ~ b_undo
			check Result end

			ui.redo
			ui.redo
			Result := ui.game.board ~ b_redo
			check Result end


			ui.undo
			ui.undo
			ui.undo
			ui.undo
			Result := ui.game.board ~ b_orig and ui.message ~ ui.success
			check Result end

			ui.undo
			Result := ui.game.board ~ b_orig and ui.message ~ ui.error_nothing_to_undo
			check Result end


			ui.move_right (3, 4)
			b_new_history := ui.game.board.deep_twin
			ui.redo
			Result := ui.game.board ~ b_new_history and ui.message ~ ui.error_nothing_to_redo

		end

	t_33: BOOLEAN
      local
         ui: SOLITAIRE_USER_INTERFACE
      do
         comment ("t_33: violation msg for undo when hisory is empty")
         create ui.new_diamond_game
         ui.undo
         Result := ui.message ~ ui.error_nothing_to_undo
         check Result end
      end
     t_34: BOOLEAN
      local
         ui: SOLITAIRE_USER_INTERFACE
      do
         comment ("t_34: success msg for undo")
         create ui.new_diamond_game
         Result :=
            ui.game.board.out ~ "[
               **.O.**
               **OOO**
               .OOOOO.
               OOO.OOO
               .OOOOO.
               **OOO**
               **.O.**
               ]"
         check Result end

         ui.move_left (3, 3)

         ui.undo
         Result := ui.message ~ ui.success
      end

   t_35: BOOLEAN
      local
         ui: SOLITAIRE_USER_INTERFACE
      do
         comment ("t_35: violation msg for undo too many times")
         create ui.new_diamond_game
         Result :=
            ui.game.board.out ~ "[
               **.O.**
               **OOO**
               .OOOOO.
               OOO.OOO
               .OOOOO.
               **OOO**
               **.O.**
               ]"
         check Result end

         ui.move_left (3, 3)

         ui.undo
         ui.undo
         Result := ui.message ~ ui.error_nothing_to_undo
      end

feature -- Messages of redo

   t_36: BOOLEAN
      local
         ui: SOLITAIRE_USER_INTERFACE
      do
         comment ("t_36: violation msg for redo when hisory is empty")
         create ui.new_diamond_game
         ui.redo
         Result := ui.message ~ ui.error_nothing_to_redo
         check Result end
      end

   t_37: BOOLEAN
      local
         ui: SOLITAIRE_USER_INTERFACE
      do
         comment ("t_37: success msg for redo")
         create ui.new_diamond_game
         Result :=
            ui.game.board.out ~ "[
               **.O.**
               **OOO**
               .OOOOO.
               OOO.OOO
               .OOOOO.
               **OOO**
               **.O.**
               ]"
         check Result end

         ui.move_left (3, 3)

         ui.undo
         ui.redo
         Result := ui.message ~ ui.success
      end

   t_38: BOOLEAN
      local
         ui: SOLITAIRE_USER_INTERFACE
      do
         comment ("t_38: violation msg for redo too many times")
         create ui.new_diamond_game
         Result :=
            ui.game.board.out ~ "[
               **.O.**
               **OOO**
               .OOOOO.
               OOO.OOO
               .OOOOO.
               **OOO**
               **.O.**
               ]"
         check Result end

         ui.move_left (3, 3)

         ui.undo
         ui.redo
         ui.redo
         Result := ui.message ~ ui.error_nothing_to_redo
      end

move_left_messages: BOOLEAN
      local
         ui: SOLITAIRE_USER_INTERFACE
         ssa: SLOT_STATUS_ACCESS
      do
         comment("move_left_messages: possible messages for move_left")
         create ui.new_diamond_game
         Result :=
            ui.game.board.out ~ "[
               **.O.**
               **OOO**
               .OOOOO.
               OOO.OOO
               .OOOOO.
               **OOO**
               **.O.**
               ]"
         check Result end

         -- violating from_slot_valid_row
         ui.move_left (8, 9)
         Result := ui.message ~ ui.error_row_not_valid (8)
         check Result end

         -- violating from_slot_valid_column
         ui.move_left (7, 9)
         Result := ui.message ~ ui.error_column_not_valid (9)
         check Result end

         -- violating middle_slot_valid_column
         ui.move_left (7, 1)
         Result := ui.message ~ ui.error_column_not_valid (0)
         check Result end

         -- violating to_slot_valid_column
         ui.move_left (7, 2)
         Result := ui.message ~ ui.error_column_not_valid (0)
         check Result end

         -- violating from_slot_occupied
         ui.move_left (4, 4)
         Result := ui.message ~ ui.error_slot_not_of_status (4, 4, ssa.occupied_slot)
         check Result end

         -- violating middle_slot_occupied
         ui.move_left (2, 3)
         Result := ui.message ~ ui.error_slot_not_of_status (2, 2, ssa.occupied_slot)
         check Result end

         -- violating to_slot_unoccupied
         ui.move_left (3, 4)
         Result := ui.message ~ ui.error_slot_not_of_status (3, 2, ssa.unoccupied_slot)
         check Result end

         -- success
         ui.move_left (4, 6)
         Result := ui.message ~ ui.success
         check Result end
      end
end
