#[starknet::interface]
pub trait IHelloStarknet<TContractState> {
    fn increase_balance(ref self: TContractState, amount: felt252);
    fn get_balance(self: @TContractState) -> felt252;

    fn set_data(ref self: TContractState, x: u128);
    fn get_data(self: @TContractState) -> u128;
    
    //adding user functions
    fn add_user(ref self: TContractState, name: felt252);
    fn get_user(self: @TContractState) -> felt252;

    //Geometric Calcualtions

    //rectangle
    fn rec_area(ref self: TContractState, width: u64, height: u64);
    fn get_rec_area(self: @TContractState) -> felt252;

    //circle
    fn circle_area(ref self: TContractState, radius: u64);
    fn get_circle(self: @TContractState) -> felt252; 
}

#[starknet::contract]
mod HelloStarknet {
    #[storage]
    struct Storage {
        balance: felt252,
        stored_data: u128,
        name: felt252, 
        width: u64,
        height: u64,
        radius: u64,
    }

    #[abi(embed_v0)]
    impl HelloStarknetImpl of super::IHelloStarknet<ContractState> {
        fn increase_balance(ref self: ContractState, amount: felt252) {
            assert(amount != 0, 'Amount cannot be 0');
            self.balance.write(self.balance.read() + amount);
        }

        fn get_balance(self: @ContractState) -> felt252 {
            self.balance.read()
        }


        fn set_data(ref self: ContractState, x: u128) {
            assert(x != 0, 'The value of x cannot be 0');
            self.stored_data.write(x);
        } 

        fn get_data(self: @ContractState) -> u128{
            self.stored_data.read()
        }

        //adding new function for the users here

        fn add_user(ref self: ContractState, name: felt252) {
            assert(name !='', 'Name cannot be null');
            self.name.write(name);
        }

        fn get_user(self: @ContractState) -> felt252{
            self.name.read()
        } 
       //adding the rectangle calculation
         fn rec_area(ref self: ContractState, width: u64, height: u64) {
            assert(width !='', 'width cannot be null');
            assert(height !='', 'height cannot be null');

            self.width.write(width);
            self.height.write(height);
        }

        fn get_rec_area(self: @ContractState) -> felt252{
           
            let width = self.width.read();
            let height = self.height.read();
            let rect_area: u64 = width * height;
            rect_area.into()
        } 

        //circle calculation 
        fn circle_area(ref self: ContractState, radius: u64){
            
            self.radius.write(radius);
        }  

        fn get_circle(self: @ContractState) -> felt252{
            let rad = self.radius.read();
            let area = 3 * rad * rad;
            area.into() 
        
        }

        
    }
}


//0x3677ca041c98ade5fb6b36a0bf9c733768d14e8767f70addd838fbe8e6dcdcf