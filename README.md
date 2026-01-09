<p align="center">
  <img src="canary/canary.png" alt="Canary Logo" width="21%">
</p>

# Canary for MyNode

MyNode app package for [Canary](https://github.com/schjonhaug/canary) - a Bitcoin wallet monitoring and early warning system.

## Building from source

1. Install the [MyNode SDK](https://github.com/mynodebtc/mynode_sdk):
   ```
   pip3 install mynodesdk
   ```

2. Clone this repository and `cd` into it.

3. Build the package:
   ```
   mynode-sdk build canary
   ```

4. The resulting `canary.tar.gz` can be uploaded to MyNode via **Marketplace → Add Application**.
