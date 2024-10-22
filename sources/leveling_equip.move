module leveling::equip {

    use std::string::{Self, String};

    use leveling::resources::{Self, Mineral};

    //Rarity Constants
    const COMMON: u8 = 1;
    const NORMAL: u8 = 2;
    const UNUSUAL: u8 = 3;
    const RARE: u8 = 4;
    const LEGENDARY: u8 = 5;
    const ARTIFACT: u8 = 6;

    public struct Equip has key, store {
        id: UID,
        name: String,
        //add table field for: Head, Hands, Shoulders, Chest, Legs, Boots, Nackle, Earring
        hpBonus: u64,
        manaBonus: u64,
        level: u8,
        rarity: u8,
        durability: u8,
    }

    public fun create_equip(
        ctx: &mut TxContext, 
        name: String, 
        hpBonus: u64, 
        manaBonus: u64,
        level: u8, 
        rarity: u8,
        durability: u8,

        ): Equip {
        Equip{
            id: sui::object::new(ctx),
            name,
            hpBonus,
            manaBonus,
            level,
            rarity,
            durability
        }
    }

    //Getters
    public fun get_equip_name(equip: &Equip): String {
        return equip.name
    }

    public fun get_equip_hp(equip: &Equip): u64 {
        return equip.hpBonus
    }

    public fun get_equip_mana(equip: &Equip): u64 {
        return equip.manaBonus
    }

    public fun get_equip_level(equip: &Equip): u8 {
        return equip.level
    }

    public fun get_equip_rarity(equip: &Equip): u8 {
        return equip.rarity
    }

    public fun get_equip_durability(equip: &Equip): u8 {
        return equip.durability
    }
}