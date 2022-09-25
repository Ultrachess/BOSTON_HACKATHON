# Copyright 2022 Cartesi Pte. Ltd.
#
# SPDX-License-Identifier: Apache-2.0
# Licensed under the Apache License, Version 2.0 (the "License"); you may not use
# this file except in compliance with the License. You may obtain a copy of the
# License at http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software distributed
# under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
# CONDITIONS OF ANY KIND, either express or implied. See the License for the
# specific language governing permissions and limitations under the License.

from os import environ
import subprocess
import logging
import requests
import json
import numpy as np 
import cv2
import pyautogui
import pyscreenrec
import time



gameState = {
    "Games": {},
    "Accounts" :{}
}

resolution = (1920, 1080)
filename = "output.mp4"
fps = 60


betNumber = 0

# Default header for ERC-20 transfers coming from the Portal, which corresponds
# to the Keccak256-encoded string "ERC20_Transfer", as defined at
# https://github.com/cartesi/rollups/blob/main/onchain/rollups/contracts/facets/ERC20PortalFacet.sol.
ERC20_TRANSFER_HEADER =  b'Y\xda*\x98N\x16Z\xe4H|\x99\xe5\xd1\xdc\xa7\xe0L\x8a\x990\x1b\xe6\xbc\t)2\xcb]\x7f\x03Cx'
# Function selector to be called during the execution of a voucher that transfers funds,
# which corresponds to the first 4 bytes of the Keccak256-encoded result of "transfer(address,uint256)"
TRANSFER_FUNCTION_SELECTOR = b'\xa9\x05\x9c\xbb'

def str2hex(str):
    """
    Encode a string as an hex string
    """
    return "0x" + str.encode("utf-8").hex()

def reject_input(msg, payload):
    logger.error(msg)
    response = requests.post(rollup_server + "/report", json={"payload": payload})
    logger.info(f"Received report status {response.status_code} body {response.content}")
    return "reject"

logging.basicConfig(level="INFO")
logger = logging.getLogger(__name__)

rollup_server = environ["ROLLUP_HTTP_SERVER_URL"]
logger.info(f"HTTP rollup_server url is {rollup_server}")

def handle_advance(data):
    
    #get data
    metadata = data["metadata"]

    payload = data["payload"][2:]

    logger.info(data)
    sender = metadata["msg_sender"]

    content = (bytes.fromhex(payload).decode("utf-8"))
    logger.info(content)
    jsonFile = json.loads(content)
    operator = jsonFile["operator"]
    value = jsonFile["value"]

    #check if deposit call
    if sender == rollup_address:
        binary = bytes.fromhex(data["payload"][2:])
        decoded = decode_abi(['bytes32', 'address', 'address', 'uint256', 'bytes'], binary)
        input_header = decoded[0]
        if input_header != ERC20_TRANSFER_HEADER:
            return reject_input(f"Input header is not from an ERC20 transfer", data["payload"])
        depositor = decoded[1]
        erc20 = decoded[2]
        amount = decoded[3]
        operator = "deposit"
        sender = depositor
        value = {
            "tokenAmount": amount,
            "tokenAddr": erc20.lower(),
        }

    #run state
    run(sender, operator, value)
    

    #log
    logger.info(f"Received advance request data {data}")
    logger.info("Adding notice")
    notice = {"payload": data["payload"]}
    response = requests.post(rollup_server + "/notice", json=notice)
    logger.info(f"Received notice status {response.status_code} body {response.content}")

    logger.info(str(gameState))
    return "accept"



def run(sender, operator, value):
   
    if operator == "initGame":
        gameId = value["gameID"]
        botID1 = value["botID1"]
        botID2 = value["botID2"]
        initGame(sender, botID1, botID2, gameId)
        return
    elif operator == "startGame":
        gameID = value["gameID"]
        startGame(sender, gameID)
        return
    elif operator == "deposit":
        amount = value["amount"]
        tokenAddr = value["tokenAddr"]
        deposit(sender, amount, tokenAddr)
        return
    elif operator == "withdraw":
        amount = value["amount"]
        tokenAddr = tokenAddr["tokenAddr"]
        withdraw(sender, amount, tokenAddr)
        return
    elif operator == "bet":
        gameID = value["gameID"]
        amount = value["amount"]
        tokenAddr = value["tokenAddr"]
        botId = value["botId"]
        bet(sender, gameID, amount, tokenAddr, botId)
        return

def initGame(sender, botID1, botID2, gameID):
    game = {
        "gameID": gameID,
        "phase": "initGame",
        "botID1": botID1,
        "botID2": botID2,
        "bets": []
    }
    gameState["Games"][gameID] = game

def startGame(sender, gameID):
    botID1 = gameState["Games"][gameID]["botID1"]
    botID2 = gameState["Games"][gameID]["botID2"]


    recorder = pyscreenrec.ScreenRecorder()
    recorder.start_recording(str(gameID)+".mp4", 20) 
    
    strman = "./bin/Ikemen_GO_Linux -p1 " + str(botID1) + " -p1.ai 8 -p2 " + str(botID2) + " -p2.ai 8 -rounds 1 -speed 200 -log gameResult.txt"
    logger.info(strman)
    subprocess.run(strman, shell=True)
    # with open('gameResult.txt', 'r') as file:
    #     fileString = file.read().replace('\n', '')
    # botId2WinState = find
    recorder.stop_recording()





def deposit(sender, amount, tokenAddr):
    gameState["Accounts"][sender][tokenAddr] = amount
    return

def withdraw(sender, amount, tokenAddr):
   
   tokenBalance = gameState["Accounts"][sender][tokenAddr]
   if tokenBalance >= amount:
        #output here
        gameState["Accounts"][sender][tokenAddr] = tokenBalance - amount


def bet(sender, gameID, amount, tokenAddr, botID):
    
#    account_balance = gameState["Accounts"][sender][tokenAddr]
   
#    if account_balance < amount:
#         return
#    else:
        bet = {
        "Sender": sender,
        "gameID": gameID,
        "botID": botID,
        "amount": amount,
        "tokenName": tokenAddr
        }

        gameState["Games"][gameID]["bets"].append(bet) 




def handle_inspect(data):
    logger.info(f"Received inspect request data {data}")
    logger.info("Adding report")
    report = {"payload": data["payload"]}
    response = requests.post(rollup_server + "/report", json=report)
    logger.info(f"Received report status {response.status_code}")
    return "accept"

handlers = {
    "advance_state": handle_advance,
    "inspect_state": handle_inspect,
}

finish = {"status": "accept"}
rollup_address = None

while True:
    logger.info("Sending finish")
    response = requests.post(rollup_server + "/finish", json=finish)
    logger.info(f"Received finish status {response.status_code}")
    if response.status_code == 202:
        logger.info("No pending rollup request, trying again")
    else:
        rollup_request = response.json()
        data = rollup_request["data"]
        if "metadata" in data:
            metadata = data["metadata"]
            if metadata["epoch_index"] == 0 and metadata["input_index"] == 0:
                rollup_address = metadata["msg_sender"]
                logger.info(f"Captured rollup address: {rollup_address}")
                continue
        handler = handlers[rollup_request["request_type"]]
        finish["status"] = handler(rollup_request["data"])