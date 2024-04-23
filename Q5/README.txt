Placing the "spin_freeze.lua" file into a "theforgottenserver" "data/spells/scripts/attack/" folder
then adding the provided XML to the spells.xml file in "data/spells" should allow players to use "frigo"
after the server is restarted

<instant group="attack" spellid="171" name="Spin Freeze" words="frigo" level="1" mana="8" direction="8" cooldown="4000" groupcooldown="2000" needlearn="0" script="attack/spin_freeze.lua">
    <vocation name="Druid" />
    <vocation name="Elder Druid" />
    <vocation name="Sorcerer" />
    <vocation name="Master Sorcerer" />
    <vocation name="Knight" />
    <vocation name="Elite Knight" />
    <vocation name="Paladin" />
    <vocation name="Royal Paladin" />
</instant>
