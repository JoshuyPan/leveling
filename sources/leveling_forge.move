module leveling::forge{

    use leveling::equip::{Self};
    use leveling::user::{Self, User};

    public entry fun forge_sword(user: &mut User, ctx: &mut TxContext) {
        let copper = b"Copper Ore".to_string();
        let iron = b"Iron Ore".to_string();

        assert!(user.get_user_level() > 1);
        assert!(user.check_if_user_own_mineral(copper));
        assert!(user.check_if_user_own_mineral(iron));
        
        let copperAmount: u64 = user.check_mineral_amount(copper);
        let ironOreAmount: u64 = user.check_mineral_amount(iron);
        let allowed: bool = (copperAmount >= 1 && ironOreAmount >= 1);

        if(allowed){
            let sword = equip::create_equip(ctx, b"Special Sword".to_string(), 30, 5, 2, 1, 255);
            user.add_equip(sword, ctx);
        }else {
            abort(0)
        }
    }
}