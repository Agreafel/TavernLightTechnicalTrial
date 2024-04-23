local combat = Combat()


-- Needs a custom area to make the shape from the example video
-- This was an approximation to hold place
-- until the animation tools were to be found
AREA_CUSTOM3x3 = {
	{0, 0, 0, 1, 0, 0, 0},
	{0, 1, 1, 1, 1, 1, 0},
	{0, 1, 1, 1, 1, 1, 0},
	{1, 1, 1, 2, 1, 1, 1},
	{0, 1, 1, 1, 1, 0, 0},
	{0, 1, 1, 1, 1, 1, 0},
	{0, 0, 0, 1, 0, 0, 0},
}
-- The type is frost as it is related to the other 'frigo' spells
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
-- Grabbing the frost tornados here
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ICETORNADO)
combat:setArea(createCombatArea(AREA_CUSTOM3x3))

-- I believe the below is what determines damage and 
function onGetFormulaValues(player, level, magicLevel)
	local min = 4000
	local max = 4000
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

--the application of damage
function onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end

-- In my 5 hours of available time for this question,
-- I was not able to find the animation tools to create the spinning effect

-- I believe the below is for compiling the server, I have not made time to attempt
-- It was faster to edit the xml and restart the server application
-- 
-- local spell = Spell(200) 
-- function onCastSpell(creature, variant)
-- 	return combat:execute(creature, variant)
-- end
-- spell:name("Spin Freeze")
-- spell:spellid(200)
-- spell:group("attack")
-- spell:vocation(
-- 		"Druid", "Elder Druid",
-- 		"Sorcerer", "Master Sorcerer",
-- 		"Paladin", "Royal Paladin",
-- 		"Knight", "Elite Knight")
-- spell:words("frigo")
-- spell:level(1) 
-- spell:mana(8)
-- spell:direction(8)
-- spell:cooldown(4000)
-- spell:groupcooldown(2000)
-- spell:needlearn(false)
-- spell:register()


-- XML to add to spells.xml
-- <instant group="attack" spellid="171" name="Spin Freeze" words="frigo" level="1" mana="8" direction="8" cooldown="4000" groupcooldown="2000" needlearn="0" script="attack/spin_freeze.lua">
-- 	<vocation name="Druid" />
-- 	<vocation name="Elder Druid" />
-- 	<vocation name="Sorcerer" />
-- 	<vocation name="Master Sorcerer" />
-- 	<vocation name="Knight" />
-- 	<vocation name="Elite Knight" />
-- 	<vocation name="Paladin" />
-- 	<vocation name="Royal Paladin" />
-- </instant>
