import { ethers } from "ethers";
import { useState, useEffect } from "react";
import Title from "./components/Title";
import myNFT from './utils/NFT.json'; //get the abi file from artficts and add it to /utils dir

function App() {
  const [currentAccount, setCurrentAccount] = useState("");
  const CONTRACT_ADDRESS = "0x6A81056b297F46c10898144dB2A0CA01E4B454Bd";
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
      setCurrentAccount(account);

      // Setup listener! This is for the case where a user comes to our site
      // and ALREADY had their wallet connected + authorized.
      setupEventListener();
    } else {
      console.log("No authorized account found");
    }
  };
  const setupEventListener = async () => {
    try {
      const { ethereum } = window;

      if (ethereum) {
        const provider = new ethers.providers.Web3Provider(ethereum);
        const signer = provider.getSigner();
        const connectedContract = new ethers.Contract(CONTRACT_ADDRESS, myNFT.abi, signer);

        // This will essentially "capture" our event when our contract throws it.
        connectedContract.on("NewNFTMinted", (from, tokenId) => {
          console.log(from, tokenId.toNumber())
          alert(`Hey there! We've minted your NFT and sent it to your wallet. It may be blank right now. It can take a max of 10 min to show up on OpenSea. Here's the link: https://rinkeby.rarible.com/token/${CONTRACT_ADDRESS}:${tokenId.toNumber()}`)
        });

      } else {
        console.log("Ethereum object doesn't exist!");
      }
    } catch (error) {
      console.log(error)
    }
  }

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
          <Title />
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
