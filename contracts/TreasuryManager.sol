// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/interfaces/IERC20.sol";
import "@openzeppelin/contracts/utils/structs/EnumerableSet.sol";

// pragma solidity >=0.5.0;
interface IUniswapV2Pair {
    event Approval(address indexed owner, address indexed spender, uint value);
    event Transfer(address indexed from, address indexed to, uint value);

    function name() external pure returns (string memory);
    function symbol() external pure returns (string memory);
    function decimals() external pure returns (uint8);
    function totalSupply() external view returns (uint);
    function balanceOf(address owner) external view returns (uint);
    function allowance(address owner, address spender) external view returns (uint);

    function approve(address spender, uint value) external returns (bool);
    function transfer(address to, uint value) external returns (bool);
    function transferFrom(address from, address to, uint value) external returns (bool);

    function DOMAIN_SEPARATOR() external view returns (bytes32);
    function PERMIT_TYPEHASH() external pure returns (bytes32);
    function nonces(address owner) external view returns (uint);

    function permit(address owner, address spender, uint value, uint deadline, uint8 v, bytes32 r, bytes32 s) external;

    event Mint(address indexed sender, uint amount0, uint amount1);
    event Burn(address indexed sender, uint amount0, uint amount1, address indexed to);
    event Swap(
        address indexed sender,
        uint amount0In,
        uint amount1In,
        uint amount0Out,
        uint amount1Out,
        address indexed to
    );
    event Sync(uint112 reserve0, uint112 reserve1);

    function MINIMUM_LIQUIDITY() external pure returns (uint);
    function factory() external view returns (address);
    function token0() external view returns (address);
    function token1() external view returns (address);
    function getReserves() external view returns (uint112 reserve0, uint112 reserve1, uint32 blockTimestampLast);
    function price0CumulativeLast() external view returns (uint);
    function price1CumulativeLast() external view returns (uint);
    function kLast() external view returns (uint);

    function mint(address to) external returns (uint liquidity);
    function burn(address to) external returns (uint amount0, uint amount1);
    function swap(uint amount0Out, uint amount1Out, address to, bytes calldata data) external;
    function skim(address to) external;
    function sync() external;

    function initialize(address, address) external;
}

// pragma solidity >=0.6.2;
interface IUniswapV2Router01 {
    function factory() external pure returns (address);
    function WETH() external pure returns (address);

    function addLiquidity(
        address tokenA,
        address tokenB,
        uint amountADesired,
        uint amountBDesired,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB, uint liquidity);
    function addLiquidityETH(
        address token,
        uint amountTokenDesired,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external payable returns (uint amountToken, uint amountETH, uint liquidity);
    function removeLiquidity(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB);
    function removeLiquidityETH(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external returns (uint amountToken, uint amountETH);
    function removeLiquidityWithPermit(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountA, uint amountB);
    function removeLiquidityETHWithPermit(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountToken, uint amountETH);
    function swapExactTokensForTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);
    function swapTokensForExactTokens(
        uint amountOut,
        uint amountInMax,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);
    function swapExactETHForTokens(uint amountOutMin, address[] calldata path, address to, uint deadline)
        external
        payable
        returns (uint[] memory amounts);
    function swapTokensForExactETH(uint amountOut, uint amountInMax, address[] calldata path, address to, uint deadline)
        external
        returns (uint[] memory amounts);
    function swapExactTokensForETH(uint amountIn, uint amountOutMin, address[] calldata path, address to, uint deadline)
        external
        returns (uint[] memory amounts);
    function swapETHForExactTokens(uint amountOut, address[] calldata path, address to, uint deadline)
        external
        payable
        returns (uint[] memory amounts);

    function quote(uint amountA, uint reserveA, uint reserveB) external pure returns (uint amountB);
    function getAmountOut(uint amountIn, uint reserveIn, uint reserveOut) external pure returns (uint amountOut);
    function getAmountIn(uint amountOut, uint reserveIn, uint reserveOut) external pure returns (uint amountIn);
    function getAmountsOut(uint amountIn, address[] calldata path) external view returns (uint[] memory amounts);
    function getAmountsIn(uint amountOut, address[] calldata path) external view returns (uint[] memory amounts);
}

// pragma solidity >=0.6.2;

interface IUniswapV2Router02 is IUniswapV2Router01 {
    function removeLiquidityETHSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external returns (uint amountETH);
    function removeLiquidityETHWithPermitSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountETH);

    function swapExactTokensForTokensSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
    function swapExactETHForTokensSupportingFeeOnTransferTokens(
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external payable;
    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
}

interface IUniswapV2Factory {
    event PairCreated(address indexed token0, address indexed token1, address pair, uint);

    function feeTo() external view returns (address);
    function feeToSetter() external view returns (address);

    function getPair(address tokenA, address tokenB) external view returns (address pair);
    function allPairs(uint) external view returns (address pair);
    function allPairsLength() external view returns (uint);

    function createPair(address tokenA, address tokenB) external returns (address pair);

    function setFeeTo(address) external;
    function setFeeToSetter(address) external;
}

contract TreasuryManager is Ownable {

  using EnumerableSet for EnumerableSet.AddressSet;
  EnumerableSet.AddressSet private _whitelist;

  bool public depositEnabled;
  mapping(address => uint256) public sharePerUser;
  mapping(address => mapping(address => uint256)) public amountsOfTokenPerUser;

  address public treasury;

  IUniswapV2Router02 public uniswapV2Router = IUniswapV2Router02(0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D);
  IUniswapV2Factory public uniswapV2Factory = IUniswapV2Factory(0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f);

  // Calculate price based on USDC
  address public targetToken;

  uint256 public cycling_round;
  uint256 public event_round;

  mapping(address => uint256) public lastWithdrawCycle;

  mapping(address => uint256) public tier1;
  mapping(address => uint256) public tier2;

  uint256 silver1_reward;
  uint256 gold1_reward;
  uint256 diamond1_reward;
  uint256 silver2_reward;
  uint256 gold2_reward;
  uint256 diamond2_reward;

  uint256 silver1_cnt;
  uint256 gold1_cnt;
  uint256 diamond1_cnt;
  uint256 silver2_cnt;
  uint256 silver2_ex_cnt;
  uint256 gold2_cnt;
  uint256 diamond2_cnt;

  uint256 public constant DIAMOND_AMOUNT = 1_000_000000;
  uint256 public constant GOLD_AMOUNT = 500_000000;
  uint256 public constant SILVER_AMOUNT = 100_000000;

  bool public dustingCycleOn;
  bool public dustingEventOn;

  constructor(address _targetToken) {
    targetToken = _targetToken;
  }

  function depositToken(address token, uint256 amount) external {
    require(dustingCycleOn, "Can deposit on cycle");
    IERC20(token).transferFrom(_msgSender(), treasury, amount);
    uint256 value = getQuantity(token, amount, targetToken);
    //if it's new deposit at this round
    if (tier1[_msgSender()] < cycling_round * 10) {
      sharePerUser[_msgSender()] = value;
    } else {
      uint256 tier = tier1[_msgSender()] % 10;
      if (tier == 1) silver1_cnt -= 1;
      else if (tier == 2) gold1_cnt -= 1;
      else if (tier == 3) diamond1_cnt -= 1;
      sharePerUser[_msgSender()] += value;
    }
    if (sharePerUser[_msgSender()] > DIAMOND_AMOUNT) {
      tier2[_msgSender()] = 1 + 10 * event_round;
      tier1[_msgSender()] = 10 * cycling_round;
      silver2_ex_cnt ++;
      silver2_cnt ++;
    }
    else if (sharePerUser[_msgSender()] > GOLD_AMOUNT) {
      tier1[_msgSender()] = 3 + 10 * cycling_round;
      diamond1_cnt ++;
    }
    else if (sharePerUser[_msgSender()] > SILVER_AMOUNT) {
      tier1[_msgSender()] = 2 + 10 * cycling_round;
      gold1_cnt ++;
    }
    else {
      tier1[_msgSender()] = 1 + 10 * cycling_round;
      silver1_cnt ++;
    }
        
    amountsOfTokenPerUser[_msgSender()][token] += amount;
  }

  function getQuantity(address outputToken, uint256 outputAmount, address anchorToken) public view returns (uint256) {
    uint256 quantity = 0;
    if (outputToken == anchorToken) {
      quantity = outputAmount;
    } else if (uniswapV2Factory.getPair(outputToken, anchorToken) != address(0)) {
      address pair = uniswapV2Factory.getPair(outputToken, anchorToken);
      (uint112 reserve0, uint112 reserve1,) = IUniswapV2Pair(pair).getReserves();
      (uint112 reserveIn, uint112 reserveOut) = outputToken < anchorToken ? (reserve0, reserve1) : (reserve1, reserve0);
      quantity = uniswapV2Router.getAmountOut(outputAmount, reserveIn, reserveOut);
    } else {
      uint256 length = getWhitelistLength();
      for (uint256 index = 0; index < length; index++) {
        address intermediate = getWhitelist(index);
        if (uniswapV2Factory.getPair(outputToken, intermediate) != address(0) && uniswapV2Factory.getPair(intermediate, anchorToken) != address(0)) {
          address pair = uniswapV2Factory.getPair(outputToken, intermediate);
          (uint112 reserve0, uint112 reserve1,) = IUniswapV2Pair(pair).getReserves();
          (uint112 reserveIn, uint112 reserveOut) = outputToken < intermediate ? (reserve0, reserve1) : (reserve1, reserve0);
          uint256 interQuantity = uniswapV2Router.getAmountOut(outputAmount, reserveIn, reserveOut);
          address pair2 = uniswapV2Factory.getPair(intermediate, anchorToken);
          (reserve0, reserve1, ) = IUniswapV2Pair(pair2).getReserves();
          (reserveIn, reserveOut) = intermediate < anchorToken ? (reserve0, reserve1) : (reserve1, reserve0);
          quantity = uniswapV2Router.getAmountOut(interQuantity, reserveIn, reserveOut);
          break;
        }
      }
    }
    return quantity;
  }
      
  function depositETH() external payable onlyOwner {
  }
  
  function setTier2Members(address[] calldata _silver, address[] calldata _gold, address[] calldata _diamond) external onlyOwner {
    event_round += 1;

    uint256 length = _silver.length;
    for (uint256 i = 0; i < length; i++)
      tier2[_silver[i]] = event_round * 10 + 1;
    silver2_cnt = silver2_ex_cnt + length;
    length = _gold.length;
    for (uint256 i = 0; i < length; i++)
      tier2[_gold[i]] = event_round * 10 + 2;
    gold2_cnt = length;
    length = _diamond.length;
    for (uint256 i = 0; i < length; i++)
      tier2[_diamond[i]] = event_round * 10 + 3;
    diamond2_cnt = length;
  }

  function claimReward() public {
    require(dustingEventOn, "Can deposit on event");
    require(lastWithdrawCycle[_msgSender()] < cycling_round, "Already Claimed");
    lastWithdrawCycle[_msgSender()] = cycling_round;
    uint256 amount = getRewardAmount(_msgSender());
    (bool success, ) = msg.sender.call{value:amount}("");
    require(success, "Failed to send CRO");
  }

  function getRewardAmount(address _contributor) public view returns (uint256) {
    uint256 tier1_base = cycling_round * 10;
    uint256 tier2_base = event_round * 10;
    uint256 amount = 0;
    if (tier1[_contributor] == tier1_base + 1) 
      amount = silver1_reward;
    else if (tier1[_contributor] == tier1_base + 2)
      amount = gold1_reward;
    else if (tier1[_contributor] == tier1_base + 3)
      amount = diamond1_reward;

    if (tier2[_contributor] == tier2_base + 1)
      amount += silver2_reward;
    else if (tier2[_contributor] == tier2_base + 2)
      amount += gold2_reward;
    else if (tier2[_contributor] == tier2_base + 3)
      amount += diamond2_reward;
    return amount;
  }

  function isTier1(address _user) public view returns (uint) {
    uint256 tier = 0;
    uint256 tier1_base = cycling_round * 10;
    if (tier1[_user] == tier1_base + 1) 
      tier = 1;
    else if (tier1[_user] == tier1_base + 2)
      tier = 2;
    else if (tier1[_user] == tier1_base + 3)
      tier = 3;
    return tier;
  }

  function isTier2(address _user) public view returns (uint) {
    uint256 tier = 0;
    uint256 tier1_base = event_round * 10;
    if (tier1[_user] == tier1_base + 1) 
      tier = 1;
    else if (tier1[_user] == tier1_base + 2)
      tier = 2;
    else if (tier1[_user] == tier1_base + 3)
      tier = 3;
    return tier;
  }

  function startDustingCycle() external onlyOwner {
    require(dustingEventOn == false, "Event should off");
    dustingCycleOn = true;
    silver1_cnt = gold1_cnt = diamond1_cnt = 0;
    cycling_round += 1;
  }

  function finishDustingCycle() external onlyOwner {
    dustingCycleOn = false;
  }

  function startDustingEvent() external onlyOwner {
    require(dustingCycleOn == false, "Event should off");
    dustingEventOn = true;
    uint256 totalBalance = address(this).balance;
    silver1_reward = totalBalance * 10 / 100 / silver1_cnt;
    gold1_reward = totalBalance * 20 / 100 / gold1_cnt;
    diamond1_reward = totalBalance * 35 / 100 / diamond1_cnt;
    silver2_reward = totalBalance * 5 / 100 / silver2_cnt;
    gold2_reward = totalBalance * 10 / 100 / gold2_cnt;
    diamond2_reward = totalBalance * 20 / 100 / diamond2_cnt;
  }

  function finishDustingEvent() external onlyOwner {
    dustingEventOn = false;
  }

  // Only tokens in the whitelist can be mined MDX
  function addWhitelist(address _addToken) public onlyOwner returns (bool) {
    require(_addToken != address(0), "token is the zero address");
    return EnumerableSet.add(_whitelist, _addToken);
  }

  function delWhitelist(address _delToken) public onlyOwner returns (bool) {
    require(_delToken != address(0), "token is the zero address");
    return EnumerableSet.remove(_whitelist, _delToken);
  }

  function getWhitelistLength() public view returns (uint256) {
    return EnumerableSet.length(_whitelist);
  }

  function isWhitelist(address _token) public view returns (bool) {
    return EnumerableSet.contains(_whitelist, _token);
  }

  function getWhitelist(uint256 _index) public view returns (address){
    require(_index <= getWhitelistLength() - 1, "index out of bounds");
    return EnumerableSet.at(_whitelist, _index);
  }
}