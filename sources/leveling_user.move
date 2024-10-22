module leveling::user{

    use std::string::{Self, String};

    use leveling::resources::{Self, Mineral};
    use leveling::equip::{Self, Equip};

    public struct User has key {
        id: UID,
        username: String,
        address: address,
        hp: u64,
        mana: u64,
        energy: u8,
        level: u8,
        xp: u64,
        minerals: vector<Mineral>,
        equip: vector<Equip>
    }

    //TODO: ADD THE GETTERS FOR MINERALS VECTOR AND FOR EQUIP VECTOR 

    public entry fun create_user(username: String, ctx: &mut TxContext){
        transfer::transfer(User {
            id: sui::object::new(ctx),
            username: username,
            address: tx_context::sender(ctx),
            hp: 300,
            mana: 100,
            energy: 100,
            level: 1,
            xp: 0,
            minerals: vector::empty(),
            equip: vector::empty()
        }
        , tx_context::sender(ctx))
    }

    public entry fun transfer_whole_mineral(
        user: &mut User, 
        mineral: Mineral,
        receiver: address,
        ctx: &mut TxContext
    ){
        assert!(tx_context::sender(ctx) == user.address, 1);
        mineral.send_mineral(receiver);
    }

    public entry fun transfer_some_mineral(
        user: &mut User,
        mineral: String,
        amountToSend: u64,
        receiver: &mut User,
        ctx: &mut TxContext
    )
    {
        assert!(tx_context::sender(ctx) == user.get_user_address());
        let mut userMinerals = &mut user.minerals;
        let mut i = 0;

        while(userMinerals.length() < i){
            let currentMineralName = userMinerals[i].get_mineral_name();
            if(currentMineralName == mineral){
                let amount = userMinerals[i].get_mineral_amount();
                if(amount < amountToSend) {
                    abort(0)
                }else{
                    userMinerals[i].sub_amount(amountToSend);
                    let mut receiverMinerals = &mut receiver.minerals;
                    let mut j = 0;
                    let mut found = false;

                    while(receiverMinerals.length() < j){
                        let currentReceiverMineralName = receiverMinerals[j].get_mineral_name();
                        if(currentReceiverMineralName == mineral){
                            found = true;
                            receiverMinerals[j].add_amount(amountToSend);
                        };
                        j = j + 1;
                    };

                    if(found == false){
                        let mut newMineral: Mineral;

                        if(mineral == b"Copper Ore".to_string()){
                            newMineral = resources::new_copper_ore(amountToSend, ctx);
                            receiver.add_mineral(newMineral, ctx);
                            return
                        };
                        if(mineral == b"Iron Ore".to_string()){
                            newMineral = resources::new_iron_ore(amountToSend, ctx);
                            receiver.add_mineral(newMineral, ctx);
                            return
                        };
                        if(mineral == b"Silver Ore".to_string()){
                            newMineral = resources::new_silver_ore(amountToSend, ctx);
                            receiver.add_mineral(newMineral, ctx);
                            return
                        };
                        if(mineral == b"Gold Ore".to_string()){
                            newMineral = resources::new_gold_ore(amountToSend, ctx);
                            receiver.add_mineral(newMineral, ctx);
                            return
                        };
                        if(mineral == b"Titanium Ore".to_string()){
                            newMineral = resources::new_titanium_ore(amountToSend, ctx);
                            receiver.add_mineral(newMineral, ctx);
                            return
                        };
                        if(mineral == b"Diamond Gem".to_string()){
                            newMineral = resources::new_diamond_gem(amountToSend, ctx);
                            receiver.add_mineral(newMineral, ctx);
                            return
                        };

                    }
                }
            };
            i = i + 1;
        }
    }

    // Getters

    public fun get_username(user: &User): String {
        return user.username
    }

    public fun get_user_address(user: &User): address{
        return user.address
    }

    public fun get_user_level(user: &User): u8 {
        return user.level
    }

    public fun get_user_xp(user: &User): u64 {
        return user.xp
    }

    public fun get_user_hp(user: &User): u64 {
        return user.hp
    }

    public fun get_user_mana(user: &User): u64 {
        return user.mana
    }

    public fun get_user_energy(user: &User): u8 {
        return user.energy
    }

    public fun get_mineral_index(user: &User, mineral: String): u64 {
        let mut i = 0;
        while (user.minerals.length() < i){
            if(user.minerals[i].get_mineral_name() == mineral){
                return i
            };
            i = i + 1;
        };
        abort(0)
    }

    public fun check_if_user_own_mineral(user: &User, mineral: String): bool {
        let mut i = 0;
        while (user.minerals.length() < i){
            if(user.minerals[i].get_mineral_name() == mineral){
                return true
            };
            i = i + 1;
        };
        return false
    }

    public fun check_mineral_amount(user: &User, mineral: String): u64 {
        let mut i = 0;
        while (user.minerals.length() < i){
            if(user.minerals[i].get_mineral_name() == mineral){
                return user.minerals[i].get_mineral_amount()
            };
            i = i + 1;
        };
        abort(0)
    }

    // Setters

    public fun set_username(user: &mut User, username: String, ctx: &mut TxContext) {
        assert!(user.address == tx_context::sender(ctx));
        user.username = username;
    }

    public fun set_user_hp(user: &mut User, amount: u64){
        user.hp = amount;
    }

    public fun set_user_mana(user: &mut User, amount: u64){
        user.mana = amount;
    }

    public fun set_user_energy(user: &mut User, amount: u8) {
        user.energy = amount;
    }

    public fun check_levelup(user: &mut User) {
        if(user.xp < 200){
            return
        };
        if(user.xp < 300){
            user.level = 2;
            user.hp = user.hp + 200;
            user.mana = user.mana + 100;
            user.energy = 100;
            return
        };
        if(user.xp < 400){
            user.level = 3;
            user.hp = user.hp + 300;
            user.mana = user.mana + 150;
            user.energy = 100;
            return
        };
        if(user.xp < 500){
            user.level = 4;
            user.hp = user.hp + 400;
            user.mana = user.mana + 200;
            user.energy = 100;
            return
        };
        if(user.xp < 600){
            user.level = 5;
            user.hp = user.hp + 500;
            user.mana = user.mana + 250;
            user.energy = 100;
            return
        };
    }

    public fun add_xp(user: &mut User, amount: u64) {
        user.xp = user.xp + amount;
    }

    public fun add_xp_and_check_level(user: &mut User, amount: u64){
        add_xp(user, amount);
        check_levelup(user);
    }

    public fun recover_full_hp(user: &mut User){
        if(user.xp < 200){
            let actualHP = user.get_user_hp();
            let hpToAdd = 300 - actualHP;
            let energyCost = 10;
            let userEnergy = user.get_user_energy();

            if(userEnergy < energyCost){
                return
            }else{
                user.set_user_energy(userEnergy - energyCost); 
                user.set_user_hp(hpToAdd);
                return
            }       
        };
        if(user.xp < 300){
            let actualHP = user.get_user_hp();
            let hpToAdd = 500 - actualHP;
            let energyCost = 10;
            let userEnergy = user.get_user_energy();

            if(userEnergy < energyCost){
                return
            }else{
                user.set_user_energy(userEnergy - energyCost); 
                user.set_user_hp(hpToAdd);
                return
            }  
        };
        if(user.xp < 400){
            let actualHP = user.get_user_hp();
            let hpToAdd = 800 - actualHP;
            let energyCost = 10;
            let userEnergy = user.get_user_energy();

            if(userEnergy < energyCost){
                return
            }else{
                user.set_user_energy(userEnergy - energyCost); 
                user.set_user_hp(hpToAdd);
                return
            }  
        };
        if(user.xp < 500){
            let actualHP = user.get_user_hp();
            let hpToAdd = 1200 - actualHP;
            let energyCost = 10;
            let userEnergy = user.get_user_energy();

            if(userEnergy < energyCost){
                return
            }else{
                user.set_user_energy(userEnergy - energyCost); 
                user.set_user_hp(hpToAdd);
                return
            }  
        };
        if(user.xp < 600){
            let actualHP = user.get_user_hp();
            let hpToAdd = 1700 - actualHP;
            let energyCost = 10;
            let userEnergy = user.get_user_energy();

            if(userEnergy < energyCost){
                return
            }else{
                user.set_user_energy(userEnergy - energyCost); 
                user.set_user_hp(hpToAdd);
                return
            }  
        };
    }

    public fun add_mineral(user: &mut User, mineral: Mineral, ctx: &mut TxContext) {
        assert!(tx_context::sender(ctx) == user.address);
        //TODO: check if the owner of the mineral is also the sender of the tx

        user.minerals.push_back(mineral);
    }

    public fun increment_mineral(user: &mut User, mineral: String, amount: u64){
        assert!(user.check_if_user_own_mineral(mineral));
        let i = user.get_mineral_index(mineral);
        user.minerals[i].add_amount(amount);
    }

    public fun add_equip(user: &mut User, equip: Equip, ctx: &mut TxContext) {
        assert!(tx_context::sender(ctx) == user.address);
        //TODO: check if the owner of the mineral is also the sender of the tx

        user.equip.push_back(equip);
    }
}
