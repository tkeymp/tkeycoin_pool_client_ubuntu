connect=3.15.45.237:8333
reward_address=qMKSHAeyWvCTLb9tBzES5tbPMgantChnMh

screen -L -dmS pool_client sudo ./pool_client $connect $reward_address
echo Use \"screen -r pool_client\" for attach to pool_client screen
