import { HardhatUserConfig } from "hardhat/config";
//import "@nomicfoundation/hardhat-toolbox-viem";

const config: HardhatUserConfig = {
  solidity: "0.8.20",
  networks: {
    sepolia: {
      url: `https://rpc.rolxtwo.evm.ra.blumbus.noisnemyd.xyz`,
      accounts: ["private_key"],
    },
  },
};

export default config;
