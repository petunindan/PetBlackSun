-- $Id: //depot/Projects/StarWars/Run/Data/Scripts/AI/GenerateMagicSpaceDefenseEasy.lua#2 $
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
--              $File: //depot/Projects/StarWars/Run/Data/Scripts/AI/GenerateMagicSpaceDefenseEasy.lua $
--
--    Original Author: James Yarrow
--
--            $Author: James_Yarrow $
--
--            $Change: 36287 $
--
--          $DateTime: 2006/01/12 11:12:55 $
--
--          $Revision: #2 $
--
--/////////////////////////////////////////////////////////////////////////////////////////////////

require("pgevents")


function Definitions()	
	Category = "Generate_Magic_Space_Defense_Easy"
	IgnoreTarget = true
	
	TaskForce = {
	{
		"ReserveForce"
		,"DenyHeroAttach"
		,"Fighter | Bomber = 2"
		,"Corvette | Frigate = 1"
	}
	}
	AllowFreeStoreUnits = false
	MagicPlan = true
	MagicPlanStealing = false
end

function ReserveForce_Thread()		
	ReserveForce.Set_As_Goal_System_Removable(false)
	BlockOnCommand(ReserveForce.Produce_Force(Target))
	ReserveForce.Set_Plan_Result(true)	
	
	--Sleep forever on easy so that we can't repeat the spawn
	while true do
		Sleep(1)
	end
	
	ScriptExit()
end