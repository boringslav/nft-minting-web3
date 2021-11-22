import { ethers } from "ethers";
import { useState, useEffect } from "react";
import myNFT from './utils/NFT.json'; //get the abi file from artficts and add it to /utils dir

function App() {
  const [currentAccount, setCurrentAccount] = useState("");
  const CONTRACT_ADDRESS = "0x064a65144Dd209756346254FdB2eD6577d69dF97";
  useEffect(() => {
    checkIfWalletIsConnected();
  }, []);

  const checkIfWalletIsConnected = async () => {
    const { ethereum } = window;
    if (!ethereum) {
      console.log("Make sure you have metamask!");
      return;
    }
    console.log("We have the ethereum object", ethereum);

    // Check if we're authorized to access the user's wallet
    const accounts = await ethereum.request({ method: "eth_accounts" });

    //User can have multiple authorized accounts, we grab the first one if its there!
    if (accounts.length !== 0) {
      const account = accounts[0];
      console.log("Found an authorized account:", account);
      // setCurrentAccount(account)
    } else {
      console.log("No authorized account found");
    }
  };

  const connectWallet = async () => {
    try {
      const { ethereum } = window;

      if (!ethereum) alert("Get MetaMask!");

      // Request access to ethereum account
      const accounts = await ethereum.request({
        method: "eth_requestAccounts",
      });
      accounts.at(0);

      console.log("Connected", accounts.at(0));

      setCurrentAccount(accounts.at(0));
    } catch (err) {
      console.error(err);
    }
  };

  const askContractToMintNFT = async () => {
    try {
      const { ethereum } = window;
      if (ethereum) {
        const provider = new ethers.providers.Web3Provider(ethereum);
        const signer = provider.getSigner();
        const connectedContract = new ethers.Contract(CONTRACT_ADDRESS, myNFT.abi, signer);

        console.log("Going to pop wallet now to pay gas...");

        let nftTxn = await connectedContract.createNFT();

        console.log("Mining...please wait.")
        await nftTxn.wait();

        console.log(`Mined, see transaction: https://rinkeby.etherscan.io/tx/${nftTxn.hash}`);

      } else {
        console.log("Ethereum object doesn't exist!");
      }

    } catch (err) {
      console.error(err);
    }

  }

  const renderNotConnectedContainer = () => (
    <button
      onClick={connectWallet}
      class="mt-5 p-3 border-2 border-pink-400 rounded-lg font-bold text-white text-xxl cursor-pointer"
    >
      Connect to Wallet
    </button>
  );

  return (
    <div class="h-screen w-screen bg-gray-700 overflow-y-auto">
      <div class="h-full flex flex-row justify-center  w-full">
        <div class="pt-4">
          <p class="m-0 p-3 text-4xl font-bold text-pink-400">
            My NFT Collection
          </p>
          <p class="px-2 text-xl text-white ">
            Each unique. Each beautiful. Discover your NFT today.
          </p>
          {currentAccount === "" ? (
            renderNotConnectedContainer()
          ) : (
            <button
              onClick={askContractToMintNFT}
              class="mt-5 p-3 border-2 border-pink-400 rounded-lg font-bold text-white text-xxl cursor-pointer"
            >
              Mint NFT
            </button>
          )}
        </div>
      </div>
    </div>
  );
}

export default App;
