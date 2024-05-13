import { ethers } from "hardhat";

async function main() {
    const MyContract = await ethers.getContractFactory("Roulette");
    const myContract = await MyContract.deploy();

    console.log("MyContract deployed to:", myContract.address);
}

main()
    .then(() => process.exit(0))
    .catch(error => {
        console.error(error);
        process.exit(1);
    });
