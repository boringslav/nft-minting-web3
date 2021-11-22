import { useState, useEffect } from "react";

function App() {
  const [currentAccount, setCurrentAccount] = useState("");

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
      console.err(err);
    }
  };

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
              onClick={null}
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
