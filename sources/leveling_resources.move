module leveling::resources {

    //Rarity Constants
    const COMMON: u8 = 1;
    const NORMAL: u8 = 2;
    const UNUSUAL: u8 = 3;
    const RARE: u8 = 4;
    const LEGENDARY: u8 = 5;
    const ARTIFACT: u8 = 6;

    use std::string::{String};

    public struct Mineral has store, key {
        id: UID,
        name: String,
        rarity: u8,
        amount: u64,
        difficulty: u8
    }

    //Mineral getters
    public fun get_mineral_name(mineral: &Mineral): String {
        return mineral.name
    }

    public fun get_mineral_rarity(mineral: &Mineral): u8 {
        return mineral.rarity
    }

    public fun get_mineral_amount(mineral: &Mineral): u64 {
        return mineral.amount
    }

    public fun get_mineral_difficulty(mineral: &Mineral): u8 {
        return mineral.difficulty
    }

    //Mineral send or burn
    public fun burn_mineral(mineral: Mineral) {
        transfer::transfer(mineral, @0x0);
    }

    public fun send_mineral(mineral: Mineral, receiver: address) {
        transfer::transfer(mineral, receiver)
    }

    //Setters
    public fun add_amount(mineral: &mut Mineral, amount: u64) {
        mineral.amount = mineral.amount + amount;
    }

    public fun sub_amount(mineral: &mut Mineral, amount: u64) {
        mineral.amount = mineral.amount - amount;
    }

    //Minerals
    //Commons_mineral
    //Difficulty -> 1 to 10
    public fun new_copper_ore(amount: u64, ctx: &mut TxContext): Mineral {
        Mineral {
            id: sui::object::new(ctx),
            name: b"Copper Ore".to_string(),
            rarity: COMMON,
            amount: amount,
            difficulty: 10
        }
    }

    //Normal
    //Difficulty -> 11 to 20
    public fun new_iron_ore(amount: u64, ctx: &mut TxContext): Mineral {
        Mineral {
            id: sui::object::new(ctx),
            name: b"Iron Ore".to_string(),
            rarity: NORMAL,
            amount: amount,
            difficulty: 14
        }
    }

    //Unusual
    //DIfficulty -> 21 to 30
    public fun new_silver_ore(amount: u64, ctx: &mut TxContext): Mineral {
        Mineral {
            id: sui::object::new(ctx),
            name: b"Silver Ore".to_string(),
            rarity: UNUSUAL,
            amount: amount,
            difficulty: 23
        }
    }

    //Rare
    //DIfficulty -> 31 to 40
    public fun new_gold_ore(amount: u64, ctx: &mut TxContext): Mineral {
        Mineral {
            id: sui::object::new(ctx),
            name: b"Gold Ore".to_string(),
            rarity: RARE,
            amount: amount,
            difficulty: 38
        }
    }

    //Legendary
    //DIfficulty -> 41 to 50
    public fun new_titanium_ore(amount: u64, ctx: &mut TxContext): Mineral {
        Mineral {
            id: sui::object::new(ctx),
            name: b"Titanium Ore".to_string(),
            rarity: LEGENDARY,
            amount: amount,
            difficulty: 46
        }
    }

    //Artifact
    //DIfficulty -> 60+
    public fun new_diamond_gem(amount: u64, ctx: &mut TxContext): Mineral {
        Mineral {
            id: sui::object::new(ctx),
            name: b"Diamond Gem".to_string(),
            rarity: ARTIFACT,
            amount: amount,
            difficulty: 68
        }
    }

}