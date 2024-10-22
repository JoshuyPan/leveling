module leveling::game {
    use leveling::resources::{Self, Mineral};
    use leveling::user::{Self, User};

    public entry fun level_one(
        user: &mut User,
        ctx: &mut TxContext
    ){
        assert!(tx_context::sender(ctx) == user.get_user_address());
        let reward: Mineral = resources::new_copper_ore(2, ctx);
        let amountXP: u64 = 100;

        //Level logic
        let userHp = user.get_user_hp();
        let userEnergy = user.get_user_energy();
        let damage = 70;
        let energyCost = 15;

        if((userHp > damage + 1) && (userEnergy > energyCost)){
            user.set_user_hp(userHp - damage);
            user.set_user_energy(userEnergy - energyCost);

            user.add_xp_and_check_level(amountXP);
            user.add_mineral(reward, ctx)
        } else {
            abort(0)
        }

    }

    public entry fun level_two(
        user: &mut User,
        ctx: &mut TxContext
    ){
        assert!(tx_context::sender(ctx) == user.get_user_address());
        let reward: Mineral = resources::new_iron_ore(5, ctx);
        let amountXP: u64 = 130;

        //level logic
        let userHp = user.get_user_hp();
        let userEnergy = user.get_user_energy();
        let damage = 90;
        let energyCost = 15;

        if((userHp > damage + 1) && (userEnergy > energyCost) && (user.get_user_level() > 1)){
            user.set_user_hp(userHp - damage);
            user.set_user_energy(userEnergy - energyCost);

            user.add_xp_and_check_level(amountXP);
            user.add_mineral(reward, ctx);
        } else {
            abort(0)
        }
    }

    //IMPLEMENT THE FORGE AND THE WELL FOR THE HP
}