-- $Id: //depot/Projects/StarWars/Run/Data/Scripts/Story/Story_Campaign_Empire_Act_IV.lua#6 $
--/////////////////////////////////////////////////////////////////////////////////////////////////
--
-- (C) Petroglyph Games, Inc.
--
--
--  *****           **                          *                   *
--  *   **          *                           *                   *
--  *    *          *                           *                   *
--  *    *          *     *                 *   *          *        *
--  *   *     *** ******  * **  ****      ***   * *      * *****    * ***
--  *  **    *  *   *     **   *   **   **  *   *  *    * **   **   **   *
--  ***     *****   *     *   *     *  *    *   *  *   **  *    *   *    *
--  *       *       *     *   *     *  *    *   *   *  *   *    *   *    *
--  *       *       *     *   *     *  *    *   *   * **   *   *    *    *
--  *       **       *    *   **   *   **   *   *    **    *  *     *   *
-- **        ****     **  *    ****     *****   *    **    ***      *   *
--                                          *        *     *
--                                          *        *     *
--                                          *       *      *
--                                      *  *        *      *
--                                      ****       *       *
--
--/////////////////////////////////////////////////////////////////////////////////////////////////
-- C O N F I D E N T I A L   S O U R C E   C O D E -- D O   N O T   D I S T R I B U T E
--/////////////////////////////////////////////////////////////////////////////////////////////////
--
--              $File: //depot/Projects/StarWars/Run/Data/Scripts/Story/Story_Campaign_Empire_Act_IV.lua $
--
--    Original Author: Steve_Copeland
--
--            $Author: Joseph_Gernert $
--
--            $Change: 28987 $
--
--          $DateTime: 2005/10/12 10:59:33 $
--
--          $Revision: #6 $
--
--/////////////////////////////////////////////////////////////////////////////////////////////////

require("PGStoryMode")

--
-- Definitions -- This function is called once when the script is first created.
-- 
function Definitions()

	DebugMessage("%s -- In Definitions", tostring(Script))
	
	StoryModeEvents = 
	{
		Empire_ActIV_Mission_Twelve_01 = State_Empire_ActIV_Mission_Twelve_01
	}
	
	-- For memory pool cleanup hints
	yavin = nil
	alzoc3 = nil
	shola = nil
	hoth = nil
	polus = nil
	planet_table = nil
	empire_player = nil
end

function State_Empire_ActIV_Mission_Twelve_01(message)
	if message == OnEnter then
		--MessageBox("Empire_ActIV_Mission_Twelve_01")
		yavin = FindPlanet("Yavin")
		alzoc3 = FindPlanet("AlzocIII")
		shola = FindPlanet("Shola")
		hoth = FindPlanet("Hoth")
		polus = FindPlanet("Polus")
		empire_player = Find_Player("Empire")
		plot = Get_Story_Plot("Story_Campaign_Empire_Act_IV.xml")
		if plot then
			event = plot.Get_Event("Empire_ActIV_Mission_Twelve_Stage_End_Game")
		end
		if not yavin or not alzoc3 or not shola or not hoth or not polus or not empire_player or not plot or not event then
			--MessageBox("error: didn't find all needed uservars")
		else
			planet_table = {[yavin] = false, 
							[alzoc3] = false,
							[shola] = false,
							[hoth] = false,
							[polus] = false}
		end
	end
end


function Story_Mode_Service()

	if planet_table then
		--MessageBox("Story_Mode_Service")

		-- Update the table if any of the final planets have ever been conquered.
		-- Track the count of conquered planets and retain any unconquered planet.
		-- Note that we're ignoring if the Empire later lost the system.
		conquered_count = 0
		for planet, was_conquered in pairs(planet_table) do
			if was_conquered then
				conquered_count = conquered_count + 1
			else
				if planet.Get_Owner() == empire_player then
					planet_table[planet] = true
					conquered_count = conquered_count + 1
				else
					unconquered_planet = planet
				end
			end
		end
		
		-- If 4 of 5 systems have been conquered, the last planet stages the end game.
		if conquered_count == 4 then
			--MessageBox("Setting up end game system on: %s", tostring(unconquered_planet))
			event.Set_Event_Parameter(1, unconquered_planet)
			Story_Event("TRIGGER_MISSION_12_END_GAME")
			ScriptExit()
		end
	end
end
